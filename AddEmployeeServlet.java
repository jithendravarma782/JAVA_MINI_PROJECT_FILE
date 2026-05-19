package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {
    
    // Method to validate name (only letters and spaces)
    private boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return name.matches("^[A-Za-z\\s]+$");
    }
    
    // Method to validate salary (must be > 0)
    private boolean isValidSalary(BigDecimal salary) {
        if (salary == null) {
            return false;
        }
        return salary.compareTo(BigDecimal.ZERO) > 0;
    }
    
    // Method to capitalize first letter of each word
    private String capitalizeName(String name) {
        String[] words = name.trim().split("\\s+");
        StringBuilder capitalized = new StringBuilder();
        
        for (String word : words) {
            if (word.length() > 0) {
                capitalized.append(Character.toUpperCase(word.charAt(0)))
                          .append(word.substring(1).toLowerCase())
                          .append(" ");
            }
        }
        
        return capitalized.toString().trim();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String employeeId = request.getParameter("employeeId");
            String name = request.getParameter("name");
            String department = request.getParameter("department");
            String designation = request.getParameter("designation");
            String salaryStr = request.getParameter("salary");
            String joiningDateStr = request.getParameter("joiningDate");
            
            // Validate name
            if (!isValidName(name)) {
                request.setAttribute("message", "❌ Invalid Name! Name should contain only letters (A-Z, a-z) and spaces!");
                request.getRequestDispatcher("empadd.jsp").forward(request, response);
                return;
            }
            
            // Validate salary
            BigDecimal salary = null;
            try {
                salary = new BigDecimal(salaryStr);
                if (!isValidSalary(salary)) {
                    request.setAttribute("message", "❌ Invalid Salary! Salary must be greater than zero!");
                    request.getRequestDispatcher("empadd.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("message", "❌ Invalid Salary! Please enter a valid numeric amount!");
                request.getRequestDispatcher("empadd.jsp").forward(request, response);
                return;
            }
            
            // Check if salary is within reasonable range (optional)
            if (salary.compareTo(new BigDecimal("10000000")) > 0) {
                request.setAttribute("message", "❌ Salary is too high! Maximum salary allowed is ₹1,00,00,000");
                request.getRequestDispatcher("empadd.jsp").forward(request, response);
                return;
            }
            
            // Capitalize the name
            name = capitalizeName(name);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date joiningDate = sdf.parse(joiningDateStr);
            
            // Check if employee ID already exists
            EmployeeDAO dao = new EmployeeDAO();
            Employee existingEmp = dao.getEmployeeByEmployeeId(employeeId);
            
            if (existingEmp != null) {
                request.setAttribute("message", "❌ Employee ID '" + employeeId + "' already exists!");
                request.getRequestDispatcher("empadd.jsp").forward(request, response);
                return;
            }
            
            Employee employee = new Employee();
            employee.setEmployeeId(employeeId);
            employee.setName(name);
            employee.setDepartment(department);
            employee.setDesignation(designation);
            employee.setSalary(salary);
            employee.setJoiningDate(joiningDate);
            
            boolean success = dao.addEmployee(employee);
            
            if (success) {
                request.setAttribute("message", "✅ Employee added successfully! ID: " + employeeId);
            } else {
                request.setAttribute("message", "❌ Failed to add employee!");
            }
        } catch (Exception e) {
            request.setAttribute("message", "❌ Error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("empadd.jsp").forward(request, response);
    }
}
package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {
    
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
            int id = Integer.parseInt(request.getParameter("id"));
            String employeeId = request.getParameter("employeeId");
            String name = request.getParameter("name");
            String department = request.getParameter("department");
            String designation = request.getParameter("designation");
            String salaryStr = request.getParameter("salary");
            String joiningDateStr = request.getParameter("joiningDate");
            
            // Validate name
            if (!isValidName(name)) {
                // Get the employee again to show in form
                EmployeeDAO dao = new EmployeeDAO();
                Employee emp = dao.getEmployeeByEmployeeId(employeeId);
                request.setAttribute("employee", emp);
                request.setAttribute("message", "❌ Invalid Name! Name should contain only letters (A-Z, a-z) and spaces!");
                request.getRequestDispatcher("empupdate.jsp").forward(request, response);
                return;
            }
            
            // Validate salary
            BigDecimal salary = null;
            try {
                salary = new BigDecimal(salaryStr);
                if (!isValidSalary(salary)) {
                    EmployeeDAO dao = new EmployeeDAO();
                    Employee emp = dao.getEmployeeByEmployeeId(employeeId);
                    request.setAttribute("employee", emp);
                    request.setAttribute("message", "❌ Invalid Salary! Salary must be greater than zero!");
                    request.getRequestDispatcher("empupdate.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                EmployeeDAO dao = new EmployeeDAO();
                Employee emp = dao.getEmployeeByEmployeeId(employeeId);
                request.setAttribute("employee", emp);
                request.setAttribute("message", "❌ Invalid Salary! Please enter a valid numeric amount!");
                request.getRequestDispatcher("empupdate.jsp").forward(request, response);
                return;
            }
            
            // Check if salary is within reasonable range (optional)
            if (salary.compareTo(new BigDecimal("10000000")) > 0) {
                EmployeeDAO dao = new EmployeeDAO();
                Employee emp = dao.getEmployeeByEmployeeId(employeeId);
                request.setAttribute("employee", emp);
                request.setAttribute("message", "❌ Salary is too high! Maximum salary allowed is ₹1,00,00,000");
                request.getRequestDispatcher("empupdate.jsp").forward(request, response);
                return;
            }
            
            // Capitalize the name
            name = capitalizeName(name);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            Employee employee = new Employee();
            employee.setId(id);
            employee.setEmployeeId(employeeId);
            employee.setName(name);
            employee.setDepartment(department);
            employee.setDesignation(designation);
            employee.setSalary(salary);
            employee.setJoiningDate(sdf.parse(joiningDateStr));
            
            EmployeeDAO dao = new EmployeeDAO();
            boolean success = dao.updateEmployee(employee);
            
            if (success) {
                request.setAttribute("message", "✅ Employee updated successfully!");
                // Get updated employee details
                Employee updatedEmp = dao.getEmployeeByEmployeeId(employeeId);
                request.setAttribute("employee", updatedEmp);
            } else {
                request.setAttribute("message", "❌ Failed to update employee!");
            }
        } catch (Exception e) {
            request.setAttribute("message", "❌ Error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        if (employeeId != null && !employeeId.trim().isEmpty()) {
            EmployeeDAO dao = new EmployeeDAO();
            Employee emp = dao.getEmployeeByEmployeeId(employeeId);
            request.setAttribute("employee", emp);
        }
        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }
}
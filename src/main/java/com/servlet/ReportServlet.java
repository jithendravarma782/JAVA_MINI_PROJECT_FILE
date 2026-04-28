package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        EmployeeDAO dao = new EmployeeDAO();
        List<Employee> employees = null;
        String reportTitle = "";
        
        try {
            switch (reportType) {
                case "nameStart":
                    String letter = request.getParameter("letter");
                    employees = dao.getEmployeesByNameStart(letter);
                    reportTitle = "Employees whose names start with '" + letter + "'";
                    break;
                    
                case "serviceYears":
                    int years = Integer.parseInt(request.getParameter("years"));
                    employees = dao.getEmployeesByServiceYears(years);
                    reportTitle = "Employees with " + years + " or more years of service";
                    break;
                    
                case "minSalary":
                    double salary = Double.parseDouble(request.getParameter("salary"));
                    employees = dao.getEmployeesByMinSalary(salary);
                    reportTitle = "Employees earning more than ₹" + String.format("%,.2f", salary);
                    break;
                    
                default:
                    employees = dao.getAllEmployees();
                    reportTitle = "All Employees";
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }
        
        request.setAttribute("reportTitle", reportTitle);
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }
}
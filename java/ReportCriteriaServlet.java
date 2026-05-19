package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/reportCriteria")
public class ReportCriteriaServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        EmployeeDAO dao = new EmployeeDAO();
        
        try {
            // Report 1: Search by First Letter
            if ("firstLetter".equals(reportType)) {
                String letter = request.getParameter("letter").toUpperCase();
                List<Employee> employees = dao.getEmployeesByFirstLetter(letter);
                request.setAttribute("employees", employees);
                request.setAttribute("reportTitle", "🔤 Employees whose name starts with '" + letter + "'");
                request.setAttribute("reportType", "firstLetter");
                request.setAttribute("searchLetter", letter);
            }
            
            // Report 2: Salary Range Report
            else if ("salaryRange".equals(reportType)) {
                BigDecimal minSalary = new BigDecimal(request.getParameter("minSalary"));
                BigDecimal maxSalary = new BigDecimal(request.getParameter("maxSalary"));
                List<Employee> employees = dao.getEmployeesBySalaryRange(minSalary, maxSalary);
                request.setAttribute("employees", employees);
                request.setAttribute("reportTitle", "💰 Employees with Salary Between ₹" + minSalary + " and ₹" + maxSalary);
                request.setAttribute("reportType", "salaryRange");
                request.setAttribute("minSalary", minSalary);
                request.setAttribute("maxSalary", maxSalary);
            }
            
            // Report 3: Experience Years Report
            else if ("experienceYears".equals(reportType)) {
                String experienceLevel = request.getParameter("experienceLevel");
                List<Employee> employees = dao.getEmployeesByExperienceYears(experienceLevel);
                request.setAttribute("employees", employees);
                request.setAttribute("reportTitle", "📅 Employees with Experience: " + getExperienceLabel(experienceLevel));
                request.setAttribute("reportType", "experienceYears");
            }
            
            // Report 4: Full Salary Range (Min to Max)
            else if ("fullSalaryRange".equals(reportType)) {
                BigDecimal minSalary = dao.getMinSalary();
                BigDecimal maxSalary = dao.getMaxSalary();
                List<Employee> employees = dao.getAllEmployees();
                request.setAttribute("employees", employees);
                request.setAttribute("minSalary", minSalary);
                request.setAttribute("maxSalary", maxSalary);
                request.setAttribute("reportTitle", "📊 Complete Salary Range (₹" + minSalary + " - ₹" + maxSalary + ")");
                request.setAttribute("reportType", "fullSalaryRange");
            }
            
            // Report 5: Department-wise Report
            else if ("department".equals(reportType)) {
                String department = request.getParameter("department");
                List<Employee> employees = dao.getEmployeesByDepartment(department);
                request.setAttribute("employees", employees);
                request.setAttribute("reportTitle", "🏢 Employees in " + department + " Department");
                request.setAttribute("reportType", "department");
            }
            
            // Report 6: Summary Report
            else if ("summary".equals(reportType)) {
                double avgSalary = dao.getAverageSalary();
                int totalEmployees = dao.getTotalEmployeeCount();
                BigDecimal totalSalary = dao.getTotalSalarySum();
                BigDecimal maxSalary = dao.getMaxSalary();
                BigDecimal minSalary = dao.getMinSalary();
                
                request.setAttribute("avgSalary", avgSalary);
                request.setAttribute("totalEmployees", totalEmployees);
                request.setAttribute("totalSalary", totalSalary);
                request.setAttribute("maxSalary", maxSalary);
                request.setAttribute("minSalary", minSalary);
                request.setAttribute("reportTitle", "📈 Salary Summary Report");
                request.setAttribute("reportType", "summary");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    private String getExperienceLabel(String experience) {
        switch(experience) {
            case "0-1": return "Less than 1 year";
            case "1-3": return "1 - 3 years";
            case "3-5": return "3 - 5 years";
            case "5-10": return "5 - 10 years";
            case "10+": return "10+ years";
            default: return experience;
        }
    }
}
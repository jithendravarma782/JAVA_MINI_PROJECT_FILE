<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Employee" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        h2 {
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }
        
        .report-title {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stat-label {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .search-info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            overflow-x: auto;
            display: block;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background: #667eea;
            color: white;
            font-weight: 600;
        }
        
        tr:hover {
            background: #f5f5f5;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            text-align: center;
            width: 100%;
            color: #667eea;
            text-decoration: none;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .experience-badge {
            background: #4CAF50;
            color: white;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            th, td {
                padding: 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📊 Report Results</h2>
        <div class="report-title">
            <%= request.getAttribute("reportTitle") != null ? request.getAttribute("reportTitle") : "Salary Report" %>
        </div>
        
        <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
        %>
            <div class="error">
                <%= error %>
            </div>
        <%
        }
        
        String reportType = (String) request.getAttribute("reportType");
        
        // Summary Report
        if ("summary".equals(reportType)) {
            Double avgSalary = (Double) request.getAttribute("avgSalary");
            Integer totalEmployees = (Integer) request.getAttribute("totalEmployees");
            BigDecimal totalSalary = (BigDecimal) request.getAttribute("totalSalary");
            BigDecimal maxSalary = (BigDecimal) request.getAttribute("maxSalary");
            BigDecimal minSalary = (BigDecimal) request.getAttribute("minSalary");
            DecimalFormat df = new DecimalFormat("#,##0.00");
        %>
            <div class="stats-summary">
                <div class="stat-box">
                    <div class="stat-label">Total Employees</div>
                    <div class="stat-value"><%= totalEmployees %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Average Salary</div>
                    <div class="stat-value">₹ <%= df.format(avgSalary) %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Total Salary Budget</div>
                    <div class="stat-value">₹ <%= df.format(totalSalary) %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Highest Salary</div>
                    <div class="stat-value">₹ <%= df.format(maxSalary) %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Lowest Salary</div>
                    <div class="stat-value">₹ <%= df.format(minSalary) %></div>
                </div>
            </div>
        <%
        }
        
        // First Letter Search Report
        if ("firstLetter".equals(reportType)) {
            String searchLetter = (String) request.getAttribute("searchLetter");
        %>
            <div class="search-info">
                🔍 Showing employees whose name starts with '<strong><%= searchLetter %></strong>'
            </div>
        <%
        }
        
        // Full Salary Range Report
        if ("fullSalaryRange".equals(reportType)) {
            BigDecimal minSalary = (BigDecimal) request.getAttribute("minSalary");
            BigDecimal maxSalary = (BigDecimal) request.getAttribute("maxSalary");
        %>
            <div class="search-info">
                📊 Salary Range: <strong>₹ <%= minSalary %></strong> to <strong>₹ <%= maxSalary %></strong>
            </div>
        <%
        }
        
        // Display Employee List for reports that show employees
        if ("firstLetter".equals(reportType) || "salaryRange".equals(reportType) || 
            "department".equals(reportType) || "fullSalaryRange".equals(reportType) ||
            "experienceYears".equals(reportType)) {
            
            List<Employee> employees = (List<Employee>) request.getAttribute("employees");
            if (employees != null && !employees.isEmpty()) {
                double totalSalary = 0;
                for (Employee emp : employees) {
                    totalSalary += emp.getSalary().doubleValue();
                }
        %>
            <div class="stats-summary">
                <div class="stat-box">
                    <div class="stat-label">Employees Found</div>
                    <div class="stat-value"><%= employees.size() %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Average Salary</div>
                    <div class="stat-value">₹ <%= String.format("%,.2f", totalSalary / employees.size()) %></div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Total Salary</div>
                    <div class="stat-value">₹ <%= String.format("%,.2f", totalSalary) %></div>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Salary</th>
                        <th>Joining Date</th>
                        <th>Experience</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for (Employee emp : employees) {
                        // Calculate experience in years
                        java.util.Date joiningDate = emp.getJoiningDate();
                        java.util.Date currentDate = new java.util.Date();
                        long diffInMillies = currentDate.getTime() - joiningDate.getTime();
                        double experienceYears = diffInMillies / (1000.0 * 60 * 60 * 24 * 365);
                        int expYears = (int) experienceYears;
                        int expMonths = (int) ((experienceYears - expYears) * 12);
                    %>
                    <tr>
                        <td><%= emp.getEmployeeId() %></td>
                        <td><%= emp.getName() %></td>
                        <td><%= emp.getDepartment() %></td>
                        <td><%= emp.getDesignation() %></td>
                        <td>₹ <%= String.format("%,.2f", emp.getSalary()) %></td>
                        <td><%= new java.text.SimpleDateFormat("dd-MMM-yyyy").format(emp.getJoiningDate()) %></td>
                        <td><%= expYears %> years <%= expMonths %> months</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        <%
            } else if (employees != null && employees.isEmpty()) {
        %>
            <div class="no-data">
                <p>❌ No employees found matching the criteria.</p>
            </div>
        <%
            }
        }
        %>
        
        <a href="reports.jsp" class="back-link">← Generate Another Report</a>
    </div>
</body>
</html>
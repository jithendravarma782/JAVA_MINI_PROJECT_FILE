<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Employee" %>
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
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        .content {
            padding: 30px;
        }
        
        .report-title {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 1.2em;
            font-weight: 600;
            color: #667eea;
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
        }
        
        tr:hover {
            background: #f8f9fa;
        }
        
        .summary {
            margin-top: 20px;
            padding: 15px;
            background: #e3f2fd;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.1em;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            table {
                font-size: 12px;
            }
            
            th, td {
                padding: 8px;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📈 Report Results</h1>
            <p>Employee Database Report</p>
        </div>
        
        <div class="content">
            <% if (request.getAttribute("error") != null) { %>
                <div class="error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% 
                String reportTitle = (String) request.getAttribute("reportTitle");
                List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                
                if (reportTitle != null) {
            %>
                <div class="report-title">
                    📊 <%= reportTitle %>
                </div>
            <% } %>
            
            <% if (employees != null && !employees.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Emp No</th>
                            <th>Name</th>
                            <th>Date of Joining</th>
                            <th>Gender</th>
                            <th>Basic Salary (₹)</th>
                            <th>Service Years</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Employee emp : employees) { 
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            java.util.Calendar dojCal = java.util.Calendar.getInstance();
                            dojCal.setTime(emp.getDoj());
                            int yearsOfService = cal.get(java.util.Calendar.YEAR) - dojCal.get(java.util.Calendar.YEAR);
                        %>
                            <tr>
                                <td><%= emp.getEmpno() %></td>
                                <td><%= emp.getEmpName() %></td>
                                <td><%= emp.getDoj() %></td>
                                <td><%= emp.getGender() %></td>
                                <td>₹<%= String.format("%,.2f", emp.getBsalary()) %></td>
                                <td><%= yearsOfService %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <div class="summary">
                    Total Employees: <%= employees.size() %>
                </div>
            <% } else if (employees != null) { %>
                <div class="no-data">
                    😕 No employees found matching the criteria.
                </div>
            <% } %>
            
            <div class="buttons">
                <a href="report" class="btn btn-primary">New Report</a>
                <a href="index.jsp" class="btn btn-secondary">Main Menu</a>
            </div>
        </div>
    </div>
</body>
</html>
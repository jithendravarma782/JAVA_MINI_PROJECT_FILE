<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Employees</title>
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
        
        .content {
            padding: 30px;
        }
        
        .search-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
            align-items: flex-end;
        }
        
        .search-form .form-group {
            flex: 1;
        }
        
        .search-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        
        .search-form input {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
        }
        
        .search-form button {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            height: 42px;
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
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .employee-detail {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
            }
            
            table {
                font-size: 12px;
            }
            
            th, td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>👥 Employee Records</h1>
        </div>
        
        <div class="content">
            <% if (request.getAttribute("message") != null) { %>
                <div class="message error">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <div class="search-section">
                <form action="displayEmployee" method="get" class="search-form">
                    <div class="form-group">
                        <label>Search by Employee Number:</label>
                        <input type="number" name="empno" placeholder="Enter Employee Number">
                    </div>
                    <button type="submit">Search</button>
                </form>
                <a href="displayEmployee" style="display: inline-block; margin-top: 10px;">Show All Employees</a>
            </div>
            
            <% 
                Employee singleEmp = (Employee) request.getAttribute("employee");
                List<Employee> employees = (List<Employee>) request.getAttribute("employees");
                
                if (singleEmp != null) {
            %>
                <div class="employee-detail">
                    <h3>Employee Details</h3>
                    <p><strong>Employee Number:</strong> <%= singleEmp.getEmpno() %></p>
                    <p><strong>Name:</strong> <%= singleEmp.getEmpName() %></p>
                    <p><strong>Date of Joining:</strong> <%= singleEmp.getDoj() %></p>
                    <p><strong>Gender:</strong> <%= singleEmp.getGender() %></p>
                    <p><strong>Basic Salary:</strong> ₹<%= String.format("%,.2f", singleEmp.getBsalary()) %></p>
                </div>
            <% } else if (employees != null && !employees.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Emp No</th>
                            <th>Name</th>
                            <th>Date of Joining</th>
                            <th>Gender</th>
                            <th>Basic Salary (₹)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Employee emp : employees) { %>
                            <tr>
                                <td><%= emp.getEmpno() %></td>
                                <td><%= emp.getEmpName() %></td>
                                <td><%= emp.getDoj() %></td>
                                <td><%= emp.getGender() %></td>
                                <td>₹<%= String.format("%,.2f", emp.getBsalary()) %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else if (employees != null) { %>
                <div class="message error">No employees found in the database.</div>
            <% } %>
            
            <a href="index.jsp" class="back-link">← Back to Main Menu</a>
        </div>
    </div>
</body>
</html>
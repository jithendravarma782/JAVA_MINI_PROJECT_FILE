<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Employee</title>
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
            padding: 50px;
        }
        
        .container {
            max-width: 600px;
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
        
        .form-container {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        button:hover {
            transform: translateY(-2px);
        }
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .search-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            width: 100%;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .info {
            background: #e3f2fd;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✏️ Update Employee</h1>
        </div>
        
        <div class="form-container">
            <% if (request.getAttribute("message") != null) { %>
                <div class="message <%= request.getAttribute("messageType") %>">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <div class="search-section">
                <form action="updateEmployee" method="get">
                    <div class="form-group">
                        <label>Search by Employee Number:</label>
                        <input type="number" name="empno" placeholder="Enter Employee Number" required>
                        <button type="submit" style="margin-top: 10px;">Load Employee Data</button>
                    </div>
                </form>
            </div>
            
            <% Employee emp = (Employee) request.getAttribute("employee"); %>
            <% if (emp != null) { %>
                <div class="info">
                    ✅ Loading data for Employee #<%= emp.getEmpno() %>
                </div>
                
                <form action="updateEmployee" method="post">
                    <input type="hidden" name="empno" value="<%= emp.getEmpno() %>">
                    
                    <div class="form-group">
                        <label>Employee Name:</label>
                        <input type="text" name="empName" value="<%= emp.getEmpName() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Date of Joining:</label>
                        <input type="date" name="doj" value="<%= emp.getDoj() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Gender:</label>
                        <select name="gender" required>
                            <option value="Male" <%= emp.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= emp.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= emp.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Basic Salary (₹):</label>
                        <input type="number" step="0.01" name="bsalary" value="<%= emp.getBsalary() %>" required>
                    </div>
                    
                    <button type="submit">Update Employee</button>
                </form>
            <% } else { %>
                <div class="info">
                    ℹ️ Enter an Employee Number above to load their data for updating.
                </div>
            <% } %>
            
            <a href="index.jsp" class="back-link">← Back to Main Menu</a>
        </div>
    </div>
</body>
</html>
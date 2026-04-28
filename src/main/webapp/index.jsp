<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management System</title>
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
            padding: 40px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            padding: 40px;
            background: #f8f9fa;
        }
        
        .menu-card {
            background: white;
            border-radius: 10px;
            padding: 30px 20px;
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .menu-card .icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        
        .menu-card h3 {
            margin-bottom: 10px;
            color: #667eea;
        }
        
        .menu-card p {
            font-size: 0.9em;
            color: #666;
        }
        
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏢 Employee Salary Management System</h1>
            <p>Efficiently manage your employee database</p>
        </div>
        
        <div class="menu">
            <a href="empadd.jsp" class="menu-card">
                <div class="icon">➕</div>
                <h3>Add Employee</h3>
                <p>Add new employee records to database</p>
            </a>
            
            <a href="empupdate.jsp" class="menu-card">
                <div class="icon">✏️</div>
                <h3>Update Employee</h3>
                <p>Modify existing employee information</p>
            </a>
            
            <a href="empdelete.jsp" class="menu-card">
                <div class="icon">🗑️</div>
                <h3>Delete Employee</h3>
                <p>Remove employee records from database</p>
            </a>
            
            <a href="displayEmployee" class="menu-card">
                <div class="icon">👥</div>
                <h3>Display Employees</h3>
                <p>View all or specific employee records</p>
            </a>
            
            <a href="report" class="menu-card">
                <div class="icon">📊</div>
                <h3>Generate Reports</h3>
                <p>Create custom employee reports</p>
            </a>
        </div>
        
        <div class="footer">
            <p>&copy; 2024 Employee Management System | All Rights Reserved</p>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Salary Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        /* Animated Background */
        .animated-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }
        
        .animated-bg span {
            position: absolute;
            display: block;
            width: 20px;
            height: 20px;
            background: rgba(255, 255, 255, 0.1);
            bottom: -150px;
            animation: float 25s linear infinite;
        }
        
        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 1;
                border-radius: 0;
            }
            100% {
                transform: translateY(-1000px) rotate(720deg);
                opacity: 0;
                border-radius: 50%;
            }
        }
        
        .animated-bg span:nth-child(1) { left: 10%; width: 80px; height: 80px; animation-delay: 2s; animation-duration: 12s; }
        .animated-bg span:nth-child(2) { left: 20%; width: 50px; height: 50px; animation-delay: 4s; animation-duration: 15s; }
        .animated-bg span:nth-child(3) { left: 35%; width: 100px; height: 100px; animation-delay: 1s; animation-duration: 18s; }
        .animated-bg span:nth-child(4) { left: 50%; width: 30px; height: 30px; animation-delay: 7s; animation-duration: 20s; }
        .animated-bg span:nth-child(5) { left: 65%; width: 70px; height: 70px; animation-delay: 3s; animation-duration: 14s; }
        .animated-bg span:nth-child(6) { left: 80%; width: 60px; height: 60px; animation-delay: 5s; animation-duration: 16s; }
        .animated-bg span:nth-child(7) { left: 90%; width: 40px; height: 40px; animation-delay: 9s; animation-duration: 22s; }
        .animated-bg span:nth-child(8) { left: 45%; width: 90px; height: 90px; animation-delay: 6s; animation-duration: 19s; }
        .animated-bg span:nth-child(9) { left: 70%; width: 25px; height: 25px; animation-delay: 8s; animation-duration: 17s; }
        .animated-bg span:nth-child(10) { left: 5%; width: 45px; height: 45px; animation-delay: 10s; animation-duration: 21s; }
        
        .container {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            padding: 50px 0 40px;
        }
        
        .logo {
            font-size: 60px;
            margin-bottom: 15px;
            display: inline-block;
            animation: bounce 2s ease-in-out infinite;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .header h1 {
            font-size: 3em;
            background: linear-gradient(135deg, #fff, #a8c0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: 2px;
        }
        
        .header p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1em;
        }
        
        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .stat-item {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 15px 30px;
            border-radius: 50px;
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .stat-item i {
            font-size: 24px;
            color: #ffd700;
        }
        
        .stat-item .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }
        
        .stat-item .stat-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            cursor: pointer;
            text-decoration: none;
            display: block;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        
        .card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }
        
        .card-icon {
            font-size: 60px;
            text-align: center;
            padding: 30px 0 20px;
            transition: all 0.3s ease;
        }
        
        .card:hover .card-icon {
            transform: scale(1.1);
        }
        
        .card-content {
            padding: 0 25px 25px;
            text-align: center;
        }
        
        .card h3 {
            font-size: 1.8em;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .card p {
            color: #666;
            font-size: 0.95em;
            line-height: 1.5;
        }
        
        .card-footer {
            padding: 15px 25px;
            background: rgba(0, 0, 0, 0.03);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        
        .card-footer span {
            font-size: 14px;
            color: #888;
        }
        
        .card-footer i {
            transition: transform 0.3s ease;
        }
        
        .card:hover .card-footer i {
            transform: translateX(5px);
        }
        
        .card.add .card-icon { color: #4CAF50; }
        .card.add .card-footer { border-top: 3px solid #4CAF50; }
        .card.add h3 { color: #4CAF50; }
        
        .card.update .card-icon { color: #FF9800; }
        .card.update .card-footer { border-top: 3px solid #FF9800; }
        .card.update h3 { color: #FF9800; }
        
        .card.delete .card-icon { color: #f44336; }
        .card.delete .card-footer { border-top: 3px solid #f44336; }
        .card.delete h3 { color: #f44336; }
        
        .card.display .card-icon { color: #2196F3; }
        .card.display .card-footer { border-top: 3px solid #2196F3; }
        .card.display h3 { color: #2196F3; }
        
        .card.reports .card-icon { color: #9C27B0; }
        .card.reports .card-footer { border-top: 3px solid #9C27B0; }
        .card.reports h3 { color: #9C27B0; }
        
        .footer {
            text-align: center;
            margin-top: 60px;
            padding: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .footer p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9em;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .dashboard {
                grid-template-columns: 1fr;
            }
            
            .stat-item {
                padding: 10px 20px;
            }
            
            .stat-item .stat-number {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <div class="animated-bg">
        <span></span><span></span><span></span><span></span><span></span>
        <span></span><span></span><span></span><span></span><span></span>
    </div>
    
    <div class="container">
        <div class="header">
            <div class="logo">🏢</div>
            <h1>Employee Salary Management System</h1>
            <p>Streamline your workforce management with our comprehensive solution</p>
            
            <div class="stats-bar">
                <div class="stat-item">
                    <i class="fas fa-users"></i>
                    <span class="stat-number">
                        <% 
                        EmployeeDAO dao = new EmployeeDAO();
                        int totalEmployees = dao.getTotalEmployeeCount();
                        %>
                        <%= totalEmployees %>
                    </span>
                    <span class="stat-label">Total Employees</span>
                </div>
                <div class="stat-item">
                    <i class="fas fa-rupee-sign"></i>
                    <span class="stat-number">
                        ₹ <% 
                        double avgSalary = dao.getAverageSalary();
                        out.print(Math.round(avgSalary));
                        %>
                    </span>
                    <span class="stat-label">Avg Salary</span>
                </div>
                <div class="stat-item">
                    <i class="fas fa-calendar"></i>
                    <span class="stat-number">2024</span>
                    <span class="stat-label">Current Year</span>
                </div>
            </div>
        </div>
        
        <div class="dashboard">
            <a href="empadd.jsp" class="card add">
                <div class="card-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="card-content">
                    <h3>Add Employee</h3>
                    <p>Register new employees with auto-generated IDs and complete details</p>
                </div>
                <div class="card-footer">
                    <span>Add new record</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>
            
            <a href="empupdate.jsp" class="card update">
                <div class="card-icon">
                    <i class="fas fa-user-edit"></i>
                </div>
                <div class="card-content">
                    <h3>Update Employee</h3>
                    <p>Modify existing employee information and salary details</p>
                </div>
                <div class="card-footer">
                    <span>Update record</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>
            
            <a href="empdelete.jsp" class="card delete">
                <div class="card-icon">
                    <i class="fas fa-user-minus"></i>
                </div>
                <div class="card-content">
                    <h3>Delete Employee</h3>
                    <p>Remove employees from the system with confirmation</p>
                </div>
                <div class="card-footer">
                    <span>Delete record</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>
            
            <a href="displayEmployee" class="card display">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="card-content">
                    <h3>Display Employees</h3>
                    <p>View complete employee list with statistics and filtering</p>
                </div>
                <div class="card-footer">
                    <span>View all</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>
            
            <a href="reports.jsp" class="card reports">
                <div class="card-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="card-content">
                    <h3>Reports</h3>
                    <p>Generate comprehensive salary and employee reports</p>
                </div>
                <div class="card-footer">
                    <span>Generate</span>
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>
        </div>
        
        <div class="footer">
            <p>&copy; 2024 Employee Salary Management System | All Rights Reserved</p>
        </div>
    </div>
</body>
</html>
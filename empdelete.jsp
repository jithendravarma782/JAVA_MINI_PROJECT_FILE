<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.EmployeeDAO" %>
<%@ page import="com.model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Employee | HR Pro Suite</title>
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
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            min-height: 100vh;
            padding: 30px;
            position: relative;
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
        
        .animated-bg .circle {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(244, 67, 54, 0.2), rgba(218, 25, 11, 0.2));
            animation: float 20s infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-100px) rotate(180deg); }
        }
        
        .circle:nth-child(1) { width: 300px; height: 300px; top: -100px; left: -100px; animation-duration: 25s; }
        .circle:nth-child(2) { width: 200px; height: 200px; bottom: -50px; right: -50px; animation-duration: 20s; }
        .circle:nth-child(3) { width: 150px; height: 150px; top: 50%; left: 50%; animation-duration: 30s; }
        .circle:nth-child(4) { width: 400px; height: 400px; bottom: -150px; left: 20%; animation-duration: 35s; }
        
        /* Main Container */
        .container {
            position: relative;
            z-index: 1;
            max-width: 700px;
            margin: 0 auto;
        }
        
        /* Glass Card */
        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border-radius: 40px;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s ease;
        }
        
        .glass-card:hover {
            transform: translateY(-5px);
        }
        
        /* Header Section */
        .header-section {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .icon-wrapper {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #f44336, #d32f2f);
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(244, 67, 54, 0.7); }
            50% { transform: scale(1.05); box-shadow: 0 0 0 20px rgba(244, 67, 54, 0); }
        }
        
        .icon-wrapper i {
            font-size: 38px;
            color: white;
        }
        
        .header-section h1 {
            font-size: 32px;
            font-weight: 700;
            background: linear-gradient(135deg, #fff, #ff6b6b);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 10px;
        }
        
        .header-section p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }
        
        /* Warning Box */
        .warning-box {
            background: rgba(244, 67, 54, 0.15);
            border: 2px solid rgba(244, 67, 54, 0.5);
            border-radius: 20px;
            padding: 18px;
            text-align: center;
            margin-bottom: 30px;
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        .warning-box i {
            font-size: 40px;
            color: #f44336;
            margin-bottom: 10px;
        }
        
        .warning-box p {
            color: #ff6b6b;
            font-size: 16px;
            font-weight: 600;
        }
        
        /* Search Section */
        .search-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 24px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .search-input-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .search-input-group input {
            flex: 1;
            padding: 14px 18px;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            font-size: 15px;
            color: white;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        .search-input-group input:focus {
            outline: none;
            border-color: #f44336;
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 0 20px rgba(244, 67, 54, 0.2);
        }
        
        .search-input-group input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        
        .search-btn {
            padding: 14px 30px;
            background: linear-gradient(135deg, #2196F3, #1976D2);
            border: none;
            border-radius: 16px;
            font-size: 15px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(33, 150, 243, 0.4);
        }
        
        /* Info Card */
        .info-card {
            background: rgba(33, 150, 243, 0.15);
            border: 1px solid rgba(33, 150, 243, 0.3);
            border-radius: 16px;
            padding: 15px 20px;
            text-align: center;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .info-card i {
            font-size: 18px;
            color: #64b5f6;
        }
        
        .info-card span {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }
        
        /* Employee Card */
        .employee-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 24px;
            padding: 25px;
            margin: 20px 0;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }
        
        .employee-card:hover {
            background: rgba(255, 255, 255, 0.08);
            transform: scale(1.01);
        }
        
        .employee-card h3 {
            color: white;
            margin-bottom: 20px;
            font-size: 18px;
            padding-bottom: 12px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        }
        
        .employee-card h3 i {
            margin-right: 10px;
            color: #667eea;
        }
        
        .employee-info {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 12px;
            margin-bottom: 10px;
        }
        
        .employee-label {
            color: rgba(255, 255, 255, 0.6);
            font-weight: 500;
            font-size: 14px;
        }
        
        .employee-label i {
            margin-right: 8px;
            width: 20px;
        }
        
        .employee-value {
            color: white;
            font-weight: 600;
            font-size: 14px;
        }
        
        .employee-value strong {
            color: #ff6b6b;
        }
        
        /* Button Group */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }
        
        .btn-danger {
            flex: 1;
            padding: 14px;
            background: linear-gradient(135deg, #f44336, #d32f2f);
            border: none;
            border-radius: 16px;
            font-size: 15px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(244, 67, 54, 0.4);
        }
        
        .btn-secondary {
            flex: 1;
            padding: 14px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            font-size: 15px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }
        
        /* Message Alert */
        .message {
            padding: 15px;
            border-radius: 16px;
            margin-bottom: 25px;
            text-align: center;
            font-size: 14px;
            animation: slideIn 0.5s ease;
        }
        
        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .success {
            background: rgba(76, 175, 80, 0.2);
            border: 1px solid rgba(76, 175, 80, 0.5);
            color: #4caf50;
        }
        
        .error {
            background: rgba(244, 67, 54, 0.2);
            border: 1px solid rgba(244, 67, 54, 0.5);
            color: #ff6b6b;
        }
        
        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.1);
            padding: 12px 25px;
            border-radius: 40px;
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-top: 30px;
        }
        
        .back-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(-5px);
        }
        
        /* Divider */
        hr {
            border: none;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin: 20px 0;
        }
        
        /* Footer */
        .footer {
            text-align: center;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .glass-card {
                padding: 25px;
            }
            
            .header-section h1 {
                font-size: 26px;
            }
            
            .search-input-group {
                flex-direction: column;
            }
            
            .search-btn {
                justify-content: center;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .employee-info {
                grid-template-columns: 1fr;
                gap: 8px;
            }
        }
        
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #f44336, #d32f2f);
            border-radius: 10px;
        }
    </style>
    <script>
        function confirmDelete(employeeId, employeeName) {
            return confirm("⚠️ ARE YOU SURE?\n\nEmployee ID: " + employeeId + "\nName: " + employeeName + "\n\nThis action cannot be undone!\n\nClick OK to permanently delete.");
        }
    </script>
</head>
<body>
    <div class="animated-bg">
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
    </div>
    
    <div class="container">
        <div class="glass-card">
            <div class="header-section">
                <div class="icon-wrapper">
                    <i class="fas fa-trash-alt"></i>
                </div>
                <h1>Delete Employee</h1>
                <p>Permanently remove employee records from the system</p>
            </div>
            
            <% 
            String message = (String) request.getAttribute("message"); 
            if (message != null) { 
            %>
                <div class="message <%= message.contains("✅") ? "success" : "error" %>">
                    <i class="fas <%= message.contains("✅") ? "fa-check-circle" : "fa-exclamation-triangle" %>"></i> 
                    <%= message %>
                </div>
            <% 
            } 
            %>
            
            <div class="warning-box">
                <i class="fas fa-exclamation-triangle"></i>
                <p>⚠️ WARNING: Deleted records cannot be recovered! ⚠️</p>
            </div>
            
            <%
            String action = request.getParameter("action");
            String employeeId = request.getParameter("employeeId");
            EmployeeDAO dao = new EmployeeDAO();
            Employee employee = null;
            
            if (employeeId != null && !employeeId.trim().isEmpty()) {
                employee = dao.getEmployeeByEmployeeId(employeeId);
            }
            
            if ("confirm".equals(action) && employee != null) {
            %>
                <div class="employee-card">
                    <h3><i class="fas fa-user-circle"></i> Employee Details - Review Before Deletion</h3>
                    <div class="employee-info">
                        <div class="employee-label"><i class="fas fa-id-card"></i> Employee ID:</div>
                        <div class="employee-value"><strong><%= employee.getEmployeeId() %></strong></div>
                        
                        <div class="employee-label"><i class="fas fa-user"></i> Full Name:</div>
                        <div class="employee-value"><%= employee.getName() %></div>
                        
                        <div class="employee-label"><i class="fas fa-building"></i> Department:</div>
                        <div class="employee-value"><%= employee.getDepartment() %></div>
                        
                        <div class="employee-label"><i class="fas fa-briefcase"></i> Designation:</div>
                        <div class="employee-value"><%= employee.getDesignation() %></div>
                        
                        <div class="employee-label"><i class="fas fa-rupee-sign"></i> Salary:</div>
                        <div class="employee-value">₹ <%= String.format("%,.2f", employee.getSalary()) %></div>
                        
                        <div class="employee-label"><i class="fas fa-calendar"></i> Joining Date:</div>
                        <div class="employee-value"><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(employee.getJoiningDate()) %></div>
                    </div>
                </div>
                
                <div class="info-card">
                    <i class="fas fa-info-circle"></i>
                    <span>⚠️ Please confirm that you want to permanently delete this employee</span>
                </div>
                
                <div class="button-group">
                    <form action="deleteEmployee" method="post" style="flex:1;" onsubmit="return confirmDelete('<%= employee.getEmployeeId() %>', '<%= employee.getName() %>')">
                        <input type="hidden" name="employeeId" value="<%= employee.getEmployeeId() %>">
                        <button type="submit" class="btn-danger">
                            <i class="fas fa-trash-alt"></i> Yes, Delete Permanently
                        </button>
                    </form>
                    <form action="empdelete.jsp" method="get" style="flex:1;">
                        <button type="submit" class="btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </form>
                </div>
                
            <%
            } else {
            %>
                <div class="info-card">
                    <i class="fas fa-search"></i>
                    <span>🔍 Enter the Employee ID to find and delete the record</span>
                </div>
                
                <div class="search-section">
                    <form action="empdelete.jsp" method="get">
                        <div class="search-input-group">
                            <input type="text" name="employeeId" placeholder="Enter Employee ID (e.g., EMP001)" 
                                   value="<%= employeeId != null ? employeeId : "" %>" required>
                            <button type="submit" class="search-btn">
                                <i class="fas fa-search"></i> Search Employee
                            </button>
                        </div>
                    </form>
                </div>
                
                <hr>
                
                <div class="info-card">
                    <i class="fas fa-lightbulb"></i>
                    <span>💡 Employee IDs are auto-generated in format EMP001, EMP002, EMP003, etc.</span>
                </div>
            <%
                if (employeeId != null && !employeeId.trim().isEmpty() && employee == null) {
            %>
                <div class="message error">
                    <i class="fas fa-user-slash"></i> No employee found with ID: <%= employeeId %>
                </div>
            <%
                } else if (employeeId != null && !employeeId.trim().isEmpty() && employee != null) {
            %>
                <div class="employee-card">
                    <h3><i class="fas fa-user-check"></i> Employee Found</h3>
                    <div class="employee-info">
                        <div class="employee-label"><i class="fas fa-id-card"></i> Employee ID:</div>
                        <div class="employee-value"><strong><%= employee.getEmployeeId() %></strong></div>
                        
                        <div class="employee-label"><i class="fas fa-user"></i> Name:</div>
                        <div class="employee-value"><%= employee.getName() %></div>
                        
                        <div class="employee-label"><i class="fas fa-building"></i> Department:</div>
                        <div class="employee-value"><%= employee.getDepartment() %></div>
                        
                        <div class="employee-label"><i class="fas fa-rupee-sign"></i> Salary:</div>
                        <div class="employee-value">₹ <%= String.format("%,.2f", employee.getSalary()) %></div>
                    </div>
                </div>
                
                <form action="empdelete.jsp" method="get">
                    <input type="hidden" name="employeeId" value="<%= employee.getEmployeeId() %>">
                    <input type="hidden" name="action" value="confirm">
                    <button type="submit" class="btn-danger" style="width: 100%;">
                        <i class="fas fa-trash-alt"></i> Delete This Employee
                    </button>
                </form>
            <%
                }
            }
            %>
            
            <div class="footer">
                <a href="index.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Employee" %>
<%@ page import="com.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Employees | HR Pro Suite</title>
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
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.3), rgba(118, 75, 162, 0.3));
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
            max-width: 1400px;
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
            margin-bottom: 40px;
        }
        
        .icon-wrapper {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7); }
            50% { transform: scale(1.05); box-shadow: 0 0 0 20px rgba(102, 126, 234, 0); }
        }
        
        .icon-wrapper i {
            font-size: 38px;
            color: white;
        }
        
        .header-section h1 {
            font-size: 36px;
            font-weight: 700;
            background: linear-gradient(135deg, #fff, #a8c0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 10px;
        }
        
        .header-section p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(102, 126, 234, 0.5);
        }
        
        .stat-icon {
            font-size: 40px;
            color: #667eea;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, #a8c0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 8px;
        }
        
        .stat-label {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.6);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Table Container */
        .table-container {
            overflow-x: auto;
            border-radius: 20px;
            margin-bottom: 30px;
        }
        
        /* Modern Table */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            overflow: hidden;
        }
        
        .data-table thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
        }
        
        .data-table th {
            padding: 18px 15px;
            text-align: left;
            color: white;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .data-table td {
            padding: 15px;
            color: rgba(255, 255, 255, 0.8);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 14px;
        }
        
        .data-table tr {
            transition: all 0.3s ease;
        }
        
        .data-table tbody tr:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.01);
        }
        
        .data-table tbody tr:last-child td {
            border-bottom: none;
        }
        
        /* Employee ID Badge */
        .emp-id {
            background: rgba(102, 126, 234, 0.3);
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 13px;
            display: inline-block;
            color: #a8c0ff;
        }
        
        /* Salary Cell */
        .salary-cell {
            font-weight: 600;
            color: #4caf50;
        }
        
        /* Date Cell */
        .date-cell {
            font-family: monospace;
            font-size: 13px;
        }
        
        /* No Data Message */
        .no-data {
            text-align: center;
            padding: 60px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 24px;
            margin-bottom: 30px;
        }
        
        .no-data i {
            font-size: 60px;
            color: #667eea;
            margin-bottom: 20px;
        }
        
        .no-data p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 16px;
        }
        
        .no-data a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .no-data a:hover {
            color: #a8c0ff;
        }
        
        /* Next ID Card */
        .next-id-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.2), rgba(118, 75, 162, 0.2));
            border: 1px solid rgba(102, 126, 234, 0.5);
            border-radius: 20px;
            padding: 20px;
            text-align: center;
            margin-top: 30px;
            position: relative;
            overflow: hidden;
        }
        
        .next-id-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }
        
        @keyframes shine {
            0% { transform: translateX(-100%) rotate(45deg); }
            100% { transform: translateX(100%) rotate(45deg); }
        }
        
        .next-id-card i {
            font-size: 24px;
            color: #667eea;
            margin-right: 10px;
        }
        
        .next-id-card span {
            font-size: 18px;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .next-id-card strong {
            font-size: 24px;
            background: linear-gradient(135deg, #fff, #a8c0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-left: 10px;
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
        
        /* Search Bar */
        .search-bar {
            margin-bottom: 30px;
            position: relative;
        }
        
        .search-bar input {
            width: 100%;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 50px;
            font-size: 15px;
            color: white;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        .search-bar input:focus {
            outline: none;
            border-color: #667eea;
            background: rgba(255, 255, 255, 0.12);
        }
        
        .search-bar input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        
        .search-bar i {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.4);
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
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .data-table th, .data-table td {
                padding: 10px;
                font-size: 12px;
            }
        }
        
        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #764ba2, #667eea);
        }
    </style>
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
                    <i class="fas fa-users-viewfinder"></i>
                </div>
                <h1>Team Directory</h1>
                <p>View and manage all employee records in one place</p>
            </div>
            
            <%
            List<Employee> employees = (List<Employee>) request.getAttribute("employees");
            if (employees != null && !employees.isEmpty()) {
                double totalSalary = 0;
                for (Employee emp : employees) {
                    totalSalary += emp.getSalary().doubleValue();
                }
                double avgSalary = totalSalary / employees.size();
            %>
            
            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-number"><%= employees.size() %></div>
                    <div class="stat-label">Total Employees</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="stat-number">₹ <%= String.format("%,.0f", avgSalary) %></div>
                    <div class="stat-label">Average Salary</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-coins"></i></div>
                    <div class="stat-number">₹ <%= String.format("%,.0f", totalSalary) %></div>
                    <div class="stat-label">Total Budget</div>
                </div>
            </div>
            
            <!-- Search Bar -->
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="🔍 Search by Name, ID, Department or Designation..." onkeyup="searchTable()">
                <i class="fas fa-search"></i>
            </div>
            
            <!-- Employee Table -->
            <div class="table-container">
                <table class="data-table" id="employeeTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-id-card"></i> Employee ID</th>
                            <th><i class="fas fa-user"></i> Full Name</th>
                            <th><i class="fas fa-building"></i> Department</th>
                            <th><i class="fas fa-briefcase"></i> Designation</th>
                            <th><i class="fas fa-rupee-sign"></i> Salary</th>
                            <th><i class="fas fa-calendar"></i> Joining Date</th>
                            <th><i class="fas fa-chart-simple"></i> Experience</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Employee emp : employees) { 
                            // Calculate experience
                            java.util.Date joiningDate = emp.getJoiningDate();
                            java.util.Date currentDate = new java.util.Date();
                            long diffInMillies = currentDate.getTime() - joiningDate.getTime();
                            double experienceYears = diffInMillies / (1000.0 * 60 * 60 * 24 * 365);
                            int expYears = (int) experienceYears;
                            int expMonths = (int) ((experienceYears - expYears) * 12);
                            String experience = expYears + "y " + expMonths + "m";
                        %>
                        <tr>
                            <td><span class="emp-id"><%= emp.getEmployeeId() %></span></td>
                            <td><%= emp.getName() %></td>
                            <td><%= emp.getDepartment() %></td>
                            <td><%= emp.getDesignation() %></td>
                            <td class="salary-cell">₹ <%= String.format("%,.2f", emp.getSalary()) %></td>
                            <td class="date-cell"><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(emp.getJoiningDate()) %></td>
                            <td><%= experience %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <% } else { %>
            <div class="no-data">
                <i class="fas fa-user-slash"></i>
                <p>No employees found in the database.</p>
                <p>Click <a href="empadd.jsp">here</a> to add your first employee.</p>
            </div>
            <% } %>
            
            <!-- Next Generated ID -->
            <div class="next-id-card">
                <i class="fas fa-magic"></i>
                <span>Next Employee ID to be generated:</span>
                <strong><%= new EmployeeDAO().generateNextEmployeeId() %></strong>
            </div>
            
            <!-- Back Button -->
            <div style="text-align: center;">
                <a href="index.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <script>
        function searchTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toUpperCase();
            const table = document.getElementById('employeeTable');
            const tr = table.getElementsByTagName('tr');
            
            for (let i = 1; i < tr.length; i++) {
                const td = tr[i].getElementsByTagName('td');
                let found = false;
                
                for (let j = 0; j < td.length; j++) {
                    if (td[j]) {
                        const textValue = td[j].textContent || td[j].innerText;
                        if (textValue.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                
                if (found) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }
    </script>
</body>
</html>
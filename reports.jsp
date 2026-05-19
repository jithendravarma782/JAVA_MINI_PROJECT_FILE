<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports | HR Pro Suite</title>
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
        .circle:nth-child(5) { width: 250px; height: 250px; top: 20%; right: 10%; animation-duration: 28s; }
        .circle:nth-child(6) { width: 180px; height: 180px; bottom: 30%; left: 15%; animation-duration: 22s; }
        
        /* Main Container */
        .container {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* Header Section */
        .header-section {
            text-align: center;
            margin-bottom: 50px;
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
            font-size: 42px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, #a8c0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 15px;
        }
        
        .header-section p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 16px;
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* Reports Grid */
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        /* Report Card */
        .report-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border-radius: 28px;
            padding: 30px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
            overflow: hidden;
        }
        
        .report-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.05), transparent);
            transition: left 0.5s ease;
        }
        
        .report-card:hover::before {
            left: 100%;
        }
        
        .report-card:hover {
            transform: translateY(-8px);
            border-color: rgba(102, 126, 234, 0.5);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }
        
        /* Report Icon */
        .report-icon {
            font-size: 48px;
            text-align: center;
            margin-bottom: 10px;
        }
        
        /* Report Header */
        .report-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 14px;
            border-radius: 18px;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .report-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        /* Form Groups */
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            font-size: 13px;
            letter-spacing: 0.5px;
        }
        
        label i {
            margin-right: 6px;
            color: #667eea;
        }
        
        input, select {
            width: 100%;
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 14px;
            font-size: 14px;
            color: white;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 0 15px rgba(102, 126, 234, 0.2);
        }
        
        input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        
        /* Select Dropdown */
        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 24 24'%3E%3Cpath d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 20px;
        }
        
        /* Small Text */
        small {
            color: rgba(255, 255, 255, 0.5);
            font-size: 11px;
            display: block;
            margin-top: 6px;
        }
        
        /* Info List */
        .info-list {
            margin-left: 20px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 13px;
            margin-bottom: 15px;
        }
        
        .info-list li {
            margin-bottom: 6px;
        }
        
        .info-text {
            color: rgba(255, 255, 255, 0.6);
            font-size: 13px;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        /* Button */
        .report-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 16px;
            font-size: 14px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-family: 'Poppins', sans-serif;
            margin-top: 5px;
        }
        
        .report-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.1);
            padding: 12px 28px;
            border-radius: 50px;
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .back-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(-5px);
        }
        
        .back-link i {
            transition: transform 0.3s ease;
        }
        
        .back-link:hover i {
            transform: translateX(-3px);
        }
        
        /* Footer */
        .footer {
            text-align: center;
            margin-top: 50px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 20px;
            }
            
            .header-section h1 {
                font-size: 28px;
            }
            
            .reports-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .report-card {
                padding: 25px;
            }
        }
        
        /* Letter Input Styling */
        .letter-input {
            text-align: center;
            font-size: 28px !important;
            font-weight: 700;
            letter-spacing: 5px;
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
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="animated-bg">
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
    </div>
    
    <div class="container">
        <div class="header-section">
            <div class="icon-wrapper">
                <i class="fas fa-chart-pie"></i>
            </div>
            <h1>Analytics & Reports</h1>
            <p>Gain valuable insights with our comprehensive reporting tools</p>
        </div>
        
        <div class="reports-grid">
            
            <!-- Report 1: Search by First Letter -->
            <div class="report-card">
                <div class="report-icon">🔤</div>
                <div class="report-header">
                    <h3><i class="fas fa-search"></i> Search by First Letter</h3>
                </div>
                <form action="reportCriteria" method="post">
                    <input type="hidden" name="reportType" value="firstLetter">
                    <div class="form-group">
                        <label><i class="fas fa-font"></i> Enter First Letter:</label>
                        <input type="text" name="letter" maxlength="1" placeholder="M" 
                               class="letter-input" required>
                        <small>🔍 Enter a single letter (A-Z) to find employees whose names start with that letter</small>
                    </div>
                    <button type="submit" class="report-btn">
                        <i class="fas fa-search"></i> Search by Letter
                    </button>
                </form>
            </div>
            
            <!-- Report 2: Salary Range Report -->
            <div class="report-card">
                <div class="report-icon">💰</div>
                <div class="report-header">
                    <h3><i class="fas fa-chart-line"></i> Salary Range Report</h3>
                </div>
                <form action="reportCriteria" method="post">
                    <input type="hidden" name="reportType" value="salaryRange">
                    <div class="form-group">
                        <label><i class="fas fa-arrow-down"></i> Minimum Salary (₹):</label>
                        <input type="number" name="minSalary" step="1000" placeholder="e.g., 30000" required>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-arrow-up"></i> Maximum Salary (₹):</label>
                        <input type="number" name="maxSalary" step="1000" placeholder="e.g., 80000" required>
                    </div>
                    <button type="submit" class="report-btn">
                        <i class="fas fa-chart-bar"></i> Generate Report
                    </button>
                </form>
            </div>
            
            <!-- Report 3: Experience Report -->
            <div class="report-card">
                <div class="report-icon">📅</div>
                <div class="report-header">
                    <h3><i class="fas fa-clock"></i> Experience Report</h3>
                </div>
                <form action="reportCriteria" method="post">
                    <input type="hidden" name="reportType" value="experienceYears">
                    <div class="form-group">
                        <label><i class="fas fa-briefcase"></i> Select Experience Level:</label>
                        <select name="experienceLevel" required>
                            <option value="">— Select Experience —</option>
                            <option value="0-1">🌱 Less than 1 year (Fresher)</option>
                            <option value="1-3">📘 1 - 3 years (Junior)</option>
                            <option value="3-5">📙 3 - 5 years (Mid Level)</option>
                            <option value="5-10">📗 5 - 10 years (Senior)</option>
                            <option value="10+">🏆 10+ years (Expert)</option>
                        </select>
                    </div>
                    <button type="submit" class="report-btn">
                        <i class="fas fa-chart-simple"></i> Generate Report
                    </button>
                </form>
            </div>
            
            <!-- Report 4: Complete Salary Range -->
            <div class="report-card">
                <div class="report-icon">📊</div>
                <div class="report-header">
                    <h3><i class="fas fa-chart-gantt"></i> Complete Salary Range</h3>
                </div>
                <form action="reportCriteria" method="post">
                    <input type="hidden" name="reportType" value="fullSalaryRange">
                    <div class="info-text">
                        <i class="fas fa-info-circle"></i> View all employees with automatic min-max salary range analysis
                    </div>
                    <ul class="info-list">
                        <li><i class="fas fa-arrow-down"></i> Minimum to Maximum Salary</li>
                        <li><i class="fas fa-chart-pie"></i> Salary Distribution</li>
                        <li><i class="fas fa-list"></i> Complete Employee List</li>
                    </ul>
                    <button type="submit" class="report-btn">
                        <i class="fas fa-chart-line"></i> Show Full Analysis
                    </button>
                </form>
            </div>
            
            <!-- Report 5: Department-wise Report -->
            <div class="report-card">
                <div class="report-icon">🏢</div>
                <div class="report-header">
                    <h3><i class="fas fa-building"></i> Department-wise Report</h3>
                </div>
                <form action="reportCriteria" method="post">
                    <input type="hidden" name="reportType" value="department">
                    <div class="form-group">
                        <label><i class="fas fa-building"></i> Select Department:</label>
                        <select name="department" required>
                            <option value="">— Choose Department —</option>
                            <option value="IT">💻 Information Technology</option>
                            <option value="HR">👥 Human Resources</option>
                            <option value="Finance">💰 Finance & Accounting</option>
                            <option value="Marketing">📢 Marketing & Communications</option>
                            <option value="Sales">🤝 Sales & Business Development</option>
                        </select>
                    </div>
                    <button type="submit" class="report-btn">
                        <i class="fas fa-chart-column"></i> Generate Report
                    </button>
                </form>
            </div>
            
            <!-- Report 6: Salary Summary -->
            <div class="report-card">
                <div class="report-icon">📈</div>
                <div class="report-header">
                    <h3><i class="fas fa-chart-pie"></i> Salary Summary</h3>
                </div>
                <form action="reportCriteria" method="post">
                    <input type="hidden" name="reportType" value="summary">
                    <div class="info-text">
                        <i class="fas fa-chart-simple"></i> Get complete salary statistics including:
                    </div>
                    <ul class="info-list">
                        <li><i class="fas fa-users"></i> Total employees count</li>
                        <li><i class="fas fa-calculator"></i> Average salary</li>
                        <li><i class="fas fa-arrow-up"></i> Highest salary</li>
                        <li><i class="fas fa-arrow-down"></i> Lowest salary</li>
                        <li><i class="fas fa-coins"></i> Total salary budget</li>
                        <li><i class="fas fa-chart-line"></i> Department-wise breakdown</li>
                    </ul>
                    <button type="submit" class="report-btn">
                        <i class="fas fa-chart-pie"></i> Generate Summary
                    </button>
                </form>
            </div>
            
        </div>
        
        <div class="footer">
            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>
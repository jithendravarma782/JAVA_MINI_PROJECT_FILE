<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Reports</title>
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
            max-width: 800px;
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
            padding: 40px;
        }
        
        .report-type {
            margin-bottom: 30px;
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .report-type:hover {
            border-color: #667eea;
            background: #f8f9fa;
        }
        
        .report-type input[type="radio"] {
            margin-right: 10px;
            transform: scale(1.2);
        }
        
        .report-type label {
            font-weight: 600;
            font-size: 1.1em;
            cursor: pointer;
        }
        
        .report-desc {
            margin-top: 10px;
            margin-left: 25px;
            color: #666;
            font-size: 0.9em;
        }
        
        .input-group {
            margin-top: 15px;
            margin-left: 25px;
            display: none;
        }
        
        .input-group.active {
            display: block;
        }
        
        .input-group input {
            padding: 8px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            width: 200px;
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
            margin-top: 20px;
        }
        
        button:hover {
            transform: translateY(-2px);
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
        
        hr {
            margin: 20px 0;
            border: none;
            border-top: 2px solid #e0e0e0;
        }
    </style>
    <script>
        function showInput(reportType) {
            document.getElementById('nameInput').classList.remove('active');
            document.getElementById('yearsInput').classList.remove('active');
            document.getElementById('salaryInput').classList.remove('active');
            
            if (reportType === 'nameStart') {
                document.getElementById('nameInput').classList.add('active');
            } else if (reportType === 'serviceYears') {
                document.getElementById('yearsInput').classList.add('active');
            } else if (reportType === 'minSalary') {
                document.getElementById('salaryInput').classList.add('active');
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Generate Reports</h1>
            <p>Create custom reports based on your criteria</p>
        </div>
        
        <div class="content">
            <form action="report" method="post">
                <div class="report-type" onclick="document.getElementById('reportNameStart').checked=true; showInput('nameStart')">
                    <input type="radio" name="reportType" id="reportNameStart" value="nameStart" required>
                    <label>Employees whose names start with a specific letter</label>
                    <div class="report-desc">Find all employees whose names begin with a particular letter</div>
                    <div id="nameInput" class="input-group">
                        <label>Enter Letter: </label>
                        <input type="text" name="letter" maxlength="1" placeholder="e.g., S">
                    </div>
                </div>
                
                <div class="report-type" onclick="document.getElementById('reportServiceYears').checked=true; showInput('serviceYears')">
                    <input type="radio" name="reportType" id="reportServiceYears" value="serviceYears">
                    <label>Employees with N or more years of service</label>
                    <div class="report-desc">Find employees who have worked for N years or more</div>
                    <div id="yearsInput" class="input-group">
                        <label>Minimum Years: </label>
                        <input type="number" name="years" min="0" placeholder="e.g., 2">
                    </div>
                </div>
                
                <div class="report-type" onclick="document.getElementById('reportMinSalary').checked=true; showInput('minSalary')">
                    <input type="radio" name="reportType" id="reportMinSalary" value="minSalary">
                    <label>Employees earning more than a specified salary</label>
                    <div class="report-desc">Find employees with salary above a certain amount</div>
                    <div id="salaryInput" class="input-group">
                        <label>Minimum Salary (₹): </label>
                        <input type="number" name="salary" step="0.01" placeholder="e.g., 50000">
                    </div>
                </div>
                
                <hr>
                <button type="submit">Generate Report</button>
            </form>
            
            <a href="index.jsp" class="back-link">← Back to Main Menu</a>
        </div>
    </div>
</body>
</html>
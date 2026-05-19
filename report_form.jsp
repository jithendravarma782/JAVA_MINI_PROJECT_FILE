<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Form</title>
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
            max-width: 500px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        h2 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        
        select, input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            width: 100%;
            color: #667eea;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Generate Report</h2>
        
        <form action="reportServlet" method="post">
            <div class="form-group">
                <label>Report Type:</label>
                <select name="reportType" required>
                    <option value="">Select Report Type</option>
                    <option value="department">Department-wise Report</option>
                    <option value="salaryRange">Salary Range Report</option>
                    <option value="summary">Salary Summary Report</option>
                </select>
            </div>
            
            <div class="form-group" id="departmentDiv" style="display:none;">
                <label>Department:</label>
                <select name="department">
                    <option value="IT">IT</option>
                    <option value="HR">HR</option>
                    <option value="Finance">Finance</option>
                    <option value="Marketing">Marketing</option>
                    <option value="Sales">Sales</option>
                </select>
            </div>
            
            <div class="form-group" id="salaryRangeDiv" style="display:none;">
                <label>Minimum Salary:</label>
                <input type="number" name="minSalary" step="1000">
                <label style="margin-top:10px;">Maximum Salary:</label>
                <input type="number" name="maxSalary" step="1000">
            </div>
            
            <button type="submit">Generate Report</button>
        </form>
        
        <a href="reports.jsp" class="back-link">← Back to Reports</a>
    </div>
    
    <script>
        document.querySelector('select[name="reportType"]').addEventListener('change', function() {
            var departmentDiv = document.getElementById('departmentDiv');
            var salaryRangeDiv = document.getElementById('salaryRangeDiv');
            
            departmentDiv.style.display = 'none';
            salaryRangeDiv.style.display = 'none';
            
            if (this.value === 'department') {
                departmentDiv.style.display = 'block';
            } else if (this.value === 'salaryRange') {
                salaryRangeDiv.style.display = 'block';
            }
        });
    </script>
</body>
</html>
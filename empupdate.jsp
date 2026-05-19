<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Employee" %>
<%@ page import="com.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Employee | HR Pro Suite</title>
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
            font-size: 32px;
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
        
        /* Search Section */
        .search-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 24px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .search-section h3 {
            color: white;
            font-size: 18px;
            margin-bottom: 20px;
            text-align: center;
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
            border-color: #667eea;
            background: rgba(255, 255, 255, 0.12);
        }
        
        .search-input-group input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        
        .search-btn {
            padding: 14px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
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
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        /* Info Card */
        .info-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.2), rgba(118, 75, 162, 0.2));
            border: 1px solid rgba(102, 126, 234, 0.5);
            border-radius: 20px;
            padding: 15px 20px;
            text-align: center;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .info-card i {
            font-size: 20px;
            color: #667eea;
        }
        
        .info-card span {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }
        
        /* Form Groups */
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            font-size: 14px;
        }
        
        .form-group label i {
            margin-right: 8px;
            color: #667eea;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 14px 18px;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            font-size: 15px;
            color: white;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.3);
        }
        
        .form-group input[readonly] {
            background: rgba(255, 255, 255, 0.05);
            cursor: not-allowed;
            border-color: rgba(255, 255, 255, 0.05);
        }
        
        /* Error & Success Styles */
        .error-message {
            font-size: 12px;
            margin-top: 8px;
            display: none;
        }
        
        .input-error {
            border-color: #ff6b6b !important;
            background: rgba(255, 107, 107, 0.1) !important;
        }
        
        .input-success {
            border-color: #4caf50 !important;
            background: rgba(76, 175, 80, 0.05) !important;
        }
        
        /* Field Hint */
        .field-hint {
            font-size: 11px;
            color: rgba(255, 255, 255, 0.4);
            margin-top: 8px;
        }
        
        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 20px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
            font-family: 'Poppins', sans-serif;
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }
        
        .submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
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
        
        /* Required Star */
        .required-star {
            color: #ff6b6b;
            margin-left: 4px;
        }
        
        /* Select Dropdown Custom */
        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 24 24'%3E%3Cpath d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 18px center;
            background-size: 20px;
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
        }
    </style>
    <script>
        function validateName() {
            var name = document.getElementById('name');
            var nameValue = name.value;
            var errorSpan = document.getElementById('nameError');
            var submitBtn = document.getElementById('submitBtn');
            var nameRegex = /^[A-Za-z\s]+$/;
            
            if (nameValue.trim() === "") {
                errorSpan.innerHTML = "<i class='fas fa-exclamation-circle'></i> Name is required!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                name.classList.add('input-error');
                name.classList.remove('input-success');
                if (submitBtn) submitBtn.disabled = true;
                return false;
            }
            else if (!nameRegex.test(nameValue)) {
                errorSpan.innerHTML = "<i class='fas fa-times-circle'></i> Only letters and spaces allowed!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                name.classList.add('input-error');
                name.classList.remove('input-success');
                if (submitBtn) submitBtn.disabled = true;
                return false;
            }
            else {
                errorSpan.innerHTML = "<i class='fas fa-check-circle'></i> Valid name!";
                errorSpan.style.color = "#4caf50";
                errorSpan.style.display = "block";
                name.classList.remove('input-error');
                name.classList.add('input-success');
                if (submitBtn) submitBtn.disabled = false;
                return true;
            }
        }
        
        function validateSalary() {
            var salary = document.getElementById('salary');
            var salaryValue = parseFloat(salary.value);
            var errorSpan = document.getElementById('salaryError');
            var submitBtn = document.getElementById('submitBtn');
            
            if (isNaN(salaryValue) || salary.value.trim() === "") {
                errorSpan.innerHTML = "<i class='fas fa-exclamation-circle'></i> Salary is required!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                salary.classList.add('input-error');
                salary.classList.remove('input-success');
                if (submitBtn) submitBtn.disabled = true;
                return false;
            }
            else if (salaryValue <= 0) {
                errorSpan.innerHTML = "<i class='fas fa-times-circle'></i> Salary must be greater than zero!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                salary.classList.add('input-error');
                salary.classList.remove('input-success');
                if (submitBtn) submitBtn.disabled = true;
                return false;
            }
            else {
                errorSpan.innerHTML = "<i class='fas fa-check-circle'></i> Valid salary!";
                errorSpan.style.color = "#4caf50";
                errorSpan.style.display = "block";
                salary.classList.remove('input-error');
                salary.classList.add('input-success');
                if (submitBtn) submitBtn.disabled = false;
                return true;
            }
        }
        
        function validateForm() {
            var isNameValid = validateName();
            var isSalaryValid = validateSalary();
            return isNameValid && isSalaryValid;
        }
        
        window.onload = function() {
            var nameField = document.getElementById('name');
            var salaryField = document.getElementById('salary');
            if (nameField && nameField.value.trim() !== "") {
                validateName();
            }
            if (salaryField && salaryField.value.trim() !== "") {
                validateSalary();
            }
        };
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
                    <i class="fas fa-user-edit"></i>
                </div>
                <h1>Update Employee</h1>
                <p>Modify employee information and salary details</p>
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
            
            <div class="search-section">
                <h3><i class="fas fa-search"></i> Find Employee</h3>
                <form action="updateEmployee" method="get">
                    <div class="search-input-group">
                        <input type="text" name="employeeId" placeholder="Enter Employee ID (e.g., EMP001)" 
                               value="<%= request.getParameter("employeeId") != null ? request.getParameter("employeeId") : "" %>" required>
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </form>
            </div>
            
            <%
            Employee emp = (Employee) request.getAttribute("employee");
            if (emp != null) {
            %>
                <div class="info-card">
                    <i class="fas fa-info-circle"></i>
                    <span>📝 Update the employee information below</span>
                </div>
                
                <form action="updateEmployee" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="id" value="<%= emp.getId() %>">
                    
                    <div class="form-group">
                        <label><i class="fas fa-id-card"></i> Employee ID</label>
                        <input type="text" name="employeeId" value="<%= emp.getEmployeeId() %>" readonly>
                        <div class="field-hint"><i class="fas fa-lock"></i> Employee ID cannot be changed</div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Full Name <span class="required-star">*</span></label>
                        <input type="text" id="name" name="name" value="<%= emp.getName() %>" 
                               onkeyup="validateName()" onblur="validateName()" required>
                        <div id="nameError" class="error-message"></div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-building"></i> Department <span class="required-star">*</span></label>
                        <select name="department" required>
                            <option value="IT" <%= emp.getDepartment().equals("IT") ? "selected" : "" %>>💻 Information Technology</option>
                            <option value="HR" <%= emp.getDepartment().equals("HR") ? "selected" : "" %>>👥 Human Resources</option>
                            <option value="Finance" <%= emp.getDepartment().equals("Finance") ? "selected" : "" %>>💰 Finance & Accounting</option>
                            <option value="Marketing" <%= emp.getDepartment().equals("Marketing") ? "selected" : "" %>>📢 Marketing & Communications</option>
                            <option value="Sales" <%= emp.getDepartment().equals("Sales") ? "selected" : "" %>>🤝 Sales & Business Development</option>
                            <option value="Operations" <%= emp.getDepartment().equals("Operations") ? "selected" : "" %>>⚙️ Operations Management</option>
                            <option value="R&D" <%= emp.getDepartment().equals("R&D") ? "selected" : "" %>>🔬 Research & Development</option>
                            <option value="Customer Support" <%= emp.getDepartment().equals("Customer Support") ? "selected" : "" %>>🎧 Customer Support</option>
                            <option value="Legal" <%= emp.getDepartment().equals("Legal") ? "selected" : "" %>>⚖️ Legal & Compliance</option>
                            <option value="Administration" <%= emp.getDepartment().equals("Administration") ? "selected" : "" %>>📁 Administration</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-briefcase"></i> Designation <span class="required-star">*</span></label>
                        <select name="designation" required>
                            <option value="Software Developer" <%= emp.getDesignation().equals("Software Developer") ? "selected" : "" %>>💻 Software Developer</option>
                            <option value="Senior Software Developer" <%= emp.getDesignation().equals("Senior Software Developer") ? "selected" : "" %>>👨‍💻 Senior Software Developer</option>
                            <option value="Team Lead" <%= emp.getDesignation().equals("Team Lead") ? "selected" : "" %>>👥 Team Lead</option>
                            <option value="Project Manager" <%= emp.getDesignation().equals("Project Manager") ? "selected" : "" %>>📋 Project Manager</option>
                            <option value="Technical Architect" <%= emp.getDesignation().equals("Technical Architect") ? "selected" : "" %>>🏗️ Technical Architect</option>
                            <option value="HR Executive" <%= emp.getDesignation().equals("HR Executive") ? "selected" : "" %>>👤 HR Executive</option>
                            <option value="HR Manager" <%= emp.getDesignation().equals("HR Manager") ? "selected" : "" %>>👔 HR Manager</option>
                            <option value="Recruiter" <%= emp.getDesignation().equals("Recruiter") ? "selected" : "" %>>🎯 Recruiter</option>
                            <option value="Accountant" <%= emp.getDesignation().equals("Accountant") ? "selected" : "" %>>💰 Accountant</option>
                            <option value="Financial Analyst" <%= emp.getDesignation().equals("Financial Analyst") ? "selected" : "" %>>📊 Financial Analyst</option>
                            <option value="Finance Manager" <%= emp.getDesignation().equals("Finance Manager") ? "selected" : "" %>>💼 Finance Manager</option>
                            <option value="Marketing Executive" <%= emp.getDesignation().equals("Marketing Executive") ? "selected" : "" %>>📢 Marketing Executive</option>
                            <option value="Marketing Manager" <%= emp.getDesignation().equals("Marketing Manager") ? "selected" : "" %>>🎨 Marketing Manager</option>
                            <option value="SEO Specialist" <%= emp.getDesignation().equals("SEO Specialist") ? "selected" : "" %>>🔍 SEO Specialist</option>
                            <option value="Content Writer" <%= emp.getDesignation().equals("Content Writer") ? "selected" : "" %>>✍️ Content Writer</option>
                            <option value="Sales Executive" <%= emp.getDesignation().equals("Sales Executive") ? "selected" : "" %>>🤝 Sales Executive</option>
                            <option value="Sales Manager" <%= emp.getDesignation().equals("Sales Manager") ? "selected" : "" %>>📈 Sales Manager</option>
                            <option value="Business Analyst" <%= emp.getDesignation().equals("Business Analyst") ? "selected" : "" %>>📐 Business Analyst</option>
                            <option value="Data Scientist" <%= emp.getDesignation().equals("Data Scientist") ? "selected" : "" %>>📊 Data Scientist</option>
                            <option value="DevOps Engineer" <%= emp.getDesignation().equals("DevOps Engineer") ? "selected" : "" %>>⚙️ DevOps Engineer</option>
                            <option value="QA Tester" <%= emp.getDesignation().equals("QA Tester") ? "selected" : "" %>>🧪 QA Tester</option>
                            <option value="System Administrator" <%= emp.getDesignation().equals("System Administrator") ? "selected" : "" %>>🖥️ System Administrator</option>
                            <option value="Database Administrator" <%= emp.getDesignation().equals("Database Administrator") ? "selected" : "" %>>🗄️ Database Administrator</option>
                            <option value="Network Engineer" <%= emp.getDesignation().equals("Network Engineer") ? "selected" : "" %>>🌐 Network Engineer</option>
                            <option value="Security Analyst" <%= emp.getDesignation().equals("Security Analyst") ? "selected" : "" %>>🔒 Security Analyst</option>
                            <option value="UI/UX Designer" <%= emp.getDesignation().equals("UI/UX Designer") ? "selected" : "" %>>🎨 UI/UX Designer</option>
                            <option value="Product Manager" <%= emp.getDesignation().equals("Product Manager") ? "selected" : "" %>>📦 Product Manager</option>
                            <option value="Operations Manager" <%= emp.getDesignation().equals("Operations Manager") ? "selected" : "" %>>⚙️ Operations Manager</option>
                            <option value="Customer Support Executive" <%= emp.getDesignation().equals("Customer Support Executive") ? "selected" : "" %>>🎧 Customer Support Executive</option>
                            <option value="Legal Advisor" <%= emp.getDesignation().equals("Legal Advisor") ? "selected" : "" %>>⚖️ Legal Advisor</option>
                            <option value="Administrative Officer" <%= emp.getDesignation().equals("Administrative Officer") ? "selected" : "" %>>📁 Administrative Officer</option>
                        </select>
                        <div class="field-hint">📋 Select from 30+ designations available</div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-rupee-sign"></i> Salary <span class="required-star">*</span></label>
                        <input type="number" id="salary" name="salary" step="1000" min="1" 
                               value="<%= emp.getSalary() %>" 
                               oninput="validateSalary()" onblur="validateSalary()" required>
                        <div id="salaryError" class="error-message"></div>
                        <div class="field-hint">💰 Minimum salary: ₹1,000 | Maximum: ₹1,00,00,000</div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-calendar-alt"></i> Joining Date <span class="required-star">*</span></label>
                        <input type="date" name="joiningDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(emp.getJoiningDate()) %>" required>
                    </div>
                    
                    <button type="submit" id="submitBtn" class="submit-btn">
                        <i class="fas fa-save"></i>
                        <span>Update Employee</span>
                        <i class="fas fa-arrow-right"></i>
                    </button>
                </form>
            <% } else if (request.getParameter("employeeId") != null && !request.getParameter("employeeId").trim().isEmpty()) { %>
                <div class="message error">
                    <i class="fas fa-user-slash"></i> No employee found with ID: <%= request.getParameter("employeeId") %>
                </div>
            <% } %>
            
            <div style="text-align: center;">
                <a href="index.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>
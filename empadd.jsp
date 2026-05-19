<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee | HR Pro Suite</title>
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
            overflow-x: hidden;
            position: relative;
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
            padding: 30px 20px;
        }
        
        /* Card Design */
        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border-radius: 40px;
            padding: 45px;
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
        
        /* Auto ID Card */
        .auto-id-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.2), rgba(118, 75, 162, 0.2));
            border: 1px solid rgba(102, 126, 234, 0.5);
            border-radius: 24px;
            padding: 20px;
            text-align: center;
            margin-bottom: 35px;
            position: relative;
            overflow: hidden;
        }
        
        .auto-id-card::before {
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
        
        .auto-id-card .label {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 8px;
        }
        
        .auto-id-card .id-value {
            font-size: 42px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, #a8c0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            letter-spacing: 4px;
        }
        
        /* Form Groups */
        .form-group {
            margin-bottom: 25px;
            position: relative;
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
        
        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        
        /* Floating Label Effect */
        .form-group.floating {
            position: relative;
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
        
        .submit-btn:active {
            transform: translateY(0);
        }
        
        /* Back Link */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .back-link:hover {
            color: white;
            transform: translateX(-5px);
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
        
        /* Field Hint */
        .field-hint {
            font-size: 11px;
            color: rgba(255, 255, 255, 0.4);
            margin-top: 6px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .glass-card {
                padding: 30px 25px;
            }
            
            .header-section h1 {
                font-size: 26px;
            }
            
            .auto-id-card .id-value {
                font-size: 32px;
            }
        }
        
        /* Custom Select Arrow */
        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 24 24'%3E%3Cpath d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 18px center;
            background-size: 20px;
        }
        
        /* Radio/Checkbox Styles */
        .required-star {
            color: #ff6b6b;
            margin-left: 4px;
        }
    </style>
    <script>
        function validateName() {
            const name = document.getElementById('name');
            const nameValue = name.value;
            const errorSpan = document.getElementById('nameError');
            const nameRegex = /^[A-Za-z\s]+$/;
            
            if (nameValue.trim() === "") {
                errorSpan.innerHTML = "<i class='fas fa-exclamation-circle'></i> Name is required!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                name.classList.add('input-error');
                name.classList.remove('input-success');
                return false;
            }
            else if (!nameRegex.test(nameValue)) {
                errorSpan.innerHTML = "<i class='fas fa-times-circle'></i> Only letters and spaces allowed!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                name.classList.add('input-error');
                name.classList.remove('input-success');
                return false;
            }
            else {
                errorSpan.innerHTML = "<i class='fas fa-check-circle'></i> Valid name!";
                errorSpan.style.color = "#4caf50";
                errorSpan.style.display = "block";
                name.classList.remove('input-error');
                name.classList.add('input-success');
                return true;
            }
        }
        
        function validateSalary() {
            const salary = document.getElementById('salary');
            const salaryValue = parseFloat(salary.value);
            const errorSpan = document.getElementById('salaryError');
            
            if (isNaN(salaryValue) || salary.value.trim() === "") {
                errorSpan.innerHTML = "<i class='fas fa-exclamation-circle'></i> Salary is required!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                salary.classList.add('input-error');
                salary.classList.remove('input-success');
                return false;
            }
            else if (salaryValue <= 0) {
                errorSpan.innerHTML = "<i class='fas fa-times-circle'></i> Salary must be greater than zero!";
                errorSpan.style.color = "#ff6b6b";
                errorSpan.style.display = "block";
                salary.classList.add('input-error');
                salary.classList.remove('input-success');
                return false;
            }
            else {
                errorSpan.innerHTML = "<i class='fas fa-check-circle'></i> Valid salary!";
                errorSpan.style.color = "#4caf50";
                errorSpan.style.display = "block";
                salary.classList.remove('input-error');
                salary.classList.add('input-success');
                return true;
            }
        }
        
        function validateForm() {
            const isNameValid = validateName();
            const isSalaryValid = validateSalary();
            return isNameValid && isSalaryValid;
        }
        
        // Real-time validation
        document.addEventListener('DOMContentLoaded', function() {
            const nameInput = document.getElementById('name');
            const salaryInput = document.getElementById('salary');
            
            if (nameInput) {
                nameInput.addEventListener('input', validateName);
                nameInput.addEventListener('blur', validateName);
            }
            if (salaryInput) {
                salaryInput.addEventListener('input', validateSalary);
                salaryInput.addEventListener('blur', validateSalary);
            }
        });
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
                    <i class="fas fa-user-astronaut"></i>
                </div>
                <h1>Welcome Aboard! 🚀</h1>
                <p>Fill in the details to add a new team member</p>
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
            
            EmployeeDAO dao = new EmployeeDAO();
            String newEmployeeId = dao.generateNextEmployeeId();
            %>
            
            <div class="auto-id-card">
                <div class="label">
                    <i class="fas fa-id-card"></i> AUTO-GENERATED ID
                </div>
                <div class="id-value"><%= newEmployeeId %></div>
                <div class="field-hint" style="margin-top: 8px;">✨ This ID will be assigned automatically</div>
            </div>
            
            <form action="addEmployee" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="employeeId" value="<%= newEmployeeId %>">
                
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Full Name <span class="required-star">*</span></label>
                    <input type="text" id="name" name="name" 
                           placeholder="e.g., John Doe" 
                           onkeyup="validateName()" onblur="validateName()" 
                           required autocomplete="off">
                    <div id="nameError" class="error-message"></div>
                    <div class="field-hint">✅ Only letters (A-Z) and spaces allowed</div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-building"></i> Department <span class="required-star">*</span></label>
                    <select name="department" required>
                        <option value="">— Select Department —</option>
                        <option value="IT">💻 Information Technology</option>
                        <option value="HR">👥 Human Resources</option>
                        <option value="Finance">💰 Finance & Accounting</option>
                        <option value="Marketing">📢 Marketing & Communications</option>
                        <option value="Sales">🤝 Sales & Business Development</option>
                        <option value="Operations">⚙️ Operations Management</option>
                        <option value="R&D">🔬 Research & Development</option>
                        <option value="Customer Support">🎧 Customer Support</option>
                        <option value="Legal">⚖️ Legal & Compliance</option>
                        <option value="Administration">📁 Administration</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-briefcase"></i> Designation <span class="required-star">*</span></label>
                    <select name="designation" required>
                        <option value="">— Select Designation —</option>
                        <option value="Software Developer">💻 Software Developer</option>
                        <option value="Senior Software Developer">👨‍💻 Senior Software Developer</option>
                        <option value="Team Lead">👥 Team Lead</option>
                        <option value="Project Manager">📋 Project Manager</option>
                        <option value="Technical Architect">🏗️ Technical Architect</option>
                        <option value="HR Executive">👤 HR Executive</option>
                        <option value="HR Manager">👔 HR Manager</option>
                        <option value="Recruiter">🎯 Recruiter</option>
                        <option value="Accountant">💰 Accountant</option>
                        <option value="Financial Analyst">📊 Financial Analyst</option>
                        <option value="Finance Manager">💼 Finance Manager</option>
                        <option value="Marketing Executive">📢 Marketing Executive</option>
                        <option value="Marketing Manager">🎨 Marketing Manager</option>
                        <option value="SEO Specialist">🔍 SEO Specialist</option>
                        <option value="Content Writer">✍️ Content Writer</option>
                        <option value="Sales Executive">🤝 Sales Executive</option>
                        <option value="Sales Manager">📈 Sales Manager</option>
                        <option value="Business Analyst">📐 Business Analyst</option>
                        <option value="Data Scientist">📊 Data Scientist</option>
                        <option value="DevOps Engineer">⚙️ DevOps Engineer</option>
                        <option value="QA Tester">🧪 QA Tester</option>
                        <option value="System Administrator">🖥️ System Administrator</option>
                        <option value="Database Administrator">🗄️ Database Administrator</option>
                        <option value="Network Engineer">🌐 Network Engineer</option>
                        <option value="Security Analyst">🔒 Security Analyst</option>
                        <option value="UI/UX Designer">🎨 UI/UX Designer</option>
                        <option value="Product Manager">📦 Product Manager</option>
                        <option value="Operations Manager">⚙️ Operations Manager</option>
                        <option value="Customer Support Executive">🎧 Customer Support Executive</option>
                        <option value="Legal Advisor">⚖️ Legal Advisor</option>
                        <option value="Administrative Officer">📁 Administrative Officer</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-rupee-sign"></i> Salary <span class="required-star">*</span></label>
                    <input type="number" id="salary" name="salary" 
                           step="1000" min="1" 
                           placeholder="Enter salary amount" 
                           oninput="validateSalary()" onblur="validateSalary()" 
                           required autocomplete="off">
                    <div id="salaryError" class="error-message"></div>
                    <div class="field-hint">💰 Minimum salary: ₹1,000 | Maximum: ₹1,00,00,000</div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-calendar-alt"></i> Joining Date <span class="required-star">*</span></label>
                    <input type="date" name="joiningDate" required>
                </div>
                
                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i> 
                    <span>Add Employee</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
            </form>
            
            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>
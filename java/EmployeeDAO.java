package com.dao;

import com.model.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class EmployeeDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/employee_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "password"; // Change this to your MySQL password
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
    
    // ==================== AUTO-GENERATE EMPLOYEE ID ====================
    
    public String generateNextEmployeeId() {
        String sql = "SELECT employee_id FROM employees ORDER BY id DESC LIMIT 1";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                String lastId = rs.getString("employee_id");
                
                // Extract the number part (e.g., EMP001 -> 001)
                if (lastId != null && lastId.length() >= 6) {
                    String numberPart = lastId.substring(3);
                    int nextNumber = Integer.parseInt(numberPart) + 1;
                    return String.format("EMP%03d", nextNumber);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // If no employees exist or error occurs, return first ID
        return "EMP001";
    }
    
    // ==================== CREATE / ADD EMPLOYEE ====================
    
    public boolean addEmployee(Employee employee) {
        String sql = "INSERT INTO employees (employee_id, name, department, designation, salary, joining_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, employee.getEmployeeId());
            pstmt.setString(2, employee.getName());
            pstmt.setString(3, employee.getDepartment());
            pstmt.setString(4, employee.getDesignation());
            pstmt.setBigDecimal(5, employee.getSalary());
            pstmt.setDate(6, new java.sql.Date(employee.getJoiningDate().getTime()));
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ==================== READ / GET EMPLOYEES ====================
    
    public Employee getEmployee(int id) {
        String sql = "SELECT * FROM employees WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractEmployee(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Employee getEmployeeByEmployeeId(String employeeId) {
        String sql = "SELECT * FROM employees WHERE employee_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, employeeId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractEmployee(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees ORDER BY employee_id";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    public boolean employeeExists(String employeeId) {
        String sql = "SELECT COUNT(*) FROM employees WHERE employee_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, employeeId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // ==================== UPDATE EMPLOYEE ====================
    
    public boolean updateEmployee(Employee employee) {
        String sql = "UPDATE employees SET name=?, department=?, designation=?, salary=?, joining_date=? WHERE employee_id=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, employee.getName());
            pstmt.setString(2, employee.getDepartment());
            pstmt.setString(3, employee.getDesignation());
            pstmt.setBigDecimal(4, employee.getSalary());
            pstmt.setDate(5, new java.sql.Date(employee.getJoiningDate().getTime()));
            pstmt.setString(6, employee.getEmployeeId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ==================== DELETE EMPLOYEE ====================
    
    public boolean deleteEmployeeByEmployeeId(String employeeId) {
        String sql = "DELETE FROM employees WHERE employee_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, employeeId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ==================== BASIC REPORTS & STATISTICS ====================
    
    public List<Employee> getEmployeesByDepartment(String department) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE department = ? ORDER BY salary DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, department);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    public List<Employee> getEmployeesBySalaryRange(BigDecimal min, BigDecimal max) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE salary BETWEEN ? AND ? ORDER BY salary DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBigDecimal(1, min);
            pstmt.setBigDecimal(2, max);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    public double getAverageSalary() {
        String sql = "SELECT AVG(salary) as avg_salary FROM employees";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getDouble("avg_salary");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalEmployeeCount() {
        String sql = "SELECT COUNT(*) as total FROM employees";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // ==================== NEW METHODS FOR REPORTS ====================
    
    // Get total salary sum
    public BigDecimal getTotalSalarySum() {
        String sql = "SELECT SUM(salary) as total_salary FROM employees";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getBigDecimal("total_salary");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Get maximum salary
    public BigDecimal getMaxSalary() {
        String sql = "SELECT MAX(salary) as max_salary FROM employees";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getBigDecimal("max_salary");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Get minimum salary
    public BigDecimal getMinSalary() {
        String sql = "SELECT MIN(salary) as min_salary FROM employees";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getBigDecimal("min_salary");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Get employees by first letter of name
    public List<Employee> getEmployeesByFirstLetter(String letter) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE UPPER(SUBSTRING(name, 1, 1)) = ? ORDER BY name";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, letter.toUpperCase());
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get employees by experience years
    public List<Employee> getEmployeesByExperienceYears(String experienceLevel) {
        List<Employee> employees = new ArrayList<>();
        String sql = "";
        
        switch(experienceLevel) {
            case "0-1":
                sql = "SELECT * FROM employees WHERE DATEDIFF(CURDATE(), joining_date) < 365 ORDER BY joining_date DESC";
                break;
            case "1-3":
                sql = "SELECT * FROM employees WHERE DATEDIFF(CURDATE(), joining_date) BETWEEN 365 AND 1095 ORDER BY joining_date DESC";
                break;
            case "3-5":
                sql = "SELECT * FROM employees WHERE DATEDIFF(CURDATE(), joining_date) BETWEEN 1096 AND 1825 ORDER BY joining_date DESC";
                break;
            case "5-10":
                sql = "SELECT * FROM employees WHERE DATEDIFF(CURDATE(), joining_date) BETWEEN 1826 AND 3650 ORDER BY joining_date DESC";
                break;
            case "10+":
                sql = "SELECT * FROM employees WHERE DATEDIFF(CURDATE(), joining_date) > 3650 ORDER BY joining_date DESC";
                break;
            default:
                sql = "SELECT * FROM employees";
        }
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get top earners
    public List<Employee> getTopEarners(int limit) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees ORDER BY salary DESC LIMIT ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get employees by joining year
    public List<Employee> getEmployeesByJoiningYear(int year) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE YEAR(joining_date) = ? ORDER BY joining_date";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, year);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get employees by designation
    public List<Employee> getEmployeesByDesignation(String designation) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE designation = ? ORDER BY salary DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, designation);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get department statistics
    public List<Object[]> getDepartmentStatistics() {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT department, COUNT(*) as emp_count, ROUND(AVG(salary), 2) as avg_salary, SUM(salary) as total_salary, MAX(salary) as max_salary, MIN(salary) as min_salary FROM employees GROUP BY department ORDER BY department";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] row = new Object[6];
                row[0] = rs.getString("department");
                row[1] = rs.getInt("emp_count");
                row[2] = rs.getDouble("avg_salary");
                row[3] = rs.getBigDecimal("total_salary");
                row[4] = rs.getBigDecimal("max_salary");
                row[5] = rs.getBigDecimal("min_salary");
                stats.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    // Get salary distribution
    public List<Object[]> getSalaryDistribution() {
        List<Object[]> distribution = new ArrayList<>();
        String sql = "SELECT " +
                     "CASE " +
                     "WHEN salary < 30000 THEN 'Below 30K' " +
                     "WHEN salary BETWEEN 30000 AND 50000 THEN '30K - 50K' " +
                     "WHEN salary BETWEEN 50001 AND 70000 THEN '50K - 70K' " +
                     "WHEN salary BETWEEN 70001 AND 90000 THEN '70K - 90K' " +
                     "ELSE 'Above 90K' END as salary_range, " +
                     "COUNT(*) as employee_count, " +
                     "ROUND(AVG(salary), 2) as average_salary, " +
                     "SUM(salary) as total_salary " +
                     "FROM employees GROUP BY salary_range ORDER BY MIN(salary)";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] row = new Object[4];
                row[0] = rs.getString("salary_range");
                row[1] = rs.getInt("employee_count");
                row[2] = rs.getDouble("average_salary");
                row[3] = rs.getBigDecimal("total_salary");
                distribution.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }
    
    // Get recent hires
    public List<Employee> getRecentHires(int days) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE joining_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) ORDER BY joining_date DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, days);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get employees with high salary (above threshold)
    public List<Employee> getEmployeesWithHighSalary(BigDecimal threshold) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE salary > ? ORDER BY salary DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBigDecimal(1, threshold);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get employees with low salary (below threshold)
    public List<Employee> getEmployeesWithLowSalary(BigDecimal threshold) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE salary < ? ORDER BY salary ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBigDecimal(1, threshold);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Search employees by name
    public List<Employee> searchEmployeesByName(String name) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE LOWER(name) LIKE LOWER(?) ORDER BY name";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + name + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get upcoming work anniversaries
    public List<Employee> getUpcomingAnniversaries(int days) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE DAY(joining_date) BETWEEN DAY(CURDATE()) AND DAY(DATE_ADD(CURDATE(), INTERVAL ? DAY)) ORDER BY DAY(joining_date)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, days);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                employees.add(extractEmployee(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Calculate salary increments
    public List<Object[]> calculateIncrements(int percentage, BigDecimal minSalary) {
        List<Object[]> increments = new ArrayList<>();
        String sql = "SELECT employee_id, name, department, designation, salary, " +
                     "ROUND(salary * (1 + ? / 100), 2) as new_salary, " +
                     "ROUND(salary * (? / 100), 2) as increment_amount " +
                     "FROM employees WHERE salary >= ? ORDER BY salary DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, percentage);
            pstmt.setInt(2, percentage);
            pstmt.setBigDecimal(3, minSalary);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Object[] row = new Object[7];
                row[0] = rs.getString("employee_id");
                row[1] = rs.getString("name");
                row[2] = rs.getString("department");
                row[3] = rs.getString("designation");
                row[4] = rs.getBigDecimal("salary");
                row[5] = rs.getBigDecimal("new_salary");
                row[6] = rs.getBigDecimal("increment_amount");
                increments.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return increments;
    }
    
    // Helper method to calculate experience
    public double getEmployeeExperience(Employee employee) {
        long diffInMillies = System.currentTimeMillis() - employee.getJoiningDate().getTime();
        return diffInMillies / (1000.0 * 60 * 60 * 24 * 365);
    }
    
    // ==================== HELPER METHODS ====================
    
    private Employee extractEmployee(ResultSet rs) throws SQLException {
        Employee emp = new Employee();
        emp.setId(rs.getInt("id"));
        emp.setEmployeeId(rs.getString("employee_id"));
        emp.setName(rs.getString("name"));
        emp.setDepartment(rs.getString("department"));
        emp.setDesignation(rs.getString("designation"));
        emp.setSalary(rs.getBigDecimal("salary"));
        emp.setJoiningDate(rs.getDate("joining_date"));
        return emp;
    }
}
package com.dao;

import com.model.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {
    
    private static final String URL = "jdbc:mysql://localhost:3306/employee_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root"; // Change this
    
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
    
    // Add Employee
    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO Employee (Empno, EmpName, DoJ, Gender, Bsalary) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, emp.getEmpno());
            pstmt.setString(2, emp.getEmpName());
            pstmt.setDate(3, emp.getDoj());
            pstmt.setString(4, emp.getGender());
            pstmt.setDouble(5, emp.getBsalary());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update Employee
    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE Employee SET EmpName=?, DoJ=?, Gender=?, Bsalary=? WHERE Empno=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, emp.getEmpName());
            pstmt.setDate(2, emp.getDoj());
            pstmt.setString(3, emp.getGender());
            pstmt.setDouble(4, emp.getBsalary());
            pstmt.setInt(5, emp.getEmpno());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete Employee
    public boolean deleteEmployee(int empno) {
        String sql = "DELETE FROM Employee WHERE Empno=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, empno);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get Employee by Empno
    public Employee getEmployee(int empno) {
        String sql = "SELECT * FROM Employee WHERE Empno=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, empno);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Employee(
                    rs.getInt("Empno"),
                    rs.getString("EmpName"),
                    rs.getDate("DoJ"),
                    rs.getString("Gender"),
                    rs.getDouble("Bsalary")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get All Employees
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM Employee ORDER BY Empno";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                employees.add(new Employee(
                    rs.getInt("Empno"),
                    rs.getString("EmpName"),
                    rs.getDate("DoJ"),
                    rs.getString("Gender"),
                    rs.getDouble("Bsalary")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Report 1: Employees whose names start with a specific letter
    public List<Employee> getEmployeesByNameStart(String letter) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE EmpName LIKE ? ORDER BY EmpName";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, letter + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                employees.add(new Employee(
                    rs.getInt("Empno"),
                    rs.getString("EmpName"),
                    rs.getDate("DoJ"),
                    rs.getString("Gender"),
                    rs.getDouble("Bsalary")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Report 2: Employees with N or more years of service
    public List<Employee> getEmployeesByServiceYears(int years) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE TIMESTAMPDIFF(YEAR, DoJ, CURDATE()) >= ? ORDER BY DoJ";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, years);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                employees.add(new Employee(
                    rs.getInt("Empno"),
                    rs.getString("EmpName"),
                    rs.getDate("DoJ"),
                    rs.getString("Gender"),
                    rs.getDouble("Bsalary")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Report 3: Employees earning more than a specified salary
    public List<Employee> getEmployeesByMinSalary(double salary) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE Bsalary > ? ORDER BY Bsalary DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDouble(1, salary);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                employees.add(new Employee(
                    rs.getInt("Empno"),
                    rs.getString("EmpName"),
                    rs.getDate("DoJ"),
                    rs.getString("Gender"),
                    rs.getDouble("Bsalary")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
}
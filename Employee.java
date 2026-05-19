package com.model;

import java.math.BigDecimal;
import java.util.Date;

public class Employee {
    private int id;
    private String employeeId;
    private String name;
    private String department;
    private String designation;
    private BigDecimal salary;
    private Date joiningDate;
    
    // Constructors
    public Employee() {}
    
    public Employee(int id, String employeeId, String name, String department, 
                   String designation, BigDecimal salary, Date joiningDate) {
        this.id = id;
        this.employeeId = employeeId;
        this.name = name;
        this.department = department;
        this.designation = designation;
        this.salary = salary;
        this.joiningDate = joiningDate;
    }
    
    // Getters and Setters
    public int getId() { 
        return id; 
    }
    
    public void setId(int id) { 
        this.id = id; 
    }
    
    public String getEmployeeId() { 
        return employeeId; 
    }
    
    public void setEmployeeId(String employeeId) { 
        this.employeeId = employeeId; 
    }
    
    public String getName() { 
        return name; 
    }
    
    public void setName(String name) { 
        this.name = name; 
    }
    
    public String getDepartment() { 
        return department; 
    }
    
    public void setDepartment(String department) { 
        this.department = department; 
    }
    
    public String getDesignation() { 
        return designation; 
    }
    
    public void setDesignation(String designation) { 
        this.designation = designation; 
    }
    
    public BigDecimal getSalary() { 
        return salary; 
    }
    
    public void setSalary(BigDecimal salary) { 
        this.salary = salary; 
    }
    
    public Date getJoiningDate() { 
        return joiningDate; 
    }
    
    public void setJoiningDate(Date joiningDate) { 
        this.joiningDate = joiningDate; 
    }
}
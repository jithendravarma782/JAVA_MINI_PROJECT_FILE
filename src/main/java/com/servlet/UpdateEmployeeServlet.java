package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int empno = Integer.parseInt(request.getParameter("empno"));
            String empName = request.getParameter("empName");
            Date doj = Date.valueOf(request.getParameter("doj"));
            String gender = request.getParameter("gender");
            double bsalary = Double.parseDouble(request.getParameter("bsalary"));
            
            Employee emp = new Employee(empno, empName, doj, gender, bsalary);
            EmployeeDAO dao = new EmployeeDAO();
            
            if (dao.updateEmployee(emp)) {
                request.setAttribute("message", "Employee updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Employee not found!");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String empnoStr = request.getParameter("empno");
        if (empnoStr != null && !empnoStr.isEmpty()) {
            try {
                int empno = Integer.parseInt(empnoStr);
                EmployeeDAO dao = new EmployeeDAO();
                Employee emp = dao.getEmployee(empno);
                if (emp != null) {
                    request.setAttribute("employee", emp);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }
}
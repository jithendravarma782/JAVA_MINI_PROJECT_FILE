package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getEmployeeDetails")
public class GetEmployeeDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        String employeeId = request.getParameter("employeeId");
        
        try {
            EmployeeDAO dao = new EmployeeDAO();
            Employee emp = dao.getEmployeeByEmployeeId(employeeId);
            
            PrintWriter out = response.getWriter();
            
            if (emp != null) {
                // Send employee details as pipe-separated values
                out.print("SUCCESS|");
                out.print(emp.getEmployeeId() + "|");
                out.print(emp.getName() + "|");
                out.print(emp.getDepartment() + "|");
                out.print(emp.getDesignation() + "|");
                out.print(emp.getSalary());
            } else {
                out.print("ERROR|Employee not found");
            }
            
            out.flush();
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.print("ERROR|Error: " + e.getMessage());
            out.flush();
        }
    }
}
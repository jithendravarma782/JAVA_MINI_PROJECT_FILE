package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/displayEmployee")
public class DisplayEmployeeServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String empnoStr = request.getParameter("empno");
        EmployeeDAO dao = new EmployeeDAO();
        
        if (empnoStr != null && !empnoStr.isEmpty()) {
            try {
                int empno = Integer.parseInt(empnoStr);
                Employee emp = dao.getEmployee(empno);
                if (emp != null) {
                    request.setAttribute("employee", emp);
                } else {
                    request.setAttribute("message", "Employee not found!");
                }
            } catch (Exception e) {
                request.setAttribute("message", "Error: " + e.getMessage());
            }
        } else {
            List<Employee> employees = dao.getAllEmployees();
            request.setAttribute("employees", employees);
        }
        
        request.getRequestDispatcher("empdisplay.jsp").forward(request, response);
    }
}
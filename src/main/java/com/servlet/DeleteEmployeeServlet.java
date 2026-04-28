package com.servlet;

import com.dao.EmployeeDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int empno = Integer.parseInt(request.getParameter("empno"));
            EmployeeDAO dao = new EmployeeDAO();
            
            if (dao.deleteEmployee(empno)) {
                request.setAttribute("message", "Employee deleted successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Employee not found!");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("empdelete.jsp").forward(request, response);
    }
}
package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;
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
        
        String employeeId = request.getParameter("employeeId");
        
        System.out.println("Attempting to delete employee: " + employeeId);
        
        try {
            EmployeeDAO dao = new EmployeeDAO();
            
            // First check if employee exists
            Employee emp = dao.getEmployeeByEmployeeId(employeeId);
            
            if (emp != null) {
                System.out.println("Employee found: " + emp.getName());
                
                boolean success = dao.deleteEmployeeByEmployeeId(employeeId);
                
                if (success) {
                    System.out.println("Employee deleted successfully!");
                    request.setAttribute("message", "✅ Employee " + employeeId + " deleted successfully!");
                } else {
                    System.out.println("Failed to delete employee!");
                    request.setAttribute("message", "❌ Failed to delete employee!");
                }
            } else {
                System.out.println("Employee NOT found with ID: " + employeeId);
                request.setAttribute("message", "❌ Employee not found with ID: " + employeeId);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("message", "❌ Error: " + e.getMessage());
        }
        
        // Forward back to delete page
        request.getRequestDispatcher("empdelete.jsp").forward(request, response);
    }
}
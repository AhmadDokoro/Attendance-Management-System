/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.LoginDao;
import Model.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //get variables
        String id = request.getParameter("userId");
        String password =request.getParameter("password");
        boolean islecturer = request.getParameter("isLecturer") != null;
        
        if(islecturer)
        {
            //set variables
            Lecturer lec = new Lecturer();
            lec.setEmail(id);
            lec.setPassword(password);
            
            Lecturer lecturer = LoginDao.verifyLecturer(lec);
          
            //verify lectuer
            if(lecturer != null){
                //create the session objeck
                HttpSession session = request.getSession();
                
                //get if there is any leave request for that lecturer
                int pendingCount = LoginDao.hasPendingRequests(lecturer.getId());
                session.setAttribute("pendingLeaveCount", pendingCount);

                session.setAttribute("lecturer", lecturer);
                response.sendRedirect("lecturer/LecturerDashboard.jsp");
            }else
            {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        }else
        {
            //initialize student obj
            Student stud_info = new Student();
            stud_info.setMatric(id);
            stud_info.setPassword(password);
            
            
             //verify lectuer
             Student student = LoginDao.verifyStudent(stud_info);
            if(student != null){
                HttpSession session = request.getSession();
                session.setAttribute("Student", student);
                response.sendRedirect("Student/StudentDashboard.jsp");
            }else
            {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
            
        }
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
 
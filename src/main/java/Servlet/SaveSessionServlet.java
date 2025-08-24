/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.*;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
public class SaveSessionServlet extends HttpServlet {

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
        Lecturer lecturer = (Lecturer) request.getSession().getAttribute("lecturer");
        if (lecturer == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get data from form
        
        String location = request.getParameter("location");
        String programType = request.getParameter("program_type");
        int duration = Integer.parseInt(request.getParameter("duration"));
        LocalTime start = LocalTime.now();  

        // 2. Calculate end time using duration (hours)
        LocalTime end   = start.plusHours(duration);

        // 3. Convert to strings 
        String startTime = start.toString(); 
        String endTime   = end.toString();
       
        //get course code and group id from the form in two 
        String combo = request.getParameter("group_id");
        String[] parts = combo.split(",");
        int groupId = Integer.parseInt(parts[0]);
        String courseCode = parts[1];


        

        // Today's date
        String today = LocalDate.now().toString();

        // Build session object
        Session session = new Session();
        session.setLecturerId(lecturer.getId());
        session.setCourseCode(courseCode);
        session.setLocation(location);
        session.setProgramType(programType);
        session.setDuration(duration);
        session.setStartTime(startTime);
        session.setEndTime(endTime);
        session.setDate(today);
        session.setGroupId(groupId);

        
        // Save to DB
        int sessionId = SessionDao.saveSession(session);

        if (sessionId > 0) {
            // Redirect to QR generation servlet
            response.sendRedirect(request.getContextPath() +"/GenerateQRServlet?session_id=" + sessionId);
        } else {
            response.getWriter().println("Error saving session.");
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

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
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
public class SaveSessionServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SaveSessionServlet.class.getName());
    private static final DateTimeFormatter TIME_FMT = DateTimeFormatter.ofPattern("HH:mm:ss");

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
        try {
            // Get data from form
            String location = request.getParameter("location");
            String programType = request.getParameter("program_type");
            String durationStr = request.getParameter("duration");

            int duration = Integer.parseInt(durationStr);

            // Compute times (format as HH:mm:ss to avoid fractional seconds incompatibilities)
            LocalTime start = LocalTime.now().withNano(0);
            LocalTime end = start.plusHours(duration);
            String startTime = start.format(TIME_FMT);
            String endTime = end.format(TIME_FMT);

            // Get course code and group id from combined value
            String combo = request.getParameter("group_id");
            if (combo == null || !combo.contains(",")) {
                throw new IllegalArgumentException("Invalid course/group selection.");
            }
            String[] parts = combo.split(",", 2);
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

            LOGGER.info("Saving session: lecturerId=" + lecturer.getId()
                    + ", groupId=" + groupId
                    + ", courseCode=" + courseCode
                    + ", programType=" + programType
                    + ", location=" + location
                    + ", startTime=" + startTime
                    + ", endTime=" + endTime
                    + ", date=" + today);

            // Save to DB
            int sessionId = SessionDao.saveSession(session);

            if (sessionId > 0) {
                // Redirect to QR generation servlet
                response.sendRedirect(request.getContextPath() + "/GenerateQRServlet?session_id=" + sessionId);
            } else {
                // DB error already logged in SessionDao
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().println("Error saving session. Please try again or check server logs for details.");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "SaveSession failed: " + e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().println("Error saving session: " + e.getMessage());
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

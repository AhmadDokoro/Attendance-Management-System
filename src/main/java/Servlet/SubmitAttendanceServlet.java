/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.*;
import Model.*;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
public class SubmitAttendanceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String matric = request.getParameter("matric_number");
        String password = request.getParameter("password");
        String sessionIdStr = request.getParameter("session_id");

        if (matric == null || password == null || sessionIdStr == null) {
            response.getWriter().println("Missing input fields.");
            return;
        }

        int sessionId = Integer.parseInt(sessionIdStr);

        // Step 1: Get student_id from matric and password
        int studentId = AttendanceDAO.getStudentId(matric, password);

        if (studentId == -1) {
            response.getWriter().println("Invalid student credentials. Please check your matric number or password.");
            return;
        }

        // Step 2: Check if already scanned
        boolean alreadyMarked = AttendanceDAO.hasMarkedAttendance(studentId, sessionId);
        if (alreadyMarked) {
            response.getWriter().println("Attendance already marked for this session.");
            return;
        }

        // Step 3: Save attendance
        Attendance attendance = new Attendance();
        attendance.setStudentId(studentId);
        attendance.setSessionId(sessionId);
        attendance.setIpAddress(request.getRemoteAddr());

        boolean saved = AttendanceDAO.saveAttendance(attendance);
        if (saved) {
            response.sendRedirect("Student/ScanSuccess.jsp");
        } else {
            response.getWriter().println("Failed to save attendance. Try again.");
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

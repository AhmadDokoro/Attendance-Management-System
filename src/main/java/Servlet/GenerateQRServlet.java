package Servlet;

import Utils.QRUtil;
import com.google.zxing.WriterException;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.*;
import java.net.InetAddress;
import java.util.Base64;
import java.util.UUID;

public class GenerateQRServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sessionIdStr = request.getParameter("session_id");
        if (sessionIdStr == null) {
            response.getWriter().println("Session ID missing.");
            return;
        }

        int sessionId = Integer.parseInt(sessionIdStr);

        // ✅ 1. Generate a secure token
        String token = UUID.randomUUID().toString();

        // ✅ 2. Store it in session to validate later
       getServletContext().setAttribute("qr_token_session_" + sessionId, token);


        // ✅ 3. Include token in QR content
        String serverIP = InetAddress.getLocalHost().getHostAddress();
        String appName = request.getContextPath();
        String qrContent = "http://" + serverIP + ":8080" + appName + "/Student/ScanAttendance.jsp?session_id=" + sessionId + "&token=" + token;

        try {
            ByteArrayOutputStream qrStream = QRUtil.generateQRCode(qrContent, 300, 300);
            String base64QR = Base64.getEncoder().encodeToString(qrStream.toByteArray());

            request.setAttribute("qrImage", base64QR);
            request.setAttribute("sessionId", sessionId);

            RequestDispatcher dispatcher = request.getRequestDispatcher("lecturer/session/ShowQRCode.jsp");
            dispatcher.forward(request, response);

        } catch (WriterException e) {
            e.printStackTrace();
            response.getWriter().println("Failed to generate QR.");
        }
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}


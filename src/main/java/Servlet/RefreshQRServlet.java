package Servlet;

import Utils.QRUtil;
import com.google.zxing.WriterException;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.*;
import java.net.InetAddress;
import java.util.Base64;
import java.util.UUID;

public class RefreshQRServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sessionIdStr = request.getParameter("session_id");
        if (sessionIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("Missing session ID");
            return;
        }

        int sessionId = Integer.parseInt(sessionIdStr);
        String serverIP = InetAddress.getLocalHost().getHostAddress();
        String appName = request.getContextPath();

        // 1. Generate unique token
        String token = UUID.randomUUID().toString();

        // 2. Store in session with sessionId-specific key
        getServletContext().setAttribute("qr_token_session_" + sessionId, token);


        // 3. Append token to QR content
        String qrContent = "http://" + serverIP + ":8080" + appName + "/Student/ScanAttendance.jsp?session_id=" + sessionId + "&token=" + token;

        try {
            ByteArrayOutputStream qrStream = QRUtil.generateQRCode(qrContent, 300, 300);
            String base64QR = Base64.getEncoder().encodeToString(qrStream.toByteArray());

            response.setContentType("text/plain");
            response.getWriter().print(base64QR);

        } catch (WriterException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("QR generation failed");
        }
    }
}



package Servlet;

import Utils.QRUtil;
import Utils.PublicUrlUtil;
import com.google.zxing.WriterException;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.*;
import java.util.Base64;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RefreshQRServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RefreshQRServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sessionIdStr = request.getParameter("session_id");
        if (sessionIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("Missing session ID");
            return;
        }

        int sessionId = Integer.parseInt(sessionIdStr);

        // 1. Generate unique token
        String token = UUID.randomUUID().toString();

        // 2. Store in session with sessionId-specific key
        getServletContext().setAttribute("qr_token_session_" + sessionId, token);

        // 3. Append token to QR content (PUBLIC URL, reverse-proxy safe)
        String relativePath = "/Student/ScanAttendance.jsp?session_id=" + sessionId + "&token=" + token;
        String qrContent = PublicUrlUtil.buildPublicUrl(request, relativePath);

        try {
            ByteArrayOutputStream qrStream = QRUtil.generateQRCode(qrContent, 300, 300);
            String base64QR = Base64.getEncoder().encodeToString(qrStream.toByteArray());

            response.setContentType("text/plain");
            response.getWriter().print(base64QR);

        } catch (WriterException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("QR generation failed");
            LOGGER.log(Level.SEVERE, "QR refresh failed for session_id=" + sessionId + " url=" + qrContent + ": " + e.getMessage(), e);
        }
    }
}



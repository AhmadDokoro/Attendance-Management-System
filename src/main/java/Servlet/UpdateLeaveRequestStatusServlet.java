package Servlet;

import DAO.LoginDao;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;


public class UpdateLeaveRequestStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String requestId = request.getParameter("requestId");
        String action = request.getParameter("action");

        if (requestId == null || action == null || requestId.trim().isEmpty() || action.trim().isEmpty()) {
            response.getWriter().println("Invalid request parameters.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = LoginDao.getConnection();

            String query = "UPDATE leaverequest SET status = ? WHERE request_id = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, action);
            ps.setInt(2, Integer.parseInt(requestId));

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("GetSubmittedLeaveRequestsServlet");
            } else {
                response.getWriter().println("Failed to update leave request.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}


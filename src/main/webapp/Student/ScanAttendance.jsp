<%-- 
    Document   : ScanAttendance
    Created on : May 25, 2025, 10:12:37 AM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String sessionIdStr = request.getParameter("session_id");
    String token = request.getParameter("token");

    if (sessionIdStr == null || token == null) {
        response.getWriter().println("Invalid access. Session ID or token missing.");
        return;
    }

    int sessionId = Integer.parseInt(sessionIdStr);
    String expectedToken = (String) application.getAttribute("qr_token_session_" + sessionId);

    if (expectedToken == null || !expectedToken.equals(token)) {
%>
        <html><body style="text-align:center; padding: 40px; font-family:sans-serif;">
            <h2 style="color:red;">❌ QR has expired or is invalid</h2>
            <p>Please scan a valid QR code from the lecturer's screen.</p>
        </body></html>
<%
        return;
    }
%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Scan Attendance</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .form-container {
            background: #fff;
            padding: 30px 20px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            width: 90%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            color: #00695c;
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            margin-bottom: 6px;
            display: block;
            color: #444;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 10px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 1rem;
            background: #f7f9fa;
            transition: border 0.2s, box-shadow 0.2s;
            box-shadow: 0 1.5px 6px #e0e0e0;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border: 1.5px solid #00695c;
            background: #fff;
            box-shadow: 0 2px 8px #b2dfdb;
        }

        button {
            width: 100%;
            background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 14px;
            font-weight: bold;
            font-size: 1.08rem;
            cursor: pointer;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, transform 0.18s;
            letter-spacing: 1px;
        }

        button:hover {
            background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
            transform: translateY(-1px) scale(1.04);
        }

        @media (min-width: 768px) {
            .form-container {
                padding: 40px;
                max-width: 420px;
            }
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Login to confirm Attendance</h2>
    <form method="post" action="<%= request.getContextPath() %>/SubmitAttendance">
        <input type="hidden" name="session_id" value="<%= sessionIdStr %>" />
        <label for="studentId">ID</label>
        <input type="text" id="studentId" name="matric_number" placeholder="User ID" required>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="password" required>
        <button type="submit">Submit Attendance</button>
    </form>
</div>
</body>
</html>



<%@page import="Model.Lecturer"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Session" %>
<%
    List<Session> sessions = (List<Session>) request.getAttribute("sessions");
    Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
    if (lecturer == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sessions Created</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
        }
        .main-bg {
            min-height: 100vh;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            background: none;
        }
        .sessions-panel {
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            min-width: 340px;
            max-width: 900px;
            width: 100%;
            margin: 2.5em 0;
            padding: 2.5em 2.5em 2em 2.5em;
        }
        .sessions-header {
            display: flex;
            align-items: center;
            gap: 1em;
            margin-bottom: 2em;
        }
        .sessions-header .material-icons {
            font-size: 2.2em;
            color: #00695c;
        }
        .sessions-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            color: #00695c;
            letter-spacing: 1px;
        }
        .session-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
            animation: fadeIn 0.6s ease;
        }
        .session-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fff;
            padding: 20px 28px;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            transition: 0.3s ease;
            border-left: 6px solid #00695c;
            position: relative;
            text-decoration: none;
            color: #0034de;
        }
        .session-card:hover {
            transform: translateY(-2px) scale(1.01);
            box-shadow: 0 8px 30px rgba(0,0,0,0.13);
            border-left: 6px solid #d32f2f;
            background: #f7f9fa;
        }
        .session-info {
            font-size: 1.08rem;
            display: flex;
            gap: 60px;
            flex-wrap: wrap;
        }
        .session-info span {
            font-weight: 500;
            color: #333;
        }
        .no-sessions {
            text-align: center;
            color: #666;
            font-size: 1.1em;
            margin-top: 2em;
        }
        @media (max-width: 900px) {
            .sessions-panel {
                min-width: 0;
                max-width: 98vw;
                width: 98vw;
                padding: 1.5em 0.5em 1em 0.5em;
            }
            .sessions-header {
                padding: 0 0.2em;
            }
            .session-info {
                gap: 18px;
                font-size: 0.98em;
            }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="main-bg">
  <div class="sessions-panel">
    <div class="sessions-header">
      <span class="material-icons">event_note</span>
      <h1>Select a sesion, to make an update</h1>
    </div>
    <div class="session-list">
      <% if (sessions != null && !sessions.isEmpty()) {
          for (Session s : sessions) {
      %>
      <a href="${pageContext.request.contextPath}/UpdateAttendanceListServlet?session_id=<%= s.getSessionId() %>" class="session-card">
        <div class="session-info">
          <span><strong><%= s.getCourseCode() %></strong></span>
          <span>Group: <%= s.getGroupName() %></span>
          <span>Date: <%= s.getDate() %></span>
          <span>Time: <%= s.getStartTime() %></span>
        </div>
      </a>
      <% }} else { %>
      <div class="no-sessions">No sessions found.</div>
      <% } %>
    </div>
  </div>
</div>
</body>
</html>

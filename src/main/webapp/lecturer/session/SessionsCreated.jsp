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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
            display: flex;
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            overflow: hidden;
            min-width: 340px;
            max-width: 1100px;
            width: 100%;
            margin: 2.5em 0;
        }
        .sidebar {
            background: linear-gradient(135deg, #00695c 60%, #d32f2f 100%);
            color: #fff;
            min-width: 220px;
            max-width: 260px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding: 2.5em 1.5em 1.5em 1.5em;
            gap: 2.2em;
        }
        .sidebar .brand-circle {
            width: 60px;
            height: 60px;
            background: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 0.5em;
            box-shadow: 0 2px 8px #d32f2f33;
        }
        .sidebar .brand-circle img {
            width: 38px;
            height: 38px;
        }
        .sidebar .brand-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin: 0;
            letter-spacing: 1px;
        }
        .sidebar .nav {
            display: flex;
            flex-direction: column;
            gap: 1.2em;
            width: 100%;
        }
        .sidebar .nav-link {
            display: flex;
            align-items: center;
            gap: 0.7em;
            color: #fff;
            text-decoration: none;
            font-size: 1.05em;
            font-weight: 500;
            padding: 0.7em 1em;
            border-radius: 8px;
            transition: background 0.18s, color 0.18s;
        }
        .sidebar .nav-link.active, .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.13);
            color: #ffeb3b;
        }
        .sidebar .starred {
            margin-top: 2em;
            font-size: 0.98em;
            color: #ffeb3b;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .sessions-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 2.5em 2.5em 2em 2.5em;
            min-width: 260px;
            max-width: 900px;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
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
        }
        .session-card:hover {
            transform: translateY(-2px) scale(1.01);
            box-shadow: 0 8px 30px rgba(0,0,0,0.13);
            border-left: 6px solid #d32f2f;
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
        .delete-form {
            margin: 0;
        }
        .delete-btn {
            background: none;
            border: none;
            color: #d32f2f;
            font-size: 22px;
            cursor: pointer;
            transition: transform 0.2s ease;
            border-radius: 50%;
            padding: 6px;
        }
        .delete-btn:hover {
            background: #ffeaea;
            transform: scale(1.18);
        }
        .no-sessions {
            text-align: center;
            color: #666;
            font-size: 1.1em;
            margin-top: 2em;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 1100px) {
            .sessions-panel {
                flex-direction: column;
                min-width: 0;
                max-width: 98vw;
                width: 98vw;
            }
            .sidebar {
                flex-direction: row;
                min-width: 0;
                max-width: 100vw;
                width: 100vw;
                padding: 1.2em 0.5em;
                gap: 0.7em;
                justify-content: flex-start;
            }
            .sidebar .brand-circle {
                margin-bottom: 0;
                margin-right: 1em;
            }
            .sessions-content {
                padding: 1.5em 0.5em;
                min-width: 0;
                max-width: 100vw;
                width: 100vw;
            }
        }
        @media (max-width: 700px) {
            .sessions-panel {
                border-radius: 0;
                box-shadow: none;
            }
            .sidebar {
                flex-direction: column;
                align-items: center;
                padding: 1em 0.2em;
                gap: 0.5em;
            }
            .sidebar .brand-title {
                font-size: 1rem;
            }
            .sessions-content {
                padding: 1em 0.2em;
            }
            .session-info {
                gap: 18px;
                font-size: 0.98em;
            }
        }
    </style>
</head>
<body>
<div class="main-bg">
  <div class="sessions-panel">
    <div class="sidebar">
      <div class="brand-circle">
        <img src="https://cdn-icons-png.flaticon.com/512/2991/2991109.png" alt="Attendance Book Icon" />
      </div>
      <div class="brand-title">Attendance System</div>
      <div class="nav">
        <a href="${pageContext.request.contextPath}/lecturer/LecturerDashboard.jsp" class="nav-link"><span class="material-icons">dashboard</span>Dashboard</a>
        <a href="${pageContext.request.contextPath}/lecturer/session/SessionsCreated.jsp" class="nav-link active"><span class="material-icons">event_note</span>Sessions</a>
        <a href="${pageContext.request.contextPath}/GetSubmittedLeaveRequestsServlet" class="nav-link"><span class="material-icons">beach_access</span>Leave Requests</a>
      </div>
      <div class="starred"><span class="material-icons" style="vertical-align:middle; color:#ffeb3b;">star</span> <span style="font-weight:700; letter-spacing:1px; color:#8ebdd6;">AH</span><span style="font-weight:700; letter-spacing:1px; color:#ffeb3b;">$</span><span style="font-weight:700; letter-spacing:1px; color:#93ccea;">MART</span></div>
    </div>
    <div class="sessions-content">
      <div class="sessions-header">
        <span class="material-icons">event_note</span>
        <h1>Sessions You've Created</h1>
      </div>
      <div class="session-list">
        <% if (sessions != null && !sessions.isEmpty()) {
            for (Session s : sessions) {
        %>
        <div class="session-card">
          <a href="${pageContext.request.contextPath}/SessionDetails?session_id=<%= s.getSessionId() %>" style="text-decoration: none; color: inherit;">
            <div class="session-info">
              <span><strong><%= s.getCourseCode() %></strong></span>
              <span>Group: <%= s.getGroupName() %></span>
              <span>Date: <%= s.getDate() %></span>
              <span>Time: <%= s.getStartTime() %></span>
            </div>
          </a>
          <form class="delete-form" method="post" action="${pageContext.request.contextPath}/DeleteSessionServlet">
            <input type="hidden" name="session_id" value="<%= s.getSessionId() %>"/>
            <button type="submit" class="delete-btn" title="Delete session"><i class="material-icons" style="font-size:30px;color:#d32f2f">delete</i></button>
          </form>
        </div>
        <% }} else { %>
        <div class="no-sessions">No sessions found.</div>
        <% } %>
      </div>
    </div>
  </div>
</div>
</body>
</html>


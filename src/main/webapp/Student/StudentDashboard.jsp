<%-- 
    Document   : DashBoard
    Created on : May 13, 2025, 6:21:28 PM
    Author     : PC
--%>

<%@page import="Model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Student student = (Student) session.getAttribute("Student");
    if (student == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Dashboard</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <style>
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
      background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
      color: #333;
      min-height: 100vh;
    }
    .student-header {
      background: linear-gradient(90deg, #93ccea 0%, #00695c 100%);
      color: #fff;
      padding: 2.2em 1.5em 1.5em 1.5em;
      border-radius: 0 0 32px 32px;
      text-align: center;
      box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13);
      position: relative;
    }
    .student-header h1 {
      margin: 0 0 0.3em;
      font-size: 2.1em;
      font-weight: 800;
      letter-spacing: 1px;
    }
    .student-header p {
      margin: 0;
      font-size: 1.1em;
      font-weight: 500;
      color: #ffeb3b;
    }
    .logout-btn {
      position: absolute;
      top: 18px;
      right: 30px;
      background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
      color: #fff;
      padding: 8px 18px;
      font-size: 0.98em;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      box-shadow: 0 2px 6px #d32f2f33;
      font-weight: 600;
      transition: background 0.18s, transform 0.18s;
    }
    .logout-btn:hover {
      background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
      transform: translateY(-1px) scale(1.04);
    }
    .dashboard-container {
      max-width: 1100px;
      margin: 0 auto;
      padding: 2.5em 1em 1em 1em;
      display: flex;
      flex-wrap: wrap;
      gap: 2.2em;
      justify-content: center;
    }
    .dashboard-card {
      background: #fff;
      border-radius: 18px;
      box-shadow: 0 4px 18px rgba(0, 105, 92, 0.09);
      padding: 2.2em 1.5em 1.5em 1.5em;
      min-width: 270px;
      max-width: 340px;
      flex: 1 1 270px;
      display: flex;
      flex-direction: column;
      align-items: center;
      transition: box-shadow 0.18s, transform 0.18s;
      position: relative;
    }
    .dashboard-card:hover {
      box-shadow: 0 8px 32px rgba(0, 105, 92, 0.13);
      transform: translateY(-3px) scale(1.03);
    }
    .dashboard-card .material-icons {
      font-size: 2.5em;
      margin-bottom: 0.7em;
      color: #00695c;
    }
    .dashboard-card h3 {
      margin: 0 0 0.5em 0;
      color: #d32f2f;
      font-size: 1.25em;
      font-weight: 700;
      text-align: center;
    }
    .dashboard-card p {
      color: #555;
      line-height: 1.6;
      text-align: center;
      font-size: 1.05em;
      margin-bottom: 1.2em;
    }
    .dashboard-card .btn-style {
      display: inline-block;
      padding: 0.7em 1.5em;
      background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
      color: #fff;
      border-radius: 8px;
      font-size: 1em;
      text-decoration: none;
      font-weight: 600;
      transition: background 0.18s, transform 0.18s;
      box-shadow: 0 2px 8px #d32f2f33;
    }
    .dashboard-card .btn-style:hover {
      background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
      transform: translateY(-1px) scale(1.04);
    }
    @media (max-width: 900px) {
      .dashboard-container {
        flex-direction: column;
        gap: 1.2em;
        padding: 1.2em 0.2em 0.5em 0.2em;
      }
      .dashboard-card {
        min-width: 0;
        max-width: 98vw;
        width: 98vw;
        margin: 0 auto;
      }
    }
    @media (max-width: 480px) {
      .student-header {
        padding: 1.2em 0.5em 1em 0.5em;
        border-radius: 0 0 18px 18px;
      }
      .student-header h1 {
        font-size: 1.3em;
      }
      .dashboard-card {
        padding: 1.2em 0.5em 1em 0.5em;
      }
      .dashboard-card h3 {
        font-size: 1em;
      }
      .dashboard-card .btn-style {
        font-size: 0.98em;
        padding: 0.6em 1em;
      }
    }
  </style>
</head>
<body>
  <div class="student-header">
    <h1>Student Dashboard</h1>
    <p>Welcome, <%=student.getName()%></p>
    <form action="${pageContext.request.contextPath}/LogoutServlet" method="post" style="position: absolute; top: 18px; right: 30px;">
      <button type="submit" class="logout-btn">Logout</button>
    </form>
  </div>
  <div class="dashboard-container">
    <div class="dashboard-card">
      <span class="material-icons">bar_chart</span>
      <h3>View Attendance History</h3>
      <p>Check your attendance across courses and monitor your attendance trends daily or weekly.</p>
      <a href="${pageContext.request.contextPath}/StudentAttendanceHistoryServlet" class="btn-style">View History</a>
    </div>
    <div class="dashboard-card">
      <span class="material-icons">event_available</span>
      <h3>Submit Leave Request</h3>
      <p>Unable to attend a class? Submit your leave request with reason and dates for approval.</p>
      <a href="${pageContext.request.contextPath}/leaveRequest/leaveRequestLecturers.jsp" class="btn-style">Submit Request</a>
    </div>
    <div class="dashboard-card">
      <span class="material-icons">assignment_turned_in</span>
      <h3>View Leave Request Status</h3>
      <p>Track the approval progress of your submitted leave requests in real time.</p>
      <a href="${pageContext.request.contextPath}/StudentLeaveStatusServlet" class="btn-style">View Status</a>
    </div>
  </div>
</body>
</html>

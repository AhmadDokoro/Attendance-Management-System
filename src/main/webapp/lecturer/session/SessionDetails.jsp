<%-- 
    Document   : SessionDetails
    Created on : May 31, 2025, 12:35:56 PM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Attendance, Model.Session" %>
<%
    Session sess = (Session) request.getAttribute("session");
    List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            position: relative;
        }
        .bg-shape {
            position: absolute;
            top: -80px;
            left: -80px;
            width: 350px;
            height: 350px;
            background: radial-gradient(circle at 60% 40%, #00695c 60%, #d32f2f 100%);
            opacity: 0.13;
            border-radius: 50%;
            z-index: 0;
        }
        .session-details-container {
            position: relative;
            z-index: 1;
            max-width: 900px;
            margin: 60px auto 30px auto;
            padding: 0 1.5em;
        }
        .session-card {
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            padding: 2.5em 2em 2em 2em;
            margin-bottom: 2.5em;
            position: relative;
            overflow: hidden;
        }
        .back-btn {
            position: absolute;
            top: 22px;
            right: 32px;
            background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
            color: #fff;
            border: none;
            padding: 10px 22px;
            font-size: 1em;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, transform 0.18s;
            text-decoration: none;
            z-index: 2;
        }
        .back-btn:hover {
            background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
            transform: translateY(-1px) scale(1.04);
        }
        .session-title {
            font-size: 2.1rem;
            font-weight: 700;
            color: #00695c;
            margin-bottom: 0.3em;
            letter-spacing: 1px;
        }
        .session-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5em;
            margin-bottom: 0.7em;
            font-size: 1.08em;
        }
        .session-meta span {
            color: #d32f2f;
            font-weight: 600;
        }
        .session-meta strong {
            color: #00695c;
        }
        .session-meta .icon {
            vertical-align: middle;
            margin-right: 0.2em;
            color: #ffeb3b;
        }
        .session-meta .icon-green {
            color: #388e3c;
        }
        .session-meta .icon-blue {
            color: #1976d2;
        }
        .session-meta .icon-red {
            color: #d32f2f;
        }
        .session-meta .icon-yellow {
            color: #ffeb3b;
        }
        .session-meta .icon-sky {
            color: #8ebdd6;
        }
        .attendance-table-container {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            padding: 2em 1.2em 1.2em 1.2em;
            margin-bottom: 2em;
            animation: fadeIn 0.7s;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.04);
        }
        th, td {
            padding: 15px 20px;
            text-align: left;
        }
        th {
            background: linear-gradient(90deg, #00695c 0%, #d32f2f 100%);
            color: #fff;
            font-size: 1.08em;
            font-weight: 700;
            border: none;
        }
        tr:nth-child(even) td {
            background-color: #f7f9fa;
        }
        tr:hover td {
            background: #e0f7fa;
            transition: background 0.18s;
        }
        td {
            font-size: 1em;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
        }
        tr:last-child td {
            border-bottom: none;
        }
        @media (max-width: 700px) {
            .session-details-container {
                padding: 0 0.2em;
            }
            .session-card {
                padding: 1.2em 0.5em 1em 0.5em;
            }
            .attendance-table-container {
                padding: 1em 0.2em 0.5em 0.2em;
            }
            th, td {
                padding: 10px 6px;
                font-size: 0.98em;
            }
            .back-btn {
                top: 12px;
                right: 10px;
                padding: 7px 12px;
                font-size: 0.95em;
            }
            .session-title {
                font-size: 1.2rem;
            }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="bg-shape"></div>
<div class="session-details-container">
    <div class="session-card">
        <a class="back-btn" href="<%= request.getContextPath() %>/lecturer/LecturerDashboard.jsp"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">arrow_back</span>Back to dashboard</a>
        <div class="session-title"><%= sess.getCourseCode() %> <span style="font-size:0.7em; color:#93ccea; font-weight:500;">Session</span></div>
        <div class="session-meta">
            <span><span class="material-icons icon icon-blue">groups</span>Group: <strong><%= sess.getGroupName() %></strong></span>
            <span><span class="material-icons icon icon-green">school</span>Program: <strong><%= sess.getProgramType() %></strong></span>
            <span><span class="material-icons icon icon-yellow">place</span>Location: <strong><%= sess.getLocation() %></strong></span>
        </div>
        <div class="session-meta">
            <span><span class="material-icons icon icon-red">schedule</span>Duration: <strong><%= sess.getDuration() %> hr(s)</strong></span>
            <span><span class="material-icons icon icon-sky">access_time</span>Time: <strong><%= sess.getStartTime() %> - <%= sess.getEndTime() %></strong></span>
            <span><span class="material-icons icon icon-blue">event</span>Date: <strong><%= sess.getDate() %></strong></span>
        </div>
    </div>
    <div class="attendance-table-container">
        <table>
            <tr>
                <th>Matric Number</th>
                <th>Student Name</th>
                <th>Scan Time</th>
                <th>IP Address</th>
            </tr>
            <% for (Attendance a : attendanceList) { %>
            <tr>
                <td><%= a.getMatric() %></td>
                <td><%= a.getStudentName() %></td>
                <td><%= a.getScanTime() %></td>
                <td><%= a.getIpAddress() %></td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>


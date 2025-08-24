<%-- 
    Document   : ViewAttendanceHistory
    Created on : Jun 3, 2025, 5:30:23 PM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.StudentHistory" %>

<%
    List<StudentHistory> historyList = (List<StudentHistory>) request.getAttribute("historyList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance History</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
        }
        .container {
            max-width: 1100px;
            margin: 50px auto;
            background: #fff;
            padding: 38px 18px 28px 18px;
            border-radius: 22px;
            box-shadow: 0 10px 30px rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
        }
        h1 {
            text-align: center;
            color: #00695c;
            margin-bottom: 30px;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .history-table-container {
            overflow-x: auto;
            margin-bottom: 2em;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.04);
            animation: slideUp 0.5s ease;
        }
        th, td {
            text-align: left;
            padding: 18px 20px;
        }
        th {
            background: linear-gradient(90deg, #00695c 0%, #d32f2f 100%);
            color: #fff;
            font-weight: bold;
            font-size: 1.08em;
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
        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 14px 38px;
            background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 1.08em;
            text-decoration: none;
            font-weight: bold;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, transform 0.18s;
        }
        .back-btn:hover {
            background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
            transform: translateY(-1px) scale(1.04);
        }
        @media (max-width: 900px) {
            .container {
                padding: 18px 2px 10px 2px;
            }
            th, td {
                padding: 10px 6px;
                font-size: 0.98em;
            }
            h1 {
                font-size: 1.2rem;
            }
        }
        @media (max-width: 700px) {
            .container {
                padding: 8px 0.5vw 4px 0.5vw;
            }
            .history-table-container {
                margin-bottom: 1em;
            }
            table, thead, tbody, th, td, tr {
                display: block;
                width: 100%;
                min-width: 0;
                box-sizing: border-box;
            }
            thead {
                display: none;
            }
            tr {
                margin-bottom: 1.2em;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.04);
                padding: 1em 0.5em;
                max-width: 370px;
                margin-left: auto;
                margin-right: auto;
            }
            td {
                padding: 10px 8px;
                font-size: 1em;
                border: none;
                position: relative;
                text-align: left;
                max-width: 340px;
                word-break: break-word;
            }
            td:before {
                content: attr(data-label);
                font-weight: bold;
                color: #00695c;
                display: block;
                margin-bottom: 4px;
                font-size: 0.98em;
            }
        }
        @keyframes slideUp {
            from {
                transform: translateY(40px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Attendance History</h1>
    <div class="history-table-container">
    <table>
        <thead>
            <tr>
                <th>Course Code</th>
                <th>Program Type</th>
                <th>Location</th>
                <th>Date</th>
                <th>Duration (hrs)</th>
                <th>Start Time</th>
                <th>End Time</th>
            </tr>
        </thead>
        <tbody>
        <% if (historyList != null && !historyList.isEmpty()) { for (StudentHistory h : historyList) { %>
            <tr>
                <td data-label="Course Code"><%= h.getCourseCode() %></td>
                <td data-label="Program Type"><%= h.getProgramType() %></td>
                <td data-label="Location"><%= h.getLocation() %></td>
                <td data-label="Date"><%= h.getDate() %></td>
                <td data-label="Duration (hrs)"><%= h.getDuration() %></td>
                <td data-label="Start Time"><%= h.getStartTime() %></td>
                <td data-label="End Time"><%= h.getEndTime() %></td>
            </tr>
        <% }} else { %>
            <tr><td colspan="7" style="text-align:center; color:#888;">No attendance history found.</td></tr>
        <% } %>
        </tbody>
    </table>
    </div>
    <div style="text-align: center;">
        <a class="back-btn" href="${pageContext.request.contextPath}/Student/StudentDashboard.jsp">← Back to Dashboard</a>
    </div>
</div>

</body>
</html>

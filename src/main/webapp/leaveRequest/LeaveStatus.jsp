<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.LeaveRequest, Model.Student" %>
<%
    Student student = (Student) session.getAttribute("Student");
    if (student == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    List<LeaveRequest> leaveRequests = (List<LeaveRequest>) request.getAttribute("leaveRequests");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Leave Request Status</title>
    <style>
        :root {
            --main-blue: #4f8cff;
            --main-pink: #ff5a8a;
            --main-green: #2ecc71;
            --main-yellow: #ffe066;
            --main-bg: #f7faff;
            --main-white: #fff;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background: var(--main-bg);
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            background: var(--main-white);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 12px 24px rgba(0,0,0,0.08);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2.2rem;
            color: var(--main-blue);
            margin-bottom: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.04);
            background: var(--main-white);
        }

        th, td {
            padding: 16px 20px;
            text-align: left;
        }

        th {
            background-color: var(--main-blue);
            color: #fff;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .status-pending {
            color: #d68e00;
            font-weight: bold;
        }

        .status-approved {
            color: var(--main-green);
            font-weight: bold;
        }

        .status-rejected {
            color: #ff5a5a;
            font-weight: bold;
        }

        .back-button {
            display: inline-block;
            margin-top: 30px;
            background: linear-gradient(90deg, var(--main-blue), var(--main-pink));
            color: var(--main-white);
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s;
        }

        .back-button:hover {
            background: linear-gradient(90deg, var(--main-pink), var(--main-blue));
        }

        @media (max-width: 700px) {
            .container {
                padding: 10px;
            }

            th, td {
                padding: 10px 8px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Your Leave Requests</h1>
    </div>

    <table>
        <tr>
            <th>Title</th>
            <th>Course</th>
            <th>Status</th>
        </tr>
        <%
            if (leaveRequests != null && !leaveRequests.isEmpty()) {
                for (LeaveRequest requestItem : leaveRequests) {
        %>
        <tr>
            <td><%= requestItem.getTitle() %></td>
            <td><%= requestItem.getCourseCode() %></td>
            <td class="status-<%= requestItem.getStatus().toLowerCase() %>">
                <%= requestItem.getStatus() %>
            </td>
        </tr>
        <%  } 
           } else { %>
        <tr>
            <td colspan="3" style="text-align: center; color: #777;">No leave requests submitted yet.</td>
        </tr>
        <% } %>
    </table>

    <div style="text-align: center;">
        <a href="${pageContext.request.contextPath}/Student/StudentDashboard.jsp" class="back-button">← Back to Dashboard</a>
    </div>
</div>

</body>
</html>


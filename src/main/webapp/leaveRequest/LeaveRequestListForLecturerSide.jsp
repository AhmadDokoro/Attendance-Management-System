<%-- 
    Document   : LeaveRequestListForLecturerSide
    Created on : Jun 21, 2025, 9:06:11?PM
    Author     : PC
--%>
<%@ page import="java.util.List" %>
<%@ page import="Model.LeaveRequest" %>
<%
    List<LeaveRequest> leaveRequests = (List<LeaveRequest>) request.getAttribute("leaveRequests");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Leave Requests</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .main-container {
            max-width: 1100px;
            margin: 60px auto 30px auto;
            padding: 0 1.5em;
        }
        .header {
            text-align: center;
            margin-bottom: 2.5em;
        }
        .header h2 {
            color: #00695c;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin: 0;
        }
        .leave-table-container {
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            padding: 2.5em 2em 2em 2em;
            margin-bottom: 2.5em;
            animation: fadeIn 0.7s;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.04);
        }
        th, td {
            padding: 18px 24px;
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
        .view-link {
            background: linear-gradient(90deg, #ffeb3b 0%, #93ccea 100%);
            color: #00695c;
            border: none;
            border-radius: 8px;
            padding: 10px 22px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, color 0.18s, transform 0.18s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5em;
        }
        .view-link:hover {
            background: linear-gradient(90deg, #ffe066 0%, #8ebdd6 100%);
            color: #d32f2f;
            transform: translateY(-1px) scale(1.04);
        }
        .no-requests {
            text-align: center;
            color: #666;
            font-size: 1.1em;
            margin-top: 2em;
        }
        .back-btn {
            margin: 30px auto 0 auto;
            display: block;
            background: linear-gradient(90deg, #00695c 0%, #d32f2f 100%);
            color: #fff;
            padding: 14px 38px;
            border-radius: 10px;
            text-align: center;
            width: fit-content;
            text-decoration: none;
            font-size: 1.08em;
            font-weight: bold;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, transform 0.18s;
        }
        .back-btn:hover {
            background: linear-gradient(90deg, #004d40 0%, #c62828 100%);
            transform: translateY(-1px) scale(1.04);
        }
        @media (max-width: 900px) {
            .main-container {
                padding: 0 0.2em;
            }
            .leave-table-container {
                padding: 1.2em 0.2em 1em 0.2em;
            }
            table {
                font-size: 0.98em;
                min-width: 600px;
            }
            th, td {
                padding: 8px 4px;
                font-size: 0.98em;
            }
            .header h2 {
                font-size: 1.2rem;
            }
        }
        @media (max-width: 700px) {
            .leave-table-container {
                padding: 0.5em 0.05em 0.5em 0.05em;
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
            .view-link, .back-btn {
                font-size: 0.98em;
                padding: 10px 12px;
            }
        }
        @media (max-width: 600px) {
            .main-container {
                padding: 0 0.05em;
            }
            .leave-table-container {
                padding: 0.5em 0.05em 0.5em 0.05em;
            }
            table {
                min-width: 350px;
            }
            th, td {
                padding: 5px 2px;
                font-size: 0.93em;
            }
            .back-btn, .view-link {
                font-size: 0.93em;
                padding: 8px 10px;
            }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="header">
        <h2><span class="material-icons" style="vertical-align:middle; font-size:1.2em; margin-right:0.3em; color:#ffeb3b;">beach_access</span>Pending Leave Requests</h2>
    </div>
    <div class="leave-table-container">
        <table>
            <tr>
                <th>Student Name</th>
                <th>Title</th>
                <th>Action</th>
            </tr>
            <% if (leaveRequests != null && !leaveRequests.isEmpty()) { for (LeaveRequest req : leaveRequests) { %>
            <tr>
                <td data-label="Student Name"><%= req.getStudentName() %></td>
                <td data-label="Title"><%= req.getTitle() %></td>
                <td data-label="Action">
                    <form action="${pageContext.request.contextPath}/leaveRequest/ViewLeaveDetails.jsp" method="post" style="margin:0;">
                        <input type="hidden" name="description" value="<%= req.getDescription() %>">
                        <input type="hidden" name="proofPath" value="<%= req.getProofFilePath() %>">
                        <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                        <button type="submit" class="view-link"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; color:#00695c;">visibility</span>View Details</button>
                    </form>
                </td>
            </tr>
            <% }} else { %>
            <tr><td colspan="3" class="no-requests">No pending leave requests.</td></tr>
            <% } %>
        </table>
    </div>
    <a href="${pageContext.request.contextPath}/lecturer/LecturerDashboard.jsp" class="back-btn"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">arrow_back</span>Back to Dashboard</a>
</div>
</body>
</html>


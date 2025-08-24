<%-- 
    Document   : AttendanceSaved
    Created on : Jun 3, 2025, 4:03:40 PM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Attendance Saved</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .success-box {
            text-align: center;
            background: #fff;
            padding: 56px 44px 48px 44px;
            border-radius: 28px;
            box-shadow: 0 12px 40px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            animation: fadeIn 0.7s ease;
            position: relative;
            max-width: 420px;
        }
        .success-icon {
            background: linear-gradient(135deg, #00695c 60%, #d32f2f 100%);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px auto;
            box-shadow: 0 4px 18px #d32f2f33;
        }
        .success-icon .material-icons {
            color: #ffeb3b;
            font-size: 3.2rem;
        }
        .success-box h1 {
            color: #00695c;
            font-size: 2.3rem;
            margin-bottom: 10px;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .success-box p {
            color: #333;
            font-size: 1.18rem;
            margin-bottom: 32px;
            font-weight: 500;
        }
        .buttons {
            display: flex;
            justify-content: center;
            gap: 18px;
        }
        .btn {
            padding: 13px 28px;
            font-size: 1.08rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.18s;
            font-weight: bold;
            text-decoration: none;
            box-shadow: 0 2px 8px #d32f2f33;
        }
        .btn.dashboard {
            background: linear-gradient(90deg, #00695c 0%, #d32f2f 100%);
            color: #fff;
        }
        .btn.dashboard:hover {
            background: linear-gradient(90deg, #004d40 0%, #c62828 100%);
            transform: translateY(-1px) scale(1.04);
        }
        .btn.sessions {
            background: linear-gradient(90deg, #ffeb3b 0%, #93ccea 100%);
            color: #00695c;
        }
        .btn.sessions:hover {
            background: linear-gradient(90deg, #ffe066 0%, #8ebdd6 100%);
            color: #d32f2f;
            transform: translateY(-1px) scale(1.04);
        }
        @media (max-width: 600px) {
            .success-box {
                padding: 28px 6px 24px 6px;
                max-width: 98vw;
            }
            .success-box h1 {
                font-size: 1.3rem;
            }
            .success-box p {
                font-size: 1em;
            }
            .btn {
                padding: 10px 10px;
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
<div class="success-box">
    <div class="success-icon">
        <span class="material-icons">verified</span>
    </div>
    <h1>Attendance Successfully Saved!</h1>
    <p>All selected students have been marked present.<br>Thank you for keeping your records up to date.</p>
    <div class="buttons">
        <a href="${pageContext.request.contextPath}/lecturer/LecturerDashboard.jsp" class="btn dashboard"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">dashboard</span>Dashboard</a>
        <a href="${pageContext.request.contextPath}/getSessionsForUpdateServlet" class="btn sessions"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">event_note</span>Sessions</a>
    </div>
</div>
</body>
</html>


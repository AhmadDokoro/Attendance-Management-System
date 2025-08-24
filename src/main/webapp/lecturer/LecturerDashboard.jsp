<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Lecturer" %>
<%
    Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
    Integer pendingLeaveCount = (Integer) session.getAttribute("pendingLeaveCount");
    if (lecturer == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lecturer Dashboard</title>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
            min-height: 100vh;
        }
        .top-nav {
            width: 100%;
            padding: 22px 60px;
            background: #00695c;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.18);
            border-bottom-left-radius: 18px;
            border-bottom-right-radius: 18px;
            backdrop-filter: blur(6px);
        }
        .top-nav h2 {
            margin: 0;
            font-weight: 700;
            letter-spacing: 1px;
            font-size: 2rem;
        }
        .profile-box {
            display: flex;
            align-items: center;
            gap: 18px;
            background: rgba(255, 255, 255, 0.10);
            padding: 8px 18px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,105,92,0.04);
        }
        .profile-box img {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            border: 2px solid #fff;
            box-shadow: 0 2px 8px rgba(0,105,92,0.08);
        }
        .logout-btn {
            padding: 8px 20px;
            background: #d32f2f;
            color: #fff;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s, color 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(0,105,92,0.08);
        }
        .logout-btn:hover {
            background: #c62828;
            color: #ffeb3b;
            box-shadow: 0 4px 16px rgba(0,105,92,0.18);
        }
        .container {
            max-width: 1200px;
            margin: 48px auto 0 auto;
            padding: 0 24px;
        }
        /* Modern Section Layout */
        .dashboard-layout {
            display: flex;
            gap: 32px;
            margin-bottom: 36px;
        }
        .sidebar {
            flex: 0 0 250px;
            background: #004d40;
            color: #fff;
            padding: 24px;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(0, 77, 64, 0.10);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            margin-bottom: 16px;
            border: 3px solid #fff;
            box-shadow: 0 2px 8px rgba(0,105,92,0.08);
        }
        .lecturer-name {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #ffeb3b;
        }
        .sidebar-nav {
            width: 100%;
            margin-top: 18px;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 18px;
            margin: 8px 0;
            border-radius: 12px;
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            font-size: 1.08rem;
            transition: background 0.2s, color 0.2s, box-shadow 0.2s;
            position: relative;
        }
        .sidebar-link .nav-icon {
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .sidebar-link:hover, .sidebar-link.active {
            background: linear-gradient(90deg, #00796b 0%, #d32f2f 100%);
            color: #ffeb3b;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
        }
        .sidebar-link .notification {
            background: #d32f2f;
            color: #fff;
            font-size: 0.85rem;
            padding: 3px 10px;
            border-radius: 50px;
            font-weight: 700;
            margin-left: auto;
        }
        .sidebar-divider {
            width: 80%;
            height: 1.5px;
            background: linear-gradient(90deg, #00796b 0%, #d32f2f 100%);
            margin: 18px 0 10px 0;
            border: none;
            border-radius: 1px;
        }
        .main-content {
            flex: 1;
            background: #fff;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 4px 24px rgba(0, 77, 64, 0.10);
        }
        .main-content h1 {
            font-size: 1.8rem;
            margin-bottom: 24px;
            color: #004d40;
        }
        .actions {
            display: flex;
            gap: 18px;
            margin-bottom: 24px;
        }
        .action-btn {
            flex: 1;
            padding: 16px;
            background: #00796b;
            color: #fff;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.2s, transform 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .action-btn:hover {
            background: #004d40;
            transform: translateY(-2px);
        }
        .create-session {
            display: inline-block;
            background: linear-gradient(90deg, #d32f2f 0%, #c62828 100%);
            color: #fff;
            padding: 16px 34px;
            font-size: 1.08rem;
            font-weight: 700;
            text-decoration: none;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(211, 47, 47, 0.18);
            transition: all 0.22s cubic-bezier(.4,2,.6,1);
            margin-bottom: 32px;
            letter-spacing: 0.5px;
        }
        .create-session:hover {
            transform: scale(1.045);
            background: linear-gradient(90deg, #c62828 0%, #d32f2f 100%);
            color: #fff;
            box-shadow: 0 10px 32px rgba(211, 47, 47, 0.22);
        }
        .report-btn {
            background: #f5f5f5;
            color: #004d40;
            padding: 14px 28px;
            font-size: 1.08rem;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            margin-top: 32px;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0,105,92,0.04);
            transition: background 0.18s, color 0.18s, box-shadow 0.18s;
        }
        .report-btn:hover {
            background: #e0e0e0;
            color: #00796b;
            box-shadow: 0 6px 18px rgba(0,77,64,0.10);
        }
        footer {
            text-align: center;
            margin-top: 60px;
            padding-bottom: 24px;
            color: #004d40;
            font-size: 1rem;
            letter-spacing: 0.2px;
        }
        @media (max-width: 900px) {
            .dashboard-layout {
                flex-direction: column;
                gap: 18px;
            }
        }
        @media (max-width: 700px) {
            .top-nav {
                flex-direction: column;
                padding: 18px 10px;
                border-radius: 0 0 18px 18px;
            }
            .container {
                padding: 0 6px;
            }
        }
    </style>
</head>
<body>
    <!-- TOP NAV -->
    <div class="top-nav">
        <h2>Attendance Dashboard</h2>
        <div class="profile-box">
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135768.png" alt="Profile" />
            <span><%= lecturer.getName() %></span>
            <form action="${pageContext.request.contextPath}/LogoutServlet" method="post">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>
    <div class="container">
        <div class="dashboard-layout">
            <!-- SIDEBAR -->
            <aside class="sidebar">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135768.png" class="avatar" alt="Lecturer Avatar" />
                <div class="lecturer-name"><%= lecturer.getName() %></div>
                <nav class="sidebar-nav">
                    <a href="${pageContext.request.contextPath}/getSessions" class="sidebar-link">
                        <span class="nav-icon">📋</span> Manage Attendance
                    </a>
                    <a href="${pageContext.request.contextPath}/GetSubmittedLeaveRequestsServlet" class="sidebar-link">
                        <span class="nav-icon">📝</span> Leave Requests
                        <% if (pendingLeaveCount != null && pendingLeaveCount > 0) { %>
                        <span class="notification"><%= pendingLeaveCount %></span>
                        <% } %>
                    </a>
                    <a href="${pageContext.request.contextPath}/getSessionsForUpdateServlet" class="sidebar-link">
                        <span class="nav-icon">🛠️</span> Update Attendance
                    </a>
                    <hr class="sidebar-divider" />
                    <a href="#" class="sidebar-link">
                        <span class="nav-icon">⭐</span> Analytics
                    </a>
                </nav>
            </aside>
            <!-- MAIN CONTENT -->
            <main class="main-content">
                <h1>Welcome to your dashboard!</h1>
                <p style="font-size:1.08rem;color:#00796b;margin-bottom:28px;max-width:600px;">
                    Manage attendance, review leave requests, and update sessions—all in one place.
                </p>
                <div class="actions">
                    <button class="action-btn" onclick="location.href='${pageContext.request.contextPath}/getSessions'">
                        📋 Manage Attendance
                    </button>
                    <button class="action-btn" onclick="location.href='${pageContext.request.contextPath}/GetSubmittedLeaveRequestsServlet'">
                        📝 Leave Requests
                        <% if (pendingLeaveCount != null && pendingLeaveCount > 0) { %>
                        <span class="notification"><%= pendingLeaveCount %></span>
                        <% } %>
                    </button>
                    <button class="action-btn" onclick="location.href='${pageContext.request.contextPath}/getSessionsForUpdateServlet'">
                        🛠️ Update Attendance
                    </button>
                </div>
                <button class="create-session" onclick="location.href='../create-session'">
                    + Create New Session
                </button>
                <button class="report-btn" onclick="location.href='AttendanceReport.jsp'">
                    📊 Generate Attendance Report
                </button>
                <footer>
                    &copy; 2025 UMT | Attendance Management System
                </footer>
            </main>
        </div>
    </div>
    </body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="Model.Student" %>
<%@ page import="DAO.LoginDao" %>
<%
    Student student = (Student) session.getAttribute("Student");
    if (student == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    List<Map<String, String>> lecturerCourses = new ArrayList<>();

    try (Connection conn = LoginDao.getConnection()) {
        String sql = "SELECT DISTINCT l.lecturer_id, l.name AS lecturer_name, c.course_code, g.group_name, g.group_id FROM lecturer l JOIN coursegroup cg ON cg.lecturer_id = l.lecturer_id "
        + "JOIN grouptable g ON g.group_id = cg.group_id "
        + "JOIN course c ON c.course_code = g.course_code "
        + "JOIN studentgroup sg ON sg.group_id = g.group_id "
        + "JOIN student s ON s.student_id = sg.student_id "
        + "WHERE s.student_id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, student.getId());
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> row = new HashMap<>();
            row.put("lecturerId", rs.getString("lecturer_id"));
            row.put("lecturerName", rs.getString("lecturer_name"));
            row.put("courseCode", rs.getString("course_code"));
            row.put("groupName", rs.getString("group_name"));
            row.put("groupId", rs.getString("group_id"));
            lecturerCourses.add(row);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Lecturer</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(120deg, #f1f8e9 0%, #e0f7fa 100%);
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
        }
        .lecturer-select-header {
            text-align: center;
            margin: 0 auto 2.5em auto;
            padding: 2.2em 1.5em 1.5em 1.5em;
            background: linear-gradient(90deg, #ffeb3b 0%, #93ccea 100%);
            color: #00695c;
            border-radius: 0 0 32px 32px;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13);
        }
        .lecturer-select-header h2 {
            margin: 0;
            font-size: 2.1em;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .lecturer-select-header p {
            margin: 0.5em 0 0 0;
            font-size: 1.1em;
            font-weight: 500;
            color: #d32f2f;
        }
        .lecturer-list-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2.5em 1em 1em 1em;
            display: flex;
            flex-wrap: wrap;
            gap: 2em;
            justify-content: center;
        }
        .lecturer-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 18px rgba(0, 105, 92, 0.09);
            padding: 2em 1.5em 1.5em 1.5em;
            min-width: 240px;
            max-width: 320px;
            flex: 1 1 240px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            transition: box-shadow 0.18s, transform 0.18s;
            position: relative;
            text-decoration: none;
            color: #333;
            border-left: 7px solid #93ccea;
        }
        .lecturer-card:hover {
            box-shadow: 0 8px 32px rgba(0, 105, 92, 0.13);
            transform: translateY(-3px) scale(1.03);
            border-left: 7px solid #d32f2f;
            background: #f7fafd;
        }
        .lecturer-card .lecturer-name {
            color: #00695c;
            font-size: 1.18em;
            font-weight: 700;
            margin-bottom: 0.3em;
        }
        .lecturer-card .lecturer-meta {
            color: #d32f2f;
            font-size: 1.05em;
            margin-bottom: 0.2em;
        }
        .lecturer-card .lecturer-meta span {
            color: #00695c;
            font-weight: 600;
        }
        @media (max-width: 900px) {
            .lecturer-list-container {
                flex-direction: column;
                gap: 1.2em;
                padding: 1.2em 0.2em 0.5em 0.2em;
            }
            .lecturer-card {
                min-width: 0;
                max-width: 98vw;
                width: 98vw;
                margin: 0 auto;
            }
        }
        @media (max-width: 480px) {
            .lecturer-select-header {
                padding: 1.2em 0.5em 1em 0.5em;
                border-radius: 0 0 18px 18px;
            }
            .lecturer-select-header h2 {
                font-size: 1.3em;
            }
            .lecturer-card {
                padding: 1.2em 0.5em 1em 0.5em;
            }
            .lecturer-card .lecturer-name {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
<div class="lecturer-select-header">
    <h2>Select Lecturer & Course</h2>
    <p>Choose the lecturer and course you want to submit a leave request for.</p>
</div>
<div class="lecturer-list-container">
    <% for (Map<String, String> item : lecturerCourses) { %>
        <a class="lecturer-card" href="leaveRequestForm.jsp?lecturer_id=<%= item.get("lecturerId") %>&course_code=<%= item.get("courseCode") %>&group_id=<%= item.get("groupId") %>">
            <div class="lecturer-name"><%= item.get("lecturerName") %></div>
            <div class="lecturer-meta">Course: <span><%= item.get("courseCode") %></span></div>
            <div class="lecturer-meta">Group: <span><%= item.get("groupName") %></span></div>
        </a>
    <% } %>
</div>

</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="Model.Student" %>
<%
    Student student = (Student) session.getAttribute("Student");
    if (student == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }
    String lecturerId = request.getParameter("lecturer_id");
    String courseCode = request.getParameter("course_code");
    String groupId = request.getParameter("group_id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Leave Request</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
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
            margin: 0;
            padding: 0;
            background: var(--main-bg);
            font-family: 'Segoe UI', sans-serif;
        }
        .form-container {
            max-width: 600px;
            margin: 60px auto;
            padding: 30px 40px;
            background: var(--main-white);
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
        }
        h2 {
            text-align: center;
            color: var(--main-blue);
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: var(--main-green);
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid var(--main-blue);
            margin-top: 5px;
            font-size: 1rem;
            background: var(--main-bg);
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .file-upload-row {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-top: 10px;
        }
        input[type="file"] {
            flex: 1;
            padding: 8px 0;
            border-radius: 8px;
            border: 1px solid var(--main-yellow);
            background: #fffbe6;
            color: var(--main-blue);
        }
        .upload-btn {
            background: linear-gradient(90deg, var(--main-pink), var(--main-blue));
            color: var(--main-white);
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .upload-btn:hover {
            background: linear-gradient(90deg, var(--main-blue), var(--main-pink));
        }
        button[type="submit"] {
            margin-top: 25px;
            background: linear-gradient(90deg, var(--main-blue), var(--main-pink));
            color: var(--main-white);
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
        }
        button[type="submit"]:hover {
            background: linear-gradient(90deg, var(--main-pink), var(--main-blue));
        }
    </style>
</head>
<body>
    <div style="width:100vw; min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center;">
        <div class="leave-header">
            <span class="icon" aria-hidden="true">📝</span>
            <h2 style="margin:0; font-family:'Montserrat',Arial,sans-serif; font-size:2rem; letter-spacing:0.5px;">Submit Leave Request</h2>
        </div>
        <div class="form-card">
            <form action="${pageContext.request.contextPath}/SubmitLeaveRequestServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="student_id" value="<%= student.getId() %>" />
                <input type="hidden" name="lecturer_id" value="<%= lecturerId %>" />
                <input type="hidden" name="course_code" value="<%= courseCode %>" />
                <input type="hidden" name="group_id" value="<%= groupId %>" />

                <label for="title">Title</label>
                <input type="text" id="title" name="title" required>

                <label for="description">Description</label>
                <textarea id="description" name="description" required></textarea>

                <label for="proof">Upload Proof (Image)</label>
                <div class="file-upload-row">
                    <input type="file" id="proof" name="proof" accept="image/*" required>
                    <button type="button" class="upload-btn" onclick="document.getElementById('proof').click();">Choose File</button>
                </div>

                <button type="submit">Submit Request</button>
            </form>
        </div>
    </div>
</body>
</html>


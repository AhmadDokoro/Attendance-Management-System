<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>

<%
    Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
    if (lecturer == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    List<Group> courseGroups = (List<Group>) request.getAttribute("courseGroups"); // set from servlet
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Session</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #00695c;
            --primary-dark: #004d40;
            --accent: #0034de;
            --accent-light: #006eff;
            --background: #f5f7fa;
            --form-bg: #fff;
            --input-bg: #f1f8e9;
            --border: #e0e0e0;
            --shadow: 0 10px 30px rgba(0, 105, 92, 0.10), 0 1.5px 8px #0034de1a;
        }
        html, body {
            height: 100%;
        }
        body {
            font-family: 'Inter', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: var(--background);
            padding: 0;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .form-container {
            background: var(--form-bg);
            max-width: 480px;
            width: 100%;
            margin: 40px auto;
            padding: 38px 32px 32px 32px;
            border-radius: 18px;
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        h2 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 28px;
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            color: var(--primary-dark);
            letter-spacing: 0.1px;
        }
        select, input[type="text"] {
            width: 100%;
            padding: 13px 12px;
            margin-bottom: 18px;
            border-radius: 9px;
            border: 1px solid var(--border);
            font-size: 1rem;
            background: var(--input-bg);
            transition: border 0.2s;
        }
        select:focus, input[type="text"]:focus {
            border: 1.5px solid var(--primary);
            outline: none;
        }
        .submit-btn {
            background: linear-gradient(135deg, var(--primary-dark), var(--accent-light));
            color: #fff;
            padding: 15px 0;
            border: none;
            border-radius: 10px;
            width: 100%;
            font-size: 1.13rem;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.3s, box-shadow 0.2s;
            box-shadow: 0 2px 8px #0034de1a;
            margin-top: 10px;
        }
        .submit-btn:hover {
            background: linear-gradient(135deg, #002bb5, #0055dd);
            box-shadow: 0 4px 16px #0034de22;
        }
        @media (max-width: 600px) {
            .form-container {
                padding: 18px 2vw 16px 2vw;
                max-width: 99vw;
            }
            h2 {
                font-size: 1.13rem;
            }
            select, input[type="text"] {
                font-size: 0.98rem;
            }
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Create a New Class Session</h2>
    <form method="post" action="${pageContext.request.contextPath}/SaveSession">
        <!-- Combined Course + Group Dropdown -->
        <label for="group_id">Select Course & Group</label>
        <select id="group_id" name="group_id" required>
            <option disabled selected>-- Select Course & Group --</option>
            <% if (courseGroups != null) {
                for (Group g : courseGroups) { %>
                    <option value="<%= g.getGroupId() %>,<%= g.getCourseCode() %>">
                        <%= g.getCourseCode() %> - <%= g.getCourseName() %> (Group <%= g.getGroupName() %>)
                    </option>
            <%  }} %>
        </select>
        <!-- Location -->
        <label for="location">Class Location</label>
        <input type="text" id="location" name="location" placeholder="Class location" required />
        <!-- Program Type -->
        <label for="program_type">Program Type</label>
        <select id="program_type" name="program_type" required>
            <option disabled selected>-- Select Type --</option>
            <option value="Class">Class</option>
            <option value="Lab">Lab</option>
            <option value="Field Study">Field Study</option>
        </select>
        <!-- Duration -->
        <label for="duration">Duration (Hours)</label>
        <select id="duration" name="duration" required>
            <option disabled selected>-- Select Duration --</option>
            <% for (int i = 1; i <= 5; i++) { %>
                <option value="<%= i %>"><%= i %> Hour<%= (i > 1) ? "s" : "" %></option>
            <% } %>
        </select>
        <button type="submit" class="submit-btn">Create</button>
    </form>
</div>

</body>
</html>

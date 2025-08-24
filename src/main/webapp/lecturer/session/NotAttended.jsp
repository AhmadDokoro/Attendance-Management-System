<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Student" %>
<%
    List<Student> students = (List<Student>) request.getAttribute("students");
    int sessionId = (Integer) request.getAttribute("sessionId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mark Manual Attendance</title>
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
        .header {
            background: linear-gradient(90deg, #00695c 0%, #d32f2f 100%);
            color: #fff;
            padding: 2.5em 2em 2em 2em;
            border-radius: 0 0 22px 22px;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            text-align: center;
            margin-bottom: 0;
        }
        .header h1 {
            margin: 0;
            font-size: 2.2rem;
            letter-spacing: 1px;
            font-weight: 700;
        }
        .table-container {
            width: 100vw;
            margin: 0;
            padding: 0 0 2em 0;
            background: none;
        }
        table {
            width: 100vw;
            min-width: 900px;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 0 0 22px 22px;
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
        .checkbox-cell {
            text-align: center;
        }
        .submit-btn {
            display: block;
            margin: 30px auto 0 auto;
            padding: 16px 48px;
            font-size: 1.15rem;
            font-weight: bold;
            background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, transform 0.18s;
            letter-spacing: 1px;
        }
        .submit-btn:hover {
            background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
            transform: translateY(-1px) scale(1.04);
        }
        @media (max-width: 900px) {
            .header {
                padding: 1.2em 0.5em 1em 0.5em;
            }
            .table-container {
                padding: 0 0 1em 0;
            }
            table {
                min-width: 600px;
            }
            th, td {
                padding: 10px 6px;
                font-size: 0.98em;
            }
            .submit-btn {
                padding: 10px 18px;
                font-size: 1em;
            }
            .header h1 {
                font-size: 1.2rem;
            }
        }
        @media (max-width: 600px) {
            table {
                min-width: 400px;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <h1><span class="material-icons" style="vertical-align:middle; font-size:1.2em; margin-right:0.3em; color:#ffeb3b;">person_off</span>Mark Manual Attendance</h1>
</div>
<form method="post" action="${pageContext.request.contextPath}/SaveManualAttendanceServlet">
    <input type="hidden" name="session_id" value="<%= sessionId %>"/>
    <div class="table-container">
        <table>
            <tr>
                <th>Matric Number</th>
                <th>Student Name</th>
                <th class="checkbox-cell">Present?</th>
            </tr>
            <% for (Student s : students) { %>
            <tr>
                <td><%= s.getMatric() %></td>
                <td><%= s.getName() %></td>
                <td class="checkbox-cell">
                    <input type="checkbox" name="presentStudentIds" value="<%= s.getId() %>"/>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <button type="submit" class="submit-btn"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">check_circle</span>Mark Selected Students</button>
</form>
</body>
</html>


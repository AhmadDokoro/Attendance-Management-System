<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String description = request.getParameter("description");
    String proofPath = request.getParameter("proofPath");
    String requestId = request.getParameter("requestId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Leave Request Details</title>
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
        .details-card {
            background: #fff;
            border-radius: 28px;
            box-shadow: 0 12px 40px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            padding: 3.5em 2.5em 2.5em 2.5em;
            margin-bottom: 2.5em;
            animation: fadeIn 0.7s;
            position: relative;
        }
        .details-header {
            text-align: center;
            margin-bottom: 2.5em;
        }
        .details-header h2 {
            color: #00695c;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin: 0;
        }
        .section {
            margin-bottom: 35px;
        }
        .section h4 {
            color: #d32f2f;
            margin-bottom: 15px;
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .section p {
            font-size: 1.18rem;
            color: #333;
            line-height: 1.8;
            background: #f7fafd;
            border-radius: 10px;
            padding: 1.2em 1em;
            box-shadow: 0 2px 8px #d32f2f13;
        }
        .proof-img-section {
            text-align: center;
        }
        .proof-img-label {
            color: #00695c;
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 1em;
            display: block;
        }
        .proof-img {
            display: block;
            margin: 0 auto 0 auto;
            width: 90vw;
            max-width: 800px;
            max-height: 70vh;
            object-fit: contain;
            border: 6px solid #93ccea;
            border-radius: 18px;
            background-color: #f5faff;
            box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13);
            transition: box-shadow 0.18s, border 0.18s;
        }
        .proof-img:hover {
            box-shadow: 0 16px 48px 0 rgba(211, 47, 47, 0.18);
            border: 6px solid #d32f2f;
        }
        .action-btns {
            text-align: center;
            margin-top: 40px;
        }
        .action-btns button {
            padding: 16px 38px;
            font-size: 1.15rem;
            margin: 0 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            box-shadow: 0 2px 8px #d32f2f33;
            transition: background 0.18s, transform 0.18s;
        }
        .approve-btn {
            background: linear-gradient(90deg, #388e3c 0%, #8ebdd6 100%);
            color: #fff;
        }
        .approve-btn:hover {
            background: linear-gradient(90deg, #00695c 0%, #93ccea 100%);
            transform: translateY(-1px) scale(1.04);
        }
        .reject-btn {
            background: linear-gradient(90deg, #d32f2f 0%, #ffeb3b 100%);
            color: #fff;
        }
        .reject-btn:hover {
            background: linear-gradient(90deg, #c62828 0%, #ffe066 100%);
            color: #d32f2f;
            transform: translateY(-1px) scale(1.04);
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 40px;
            color: #00695c;
            font-weight: bold;
            text-decoration: none;
            font-size: 1.08em;
            transition: color 0.18s;
        }
        .back-link:hover {
            color: #d32f2f;
            text-decoration: underline;
        }
        @media (max-width: 900px) {
            .main-container {
                padding: 0 0.2em;
            }
            .details-card {
                padding: 1.2em 0.2em 1em 0.2em;
            }
            .proof-img {
                max-width: 98vw;
                max-height: 40vh;
            }
            .details-header h2 {
                font-size: 1.2rem;
            }
            .action-btns button {
                padding: 10px 10px;
                font-size: 0.98em;
            }
        }
        @media (max-width: 600px) {
            .main-container {
                padding: 0 0.05em;
            }
            .details-card {
                padding: 0.5em 0.05em 0.5em 0.05em;
            }
            .proof-img {
                max-width: 99vw;
                max-height: 30vh;
            }
            .back-link {
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
    <div class="details-card">
        <div class="details-header">
            <h2><span class="material-icons" style="vertical-align:middle; font-size:1.2em; margin-right:0.3em; color:#ffeb3b;">description</span>Leave Request Details</h2>
        </div>
        <div class="section">
            <h4>Description</h4>
            <p><%= description %></p>
        </div>
        <div class="section proof-img-section">
            <span class="proof-img-label"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; color:#93ccea;">image</span>Proof Image</span>
            <img src="<%= request.getContextPath() + "/" + proofPath %>" class="proof-img" alt="Proof Image" />
        </div>
        <form action="<%= request.getContextPath() %>/UpdateLeaveRequestStatusServlet" method="post" class="action-btns">
            <input type="hidden" name="requestId" value="<%= requestId %>" />
            <button type="submit" name="action" value="Approved" class="approve-btn"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">check_circle</span>Approve</button>
            <button type="submit" name="action" value="Rejected" class="reject-btn"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">cancel</span>Reject</button>
        </form>
        <a href="<%= request.getContextPath() %>/GetSubmittedLeaveRequestsServlet" class="back-link"><span class="material-icons" style="vertical-align:middle; font-size:1.1em; margin-right:0.3em;">arrow_back</span>Back to Leave Requests</a>
    </div>
</div>
</body>
</html>




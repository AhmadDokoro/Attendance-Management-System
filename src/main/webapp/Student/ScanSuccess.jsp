<%-- 
    Document   : ScanSuccess
    Created on : May 25, 2025, 9:12:05 PM
    Author     : PC
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ipAddress = request.getRemoteAddr();  // Get client IP address
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Attendance Success</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .success-box {
            background: #fff;
            padding: 30px 20px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
            text-align: center;
            width: 90%;
            max-width: 400px;
            animation: zoomIn 0.4s ease;
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .checkmark {
            font-size: 60px;
            color: #00695c;
        }

        h2 {
            color: #00695c;
            margin-top: 15px;
            font-size: 1.3rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        p {
            color: #444;
            margin-top: 10px;
            font-size: 1rem;
        }

        .ip-address {
            margin-top: 15px;
            font-size: 0.98rem;
            color: #00695c;
            background: #e0f7fa;
            padding: 10px;
            border-radius: 10px;
            display: inline-block;
            font-weight: 600;
        }

        .footer-note {
            margin-top: 30px;
            font-size: 0.9rem;
            color: #888;
        }

        @media (max-width: 400px) {
            .success-box {
                padding: 12px 2px 10px 2px;
                max-width: 99vw;
            }
            h2 {
                font-size: 1.05rem;
            }
            p, .ip-address, .footer-note {
                font-size: 0.93em;
            }
        }
    </style>
</head>
<body>

<div class="success-box">
    <div class="checkmark">✅</div>
    <h2>Attendance Recorded!</h2>
    <p>You have successfully marked your attendance.</p>
    <div class="ip-address">
        Your IP Address: <strong><%= ipAddress %></strong>
    </div>
    <div class="footer-note">
        Thank you for attending. Have a great class!
    </div>
</div>

</body>
</html>


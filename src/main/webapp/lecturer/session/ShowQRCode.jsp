<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String base64QR = (String) request.getAttribute("qrImage");
    Integer sessionId = (Integer) request.getAttribute("sessionId");

    if (base64QR == null || sessionId == null) {
        response.getWriter().println("Missing QR code or session ID.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session QR Code</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .qr-box {
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 12px 28px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 450px;
        }

        .qr-box h2 {
            color: #0034de;
            margin-bottom: 20px;
            font-size: 1.6rem;
        }

        .qr-box img {
            width: 300px;
            height: 300px;
            border: 6px solid #0034de;
            border-radius: 20px;
        }

        .back-btn {
            margin-top: 20px;
            background-color: #f1f1f1;
            color: #0034de;
            border: 1px solid #ccc;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.95rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .back-btn:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>

    <div class="qr-box">
        <h2>Scan for your Attendance</h2>
        <img id="qrImage" src="data:image/png;base64,<%= base64QR %>" alt="QR Code" />

        <!-- <img src="data:image/png;base64,<%= base64QR %>" alt="QR Code" /> -->

        <form action="<%= request.getContextPath() %>/lecturer/LecturerDashboard.jsp" method="get">
            <button type="submit" class="back-btn">Back to Dashboard</button>
        </form>
    </div>
    <script>
        const sessionId = <%= sessionId %>;
        const qrImg = document.getElementById("qrImage");

        function refreshQR() {
            fetch(`<%= request.getContextPath() %>/RefreshQRServlet?session_id=${sessionId}`)
                .then(response => response.text())
                .then(base64 => {
                    qrImg.src = "data:image/png;base64," + base64;
                })
                .catch(err => console.error("QR refresh failed:", err));
        }
        setInterval(refreshQR, 7000);
    </script>

</body>
</html>


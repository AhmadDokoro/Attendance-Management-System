<%-- 
    Document   : Login
    Created on : May 13, 2025, 6:05:26 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - Attendance System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
      background: linear-gradient(120deg, #e0f7fa 0%, #f1f8e9 100%);
      min-height: 100vh;
    }
    .login-bg {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .login-panel {
      display: flex;
      background: #fff;
      border-radius: 22px;
      box-shadow: 0 8px 32px 0 rgba(0, 105, 92, 0.13), 0 1.5px 8px #d32f2f1a;
      overflow: hidden;
      min-width: 340px;
      max-width: 700px;
      width: 100%;
    }
    .login-left {
      background: linear-gradient(135deg, #00695c 60%, #d32f2f 100%);
      color: #fff;
      min-width: 220px;
      max-width: 260px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 2.5em 1.5em;
      gap: 1.2em;
    }
    .brand-circle {
      width: 70px;
      height: 70px;
      background: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 0.5em;
      box-shadow: 0 2px 8px #d32f2f33;
    }
    .brand-circle img {
      width: 48px;
      height: 48px;
    }
    .brand-title {
      font-size: 1.3rem;
      font-weight: 700;
      margin: 0;
      letter-spacing: 1px;
    }
    .brand-desc {
      font-size: 1.01rem;
      text-align: center;
      margin: 0;
      color: #ffeb3b;
      font-weight: 500;
    }
    .login-form {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      gap: 1.1em;
      padding: 2.5em 2em 2em 2em;
      min-width: 260px;
      max-width: 340px;
    }
    .login-header {
      text-align: left;
      font-size: 1.5rem;
      font-weight: 700;
      color: #00695c;
      margin-bottom: 0.5em;
      letter-spacing: 1px;
    }
    .input {
      height: 2.5em;
      padding: 6px 12px;
      border: 1.5px solid #e0e0e0;
      font-size: 1em;
      border-radius: 8px;
      background: #f7f9fa;
      transition: border 0.2s, box-shadow 0.2s;
      box-shadow: 0 1.5px 6px #e0e0e0;
    }
    .input:focus-visible {
      outline: none;
      border: 1.5px solid #00695c;
      background: #fff;
      box-shadow: 0 2px 8px #b2dfdb;
    }
    #btn {
      font-size: 1.1em;
      letter-spacing: 2px;
      color: #fff;
      font-weight: bold;
      padding: 12px 0;
      background: linear-gradient(90deg, #d32f2f 0%, #00695c 100%);
      border-radius: 10px;
      border: none;
      box-shadow: 0 2px 8px #d32f2f33;
      cursor: pointer;
      transition: background 0.18s, transform 0.18s;
    }
    #btn:hover {
      background: linear-gradient(90deg, #c62828 0%, #004d40 100%);
      transform: translateY(-1px);
    }
    .checkbox-group {
      display: flex;
      align-items: center;
      gap: 0.5em;
      font-size: 0.9em;
      color: #333;
    }
    .error-msg {
      color: #d32f2f;
      background: #f8d7da;
      border: 1px solid #f5c6cb;
      padding: 10px;
      border-radius: 8px;
      font-size: 0.9em;
      text-align: center;
    }
    @media (max-width: 900px) {
      .login-panel {
        flex-direction: column;
        min-width: 0;
        max-width: 98vw;
        width: 98vw;
      }
      .login-left {
        flex-direction: row;
        min-width: 0;
        max-width: 100vw;
        width: 100vw;
        padding: 1.2em 0.5em;
        gap: 0.7em;
        justify-content: flex-start;
      }
      .brand-circle {
        margin-bottom: 0;
        margin-right: 1em;
      }
      .login-form {
        padding: 1.5em 0.5em;
        min-width: 0;
        max-width: 100vw;
        width: 100vw;
      }
    }
    @media (max-width: 600px) {
      .login-panel {
        border-radius: 0;
        box-shadow: none;
      }
      .login-left {
        flex-direction: column;
        align-items: center;
        padding: 1em 0.2em;
        gap: 0.5em;
      }
      .brand-title, .brand-desc {
        font-size: 1rem;
      }
      .login-form {
        padding: 1em 0.2em;
      }
    }
  </style>
</head>
<body>
    <div class="login-bg">
      <div class="login-panel">
        <div class="login-left">
          <div class="brand-circle">
            <img src="https://cdn-icons-png.flaticon.com/512/2991/2991109.png" alt="Attendance Book Icon" />
          </div>
          <h2 class="brand-title">Attendance System</h2>
          <p class="brand-desc">Secure access for students and lecturers. Powered by <br>
            <span style="font-weight:700; letter-spacing:1px; color:#8ebdd6;">AH</span><span style="font-weight:700; letter-spacing:1px; color:#ffeb3b;">$</span><span style="font-weight:700; letter-spacing:1px; color:#93ccea;">MART</span>
          </p>
        </div>
        <form class="login-form" method="post" action="Login">
          <h3 class="login-header">Sign In</h3>
          <input class="input" type="text" name="userId" placeholder="Student ID or Lecturer Email" required>
          <input class="input" type="password" name="password" placeholder="Password" required>
          <div class="checkbox-group">
            <input type="checkbox" id="isLecturer" name="isLecturer">
            <label for="isLecturer">Lecturer?</label>
          </div>
          <button type="submit" id="btn">Login</button>
          <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
          </c:if>
        </form>
      </div>
    </div>
</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="backend.DBUtil" %>

<!DOCTYPE html>
<html>
<head>
    <title>Fitness Tracker - Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: linear-gradient(to right, #74ebd5, #ACB6E5);
        }
        .container {
            width: 360px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            overflow: hidden;
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .header h2 {
            margin: 0;
        }
        .form-container {
            padding: 25px 40px;
            max-width: 360px;
            margin: 0 auto;
        }
        h3 {
            text-align: center;
            color: #333;
            margin-top: 0;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
            width: 100%;
            max-width: 320px;
            margin-left: auto;
            margin-right: auto;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 320px;
            margin: 0 auto;
            display: block;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .message {
            text-align: center;
            margin-top: 20px;
        }
        .error {
            color: #d9534f;
        }
        .success {
            color: #5cb85c;
        }
        .link {
            text-align: center;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <img src="./images/macro.gif" alt="Fitness Tracker Logo" style="width: 300px;" >
        <h2>Create a New Account</h2>
    </div>

    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if ("username_taken".equals(error)) {
    %>
    <div class="message error">That username is already taken. Please choose another.</div>
    <%
    } else if ("true".equals(error)) {
    %>
    <div class="message error">Registration failed. Please try again.</div>
    <%
        }

        if ("register".equals(success)) {
    %>
    <div class="message success">Registration successful! Please <a href="login.jsp">login here</a>.</div>
    <%
        }
    %>


    <form action="registration" method="POST">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" min="1" max="120" required>
        </div>
        <div class="form-group">
            <label for="weight">Weight (kg):</label>
            <input type="number" id="weight" name="weight" step="0.1" min="30" max="500" required>
        </div>
        <div class="form-group">
            <label for="height">Height (cm):</label>
            <input type="number" id="height" name="height" step="0.1" min="100" max="250" required>
        </div>
        <div class="form-group">
            <label for="activityLevel">Activity Level:</label>
            <select id="activityLevel" name="activityLevel" required>
                <option value="Sedentary">Sedentary (little or no exercise)</option>
                <option value="Lightly Active">Lightly Active (light exercise 1-3 days/week)</option>
                <option value="Moderately Active">Moderately Active (moderate exercise 3-5 days/week)</option>
                <option value="Very Active">Very Active (hard exercise 6-7 days/week)</option>
                <option value="Extra Active">Extra Active (very hard exercise & physical job)</option>
            </select>
        </div>
        <div class="form-group">
            <button type="submit" class="btn">Register</button>
        </div>
    </form>

    <div class="link">
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</div>
</body>
</html>
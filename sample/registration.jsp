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
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-weight: bold;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .navbar a.active {
            background-color: #4CAF50;
            color: white;
        }
        .container {
            width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .message {
            text-align: center;
            margin-top: 15px;
        }
        .link {
            text-align: center;
            margin-top: 15px;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Create a New Account</h2>

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


    <form method="post" action="registration">
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
        <button type="submit" class="btn">Register</button>
    </form>

    <div class="link">
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</div>
</body>
</html>
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

<%!

    // Register user information and return the generated user ID
    private int registerUserInfo(String name, int age, float weight, float height, String activityLevel) {
        String sql = "INSERT INTO Users (Name, Age, Weight, Height, ActivityLevel) VALUES (?, ?, ?, ?, ?)";
        int newUserID = -1;
        Connection conn = null;

        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, name);
                stmt.setInt(2, age);
                stmt.setFloat(3, weight);
                stmt.setFloat(4, height);
                stmt.setString(5, activityLevel);

                int affectedRows = stmt.executeUpdate();

                if (affectedRows > 0) {
                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        newUserID = generatedKeys.getInt(1);
                    }
                    generatedKeys.close();
                }
                stmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return newUserID;
    }

    // Register user credentials
    private boolean registerUserCredentials(int userID, String password) {
        String sql = "INSERT INTO user_credentials (UserID, Password) VALUES (?, ?)";
        boolean success = false;
        Connection conn = null;

        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userID);
                // In a real application, NEVER store plain text passwords!
                // Use a secure hashing algorithm like BCrypt
                stmt.setString(2, password);

                success = stmt.executeUpdate() > 0;
                stmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }

    // Delete user if credential registration fails
    private void deleteUser(int userID) {
        String sql = "DELETE FROM Users WHERE UserID = ?";
        Connection conn = null;

        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userID);
                stmt.executeUpdate();
                stmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<%
    String errorMessage = "";
    String successMessage = "";

    // Process the form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Get form parameters
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            int age = Integer.parseInt(request.getParameter("age"));
            float weight = Float.parseFloat(request.getParameter("weight"));
            float height = Float.parseFloat(request.getParameter("height"));
            String activityLevel = request.getParameter("activityLevel");

            // First, create the user in the Users table
            int userID = registerUserInfo(name, age, weight, height, activityLevel);

            if (userID > 0) {
                // User info saved successfully, now save credentials
                if (registerUserCredentials(userID, password)) {
                    // Everything successful
                    successMessage = "Registration successful! You can now login.";
                } else {
                    // If credential saving fails, delete the user entry
                    deleteUser(userID);
                    errorMessage = "Registration failed. Please try again! (cred)";
                }
            } else {
                // User creation failed
                errorMessage = "Registration failed. Please try again! (user)";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Invalid input. Please check your data and try again.";
        } catch (Exception e) {
            errorMessage = "An error occurred. Please try again!";
            e.printStackTrace();
        }
    }
%>

<div class="container">
    <h2>Create a New Account</h2>

    <% if (!successMessage.isEmpty()) { %>
    <div class="message success">
        <%= successMessage %>
        <p>Please <a href="login.jsp">login here</a> to continue.</p>
    </div>
    <% } else { %>
    <% if (!errorMessage.isEmpty()) { %>
    <div class="message error">
        <%= errorMessage %>
    </div>
    <% } %>

    <form method="post" action="registration.jsp">
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
    <% } %>
</div>
</body>
</html>
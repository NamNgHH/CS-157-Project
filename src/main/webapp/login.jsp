<!DOCTYPE html>
<html>
<head>
    <title>Fitness Tracker - Login</title>
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
            width: 380px;
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
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .header h2 {
            margin: 10px 0 0 0;
        }
        .form-container {
            padding: 25px;
        }
        h3 {
            text-align: center;
            color: #333;
            margin-top: 0;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
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
            width: 100%;
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
<!-- No navigation bar at login screen -->

<div class="container">
    <div class="header">
        <img src="./images/macro.gif" alt="Fitness Tracker Logo" style="width: 300px;" >
        <h2>Food & Fitness Tracker</h2>
    </div>
    <div class="form-container">
        <h3>Login to Your Account</h3>
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <div class="message">
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    if (error.equals("true")) {
                    %><p class='error'>Invalid user ID or password!</p><%
                    } else if (error.equals("session")) {
                    %><p class='error'>Your session has expired. Please login again.</p><%
                    } else if (error.equals("unauthorized")) {
                    %><p class='error'>Please login to access this page.</p><%
                }
                }

                String success = request.getParameter("success");
                if (success != null && success.equals("register")) {
                    //out.println("<p class='success'>Registration successful! Please login.</p>");
                }
            %>
        </div>
        <div class="link">
            <p>Don't have an account? <a href="registration.jsp">Register here</a></p>
        </div>
    </div>
</div>
</body>
</html>
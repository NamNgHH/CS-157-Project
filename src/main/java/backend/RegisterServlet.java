package backend;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

// Ensure this matches exactly what you're calling in your form
@WebServlet("/registration")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            // Get form parameters
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int age;
            float weight, height;
            String activityLevel = request.getParameter("activityLevel");

            try {
                age = Integer.parseInt(request.getParameter("age"));
                weight = Float.parseFloat(request.getParameter("weight"));
                height = Float.parseFloat(request.getParameter("height"));
            } catch (NumberFormatException e) {
                response.sendRedirect("registration.jsp?error=true");
                return;
            }

            if (isUsernameTaken(username)) {
                response.sendRedirect("registration.jsp?error=username_taken");
                return;
            }

            int userID = registerUserInfo(name, age, weight, height, activityLevel);

            if (userID > 0) {
                if (registerUserCredentials(userID, username, password)) {
                    System.out.println("Register user credentials succeeded!");
                    response.sendRedirect("login.jsp?success=register");
                } else {
                    System.out.println("Register user credentials failed!");
                    deleteUser(userID);
                    response.sendRedirect("registration.jsp?error=true");
                }
            } else {
                System.out.println("Register user credentials failed miserably!");
                response.sendRedirect("registration.jsp?error=true");
        }
    }

    private int registerUserInfo(String name, int age, float weight, float height, String activityLevel) {
        String sql = "INSERT INTO Users (Name, Age, Weight, Height, ActivityLevel) VALUES (?, ?, ?, ?, ?)";
        int newUserID = -1;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, name);
            stmt.setInt(2, age);
            stmt.setFloat(3, weight);
            stmt.setFloat(4, height);
            stmt.setString(5, activityLevel);

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        newUserID = generatedKeys.getInt(1);
                        System.out.println("Generated UserID: " + newUserID); // DEBUG
                    } else {
                        System.out.println("No key generated!");
                    }
                }
            } else {
                System.out.println("Insert into Users failed!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return newUserID;
    }

    private boolean registerUserCredentials(int userID, String username, String password) {
        String sql = "INSERT INTO user_credentials (UserID, Username, Password) VALUES (?, ?, ?)";
        boolean success = false;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.setString(2, username);
            stmt.setString(3, password);
            success = stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    private boolean isUsernameTaken(String username) {
        String sql = "SELECT 1 FROM user_credentials WHERE Username = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        }
    }

    private void deleteUser(int userID) {
        String sql = "DELETE FROM Users WHERE UserID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

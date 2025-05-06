package backend;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userID;
        String password;

        try {
            userID = Integer.parseInt(request.getParameter("userID"));
            password = request.getParameter("password");
        } catch (NumberFormatException e) {
            response.sendRedirect("login.jsp?error=true");
            return;
        }

        if (authenticateUser(userID, password)) {
            // Create session for user
            HttpSession session = request.getSession();
            session.setAttribute("userID", userID);

            // Fetch user details and add to session
            User user = getUserDetails(userID);
            if (user != null) {
                session.setAttribute("user", user);
                session.setAttribute("userName", user.getName());
            }

            // Redirect to the main application page
            response.sendRedirect("index.html");
        } else {
            // Authentication failed
            response.sendRedirect("login.jsp?error=true");
        }
    }

    private boolean authenticateUser(int userID, String password) {
        String sql = "SELECT * FROM user_credentials WHERE UserID = ? AND Password = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.setString(2, password); // In a real app, use password hashing!

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // If results exist
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private User getUserDetails(int userID) {
        String sql = "SELECT * FROM users WHERE UserID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("UserID"));
                    user.setName(rs.getString("Name"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For GET requests, just forward to the login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
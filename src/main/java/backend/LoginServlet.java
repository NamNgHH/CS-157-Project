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

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            int userID = authenticateUser(username, password);

            if (userID > 0) {
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
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the database connection error
            response.sendRedirect("login.jsp?error=database");
        }
    }

    private int authenticateUser(String username, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT UserID FROM user_credentials WHERE Username = ? AND Password = ?";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Database connection failed");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password); // For production, use hashed passwords

            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("UserID");
            }
            return -1;
        } finally {
            // Close resources in reverse order
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    private User getUserDetails(int userID) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE UserID = ?";

        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Database connection failed");
            }

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);

            rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getInt("Age"),
                        rs.getFloat("Weight"),
                        rs.getFloat("Height"),
                        rs.getString("ActivityLevel")
                );
                return user;
            }
            return null;
        } finally {
            // Close resources in reverse order
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For GET requests, just forward to the login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
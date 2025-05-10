package backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fitness_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Your Password Here";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("Failed to load MySQL JDBC driver: " + e.getMessage());
            throw new RuntimeException("Failed to load MySQL JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            System.out.println("DB connection established!");
            return conn;
        } catch (SQLException e) {
            System.out.println("DB connection failed: " + e.getMessage());
            e.printStackTrace();
            throw e; // Rethrow the exception to be handled by the caller
        }
    }
}

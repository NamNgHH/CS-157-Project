package backend;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getInt("Age"),
                        rs.getFloat("Weight"),
                        rs.getFloat("Height"),
                        rs.getString("ActivityLevel")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Add a user
    public boolean addUser(User user) {
        String sql = "INSERT INTO Users (UserID, Name, Age, Weight, Height, ActivityLevel) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getUserID());
            stmt.setString(2, user.getName());
            stmt.setInt(3, user.getAge());
            stmt.setFloat(4, user.getWeight());
            stmt.setFloat(5, user.getHeight());
            stmt.setString(6, user.getActivityLevel());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a user
    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET Name = ?, Age = ?, Weight = ?, Height = ?, ActivityLevel = ? WHERE UserID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setInt(2, user.getAge());
            stmt.setFloat(3, user.getWeight());
            stmt.setFloat(4, user.getHeight());
            stmt.setString(5, user.getActivityLevel());
            stmt.setInt(6, user.getUserID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a user
    public boolean deleteUser(int userID) {
        String sql = "DELETE FROM Users WHERE UserID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

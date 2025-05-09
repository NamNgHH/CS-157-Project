package backend;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import org.json.JSONObject;
import org.json.JSONArray;

@WebServlet("/SaveMealPlan")
public class SaveMealPlanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String planId = request.getParameter("planId");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userID");

        // Simulated predefined plans, in reality this data should come from somewhere dynamic
        Map<String, Map<String, List<Integer>>> predefinedPlans = Map.of(
                "balanced", Map.of(
                        "breakfast", List.of(1, 2),
                        "lunch", List.of(3, 4),
                        "dinner", List.of(5, 6, 7),
                        "snack", List.of(8, 9)
                ),
                "lowCarb", Map.of(
                        "breakfast", List.of(10, 11),
                        "lunch", List.of(12, 13),
                        "dinner", List.of(14, 15, 16),
                        "snack", List.of(17, 18)
                ),
                "vegetarian", Map.of(
                        "breakfast", List.of(19, 20),
                        "lunch", List.of(21, 22),
                        "dinner", List.of(23, 24),
                        "snack", List.of(25, 26)
                )
        );

        try (Connection conn = DBUtil.getConnection()) {
            // Insert into `plans` table
            String insertPlanSql = "INSERT INTO plans (user_id, plan_name) VALUES (?, ?)";
            PreparedStatement planStmt = conn.prepareStatement(insertPlanSql, Statement.RETURN_GENERATED_KEYS);
            planStmt.setInt(1, userId);
            planStmt.setString(2, planId);
            planStmt.executeUpdate();

            ResultSet rs = planStmt.getGeneratedKeys();
            int newPlanId = -1;
            if (rs.next()) {
                newPlanId = rs.getInt(1);
            }

            // Insert into `plan_meals`
            String insertMealSql = "INSERT INTO plan_meals (plan_id, meal_time, food_id) VALUES (?, ?, ?)";
            PreparedStatement mealStmt = conn.prepareStatement(insertMealSql);

            Map<String, List<Integer>> meals = predefinedPlans.get(planId);
            for (String mealTime : meals.keySet()) {
                for (int foodId : meals.get(mealTime)) {
                    mealStmt.setInt(1, newPlanId);
                    mealStmt.setString(2, mealTime);
                    mealStmt.setInt(3, foodId);
                    mealStmt.addBatch();
                }
            }
            mealStmt.executeBatch();

            response.sendRedirect("diet_planner.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("meal-plans.jsp?error=true");
        }
    }
}


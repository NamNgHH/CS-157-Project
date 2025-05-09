package backend;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import org.json.JSONObject;

@WebServlet("/SaveMealPlan")
public class SaveMealPlanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userID = (Integer) session.getAttribute("userID");

        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try (Connection conn = DBUtil.getConnection()) {
            JSONObject requestBody = new JSONObject(sb.toString());
            String planName = requestBody.getString("planName");
            JSONObject calories = requestBody.getJSONObject("calories");

            // Step 1: Insert into plans table
            String insertPlanSQL = "INSERT INTO plans (user_id, plan_name) VALUES (?, ?)";
            PreparedStatement planStmt = conn.prepareStatement(insertPlanSQL, Statement.RETURN_GENERATED_KEYS);
            planStmt.setInt(1, userID);
            planStmt.setString(2, planName);
            planStmt.executeUpdate();

            ResultSet generatedKeys = planStmt.getGeneratedKeys();
            if (!generatedKeys.next()) {
                throw new SQLException("Failed to insert new plan.");
            }

            int newPlanId = generatedKeys.getInt(1);

            // Step 2: Insert into calorie_plans table
            String insertCaloriesSQL = "INSERT INTO calorie_plans (plan_id, breakfast_calories, lunch_calories, dinner_calories, snack_calories) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement calorieStmt = conn.prepareStatement(insertCaloriesSQL);
            calorieStmt.setInt(1, newPlanId);
            calorieStmt.setInt(2, calories.getInt("breakfast"));
            calorieStmt.setInt(3, calories.getInt("lunch"));
            calorieStmt.setInt(4, calories.getInt("dinner"));
            calorieStmt.setInt(5, calories.getInt("snacks"));
            calorieStmt.executeUpdate();

            response.sendRedirect("diet_planner.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving meal plan.");
        }
    }
}

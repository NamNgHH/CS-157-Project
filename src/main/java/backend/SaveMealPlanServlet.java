package backend;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import org.json.JSONObject;
import org.json.JSONArray;

@WebServlet("/saveMealPlan")
public class SaveMealPlanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            JSONObject plan = new JSONObject(json.toString());

            Connection conn = DBUtil.getConnection();
            String sql = "INSERT INTO MealPlan (DayOfWeek, MealType, FoodItem) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            for (String day : plan.keySet()) {
                JSONObject meals = plan.getJSONObject(day);
                for (String meal : meals.keySet()) {
                    JSONArray foods = meals.getJSONArray(meal);
                    for (int i = 0; i < foods.length(); i++) {
                        String foodItem = foods.getString(i);
                        stmt.setString(1, day);
                        stmt.setString(2, meal);
                        stmt.setString(3, foodItem);
                        stmt.addBatch();
                    }
                }
            }

            stmt.executeBatch();
            conn.close();

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace(); // already included
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("ERROR: " + e.getMessage());
        }
    }
}


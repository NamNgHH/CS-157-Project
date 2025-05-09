package backend;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlanDAO {
    public static class MealPlan {
        public String planName;
        public int breakfastCalories;
        public int lunchCalories;
        public int dinnerCalories;
        public int snackCalories;

        public MealPlan(String planName, int b, int l, int d, int s) {
            this.planName = planName;
            this.breakfastCalories = b;
            this.lunchCalories = l;
            this.dinnerCalories = d;
            this.snackCalories = s;
        }
    }

    public List<MealPlan> getUserMealPlans(int userId) throws SQLException {
        List<MealPlan> mealPlans = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String query = """
                SELECT p.plan_name, c.breakfast_calories, c.lunch_calories, 
                       c.dinner_calories, c.snack_calories
                FROM plans p
                JOIN calorie_plans c ON p.plan_id = c.plan_id
                WHERE p.user_id = ?
            """;
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                mealPlans.add(new MealPlan(
                        rs.getString("plan_name"),
                        rs.getInt("breakfast_calories"),
                        rs.getInt("lunch_calories"),
                        rs.getInt("dinner_calories"),
                        rs.getInt("snack_calories")
                ));
            }
        }
        return mealPlans;
    }
}

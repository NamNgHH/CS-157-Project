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

            // You can now loop through days & meals, then INSERT each item into your DB

            // For now, just confirm it works
            System.out.println("Received meal plan: " + plan.toString());

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

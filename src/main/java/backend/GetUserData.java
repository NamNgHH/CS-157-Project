package backend;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 * Servlet to fetch user data using UserDAO
 */
@WebServlet("/GetUserData")
public class GetUserData extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUserData() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get the user ID from the session
            HttpSession session = request.getSession();
            Integer userID = (Integer) session.getAttribute("userID");

            if (userID == null) {
                // If user ID is not in session, return error
                System.out.println("User not logged in or ID not found in session");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                JSONObject errorJson = new JSONObject();
                errorJson.put("error", "User not logged in");
                out.print(errorJson.toString());
                return;
            }

            // Use UserDAO to get user data
            System.out.println("Attempting to get user data for ID: " + userID);
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUser(userID);

            if (user == null) {
                // User not found
                System.out.println("User not found in database for ID: " + userID);
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                JSONObject errorJson = new JSONObject();
                errorJson.put("error", "User not found");
                out.print(errorJson.toString());
                return;
            }

            // Create JSON object with user data
            JSONObject userJson = new JSONObject();
            userJson.put("name", user.getName());
            userJson.put("age", user.getAge());
            userJson.put("weight", user.getWeight());
            userJson.put("height", user.getHeight());
            userJson.put("activityLevel", user.getActivityLevel());

            System.out.println("User data retrieved successfully: " + userJson.toString());

            // Send JSON response
            out.print(userJson.toString());

        } catch (Exception e) {
            // Log the error
            System.out.println("Error in GetUserData servlet: " + e.getMessage());
            e.printStackTrace();

            // Return error response
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject errorJson = new JSONObject();
            errorJson.put("error", "Internal server error: " + e.getMessage());
            out.print(errorJson.toString());
        } finally {
            out.flush();
        }
    }
}
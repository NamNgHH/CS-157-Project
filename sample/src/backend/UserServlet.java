package backend;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/addUser")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userID = Integer.parseInt(request.getParameter("userID"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        float weight = Float.parseFloat(request.getParameter("weight"));
        float height = Float.parseFloat(request.getParameter("height"));
        String activityLevel = request.getParameter("activityLevel");

        User user = new User(userID, name, age, weight, height, activityLevel);

        UserDAO dao = new UserDAO();
        boolean success = dao.addUser(user);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if (success) {
            out.println("<h2>User added successfully!</h2>");
        } else {
            out.println("<h2>Error adding user.</h2>");
        }
    }
}


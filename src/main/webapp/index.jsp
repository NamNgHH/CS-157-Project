<%@ page import="java.awt.*" %>
<%@ page session="true" %>
<%@ page import="backend.UserDAO" %>
<%@ page import="backend.User" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.PlanDAO" %>
<%@ page import="backend.PlanDAO.MealPlan" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="backend.DBUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    String userName = null;
    try {
        int userID = (Integer) session.getAttribute("userID");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userID);
        userName = user.getName();
    } catch (Exception e) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<MealPlan> savedPlans = new ArrayList<>();
    try {
        int userID = (Integer) session.getAttribute("userID");
        PlanDAO planDAO = new PlanDAO();
        savedPlans = planDAO.getUserMealPlans(userID);
    } catch (Exception e) {
        e.printStackTrace();
    }
    int userID = -1;
    try {
        userID = (Integer) session.getAttribute("userID");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userID);
        userName = user.getName();
    } catch (Exception e) {
        response.sendRedirect("login.jsp");
        return;
    }

%>


<html>
<head>
    <title>Food Data Search Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-weight: bold;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .navbar a.active {
            background-color: #4CAF50;
            color: white;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            background-color: #fff;
            padding: 30px;
            min-height: 250px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .header-content {
            display: flex;
            align-items: center;
        }
        .header img {
            margin-right: 20px;
            width: 300px;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
        }
        .content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .saved-plans-box {
            width: 500px;
            max-height: 400px;
            overflow-y: auto;
            padding: 10px 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
            font-size: 14px;
        }
        .search-results {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
        .food-item {
            padding: 8px;
            border-bottom: 1px solid #eee;
        }
        .food-item:nth-child(odd) {
            background-color: #f9f9f9;
        }
    </style>
    <script>
        function searchFoods() {
            const resultDiv = document.getElementById('searchResults');
            resultDiv.innerHTML = '<p>Loading...</p>';

            const searchTerm = document.getElementById('searchInput').value || 'apple';
            const API_KEY = "dctfXgFbUaCfb0s1WeDSmRKjjAoxc7iMRaz2nbxl";
            const url = `https://api.nal.usda.gov/fdc/v1/foods/search?query=\${searchTerm}&pageSize=50&api_key=\${API_KEY}`;

            fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('HTTP error ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    let foods = data.foods || [];

                    // Filter out items missing any of the 4 key nutrients
                    foods = foods.filter(food => {
                        const nutrientIds = food.foodNutrients.map(n => n.nutrientId);
                        return [1008, 1003, 1004, 1005].every(id => nutrientIds.includes(id));
                    });

                    // Prioritize branded/foundation foods
                    foods = foods.sort((a, b) => {
                        const score = food =>
                            (food.dataType === 'Branded' ? 2 : 0) +
                            (food.dataType === 'Foundation' ? 1 : 0);
                        return score(b) - score(a);
                    });

                    // Only show the top 25
                    foods = foods.slice(0, 25);

                    // Display results
                    if (foods.length > 0) {
                        let html = `<h3>Top 20 Results for "\${searchTerm}":</h3>`;
                        html += '<div class="search-results">';

                        const getNutrientValue = (food, id) => {
                            const n = food.foodNutrients.find(n => n.nutrientId === id);
                            return n ? `\${n.value} \${n.unitName}` : "N/A";
                        };

                        foods.forEach(food => {
                            html += `
                <div class="food-item">
                    <strong>\${food.description}</strong><br>
                    Calories: \${getNutrientValue(food, 1008)} |
                    Protein: \${getNutrientValue(food, 1003)} |
                    Carbs: \${getNutrientValue(food, 1005)} |
                    Fat: \${getNutrientValue(food, 1004)}
                </div>`;
                        });

                        html += '</div>';
                        resultDiv.innerHTML = html;
                    } else {
                        resultDiv.innerHTML = `<p>No complete results found for "\${searchTerm}"</p>`;
                    }
                })
                .catch(error => {
                    resultDiv.innerHTML = '<p>Error fetching data: ' + error.message + '</p>';
                    console.error('Error:', error);
                });

        }

        // Load data when page loads
        window.onload = function() {
            searchFoods();
        };
    </script>
</head>
<body>
<div class="navbar">
    <a href="index.jsp" class="active">Home</a>
    <a href="meal-plans.jsp">Meal Plans</a>
    <span style="float:right; color:white; padding:14px 16px;">
        <% if (userName != null) { %>
            Current User: <%= Character.toUpperCase(userName.charAt(0)) + userName.substring(1) %>
        <% } %>
    </span>
</div>

<div class="header">
    <div class="header-content">
        <img src="./images/download.gif" alt="Tomcat Logo">
        <div>
            <h1>Food Data Search Application</h1>
            <p style="font-size: 1.2em; font-weight: bold;">
                Hello, <%= Character.toUpperCase(userName.charAt(0)) + userName.substring(1) %>!
            </p>
            <p>This application uses the USDA Food Data Central API to search for food information.</p>
        </div>
    </div>
    <div class="saved-plans-box">
        <h3>Your Saved Meal Plans</h3>
        <%
            Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT p.plan_id, p.plan_name, f.meal_time, f.name, f.calories " +
                            "FROM plans p JOIN food f ON p.plan_id = f.plan_id " +
                            "WHERE p.user_id = ? " +
                            "ORDER BY p.plan_id, FIELD(f.meal_time, 'breakfast', 'lunch', 'dinner', 'snacks')"
            );
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            int currentPlanId = -1;
            String currentMeal = "";

            while (rs.next()) {
                int planId = rs.getInt("plan_id");
                String planName = rs.getString("plan_name");
                String mealTime = rs.getString("meal_time");
                String foodName = rs.getString("name");
                int calories = rs.getInt("calories");

                if (planId != currentPlanId) {
                    if (currentPlanId != -1) { %><br><% }
    %>
        <h4 style="margin-top: 20px;"><%= planName.replaceAll("_", " ") %></h4>
        <%
                currentPlanId = planId;
                currentMeal = "";
            }

            if (!mealTime.equals(currentMeal)) {
        %>
        <strong><%= mealTime.substring(0,1).toUpperCase() + mealTime.substring(1) %></strong><br>
        <%
                currentMeal = mealTime;
            }
        %>
        &bull; <%= foodName %> - <%= calories %> cal<br>
        <%
            }
            rs.close();
            ps.close();
            conn.close();
        %>
    </div>
</div>

<div class="content">
    <div>
        <label for="searchInput">Search for foods: </label>
        <input type="text" id="searchInput" placeholder="Enter food name (default: apple)">
        <button onclick="searchFoods()">Search</button>
    </div>

    <div id="searchResults">
        <!-- Search results will be displayed here -->
    </div>

    <hr>
    <p></p>
</div>
</body>
</html>
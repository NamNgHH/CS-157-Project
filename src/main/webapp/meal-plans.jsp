<%@ page session="true" %>
<%@ page import="backend.UserDAO" %>
<%@ page import="backend.User" %>
<%
    String userName = null;
    int age = 0;
    float weight = 0;
    float height = 0;
    String activityLevel = null;
    float bmr = 0;
    float dailyGoal = 0;
    try {
        int userID = (Integer) session.getAttribute("userID");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userID);
        userName = user.getName();
        age = user.getAge();
        weight = user.getWeight();
        height = user.getHeight();
        activityLevel = user.getActivityLevel();
        // Calculate BMR (using Mifflin-St Jeor Equation for males)
        bmr = (float) ((10.0 * weight) + (6.25 * height) - (5 * age) + 5);

        // Activity multiplier
        float multiplier = switch (activityLevel) {
            case "Sedentary" -> 1.2f;
            case "Lightly Active" -> 1.375f;
            case "Moderately Active" -> 1.55f;
            case "Very Active" -> 1.725f;
            case "Extra Active" -> 1.9f;
            default -> 1.0f;
        };
        // Calculate daily calorie goal
        dailyGoal = bmr * multiplier;
    } catch (Exception e) {
        // Set an error message attribute to notify the user
        request.setAttribute("errorMessage", "Error loading user data. Please try again.");
        // Forward the request to the login page with the error message
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<head lang="en">
    <title>Personalized Meal Plans - Food Data Search Application</title>
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
            align-items: center;
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
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
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .user-info {
            background-color: #e8f5e9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #4CAF50;
        }

        .user-stats {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }

        .user-stat {
            background-color: #f9f9f9;
            padding: 10px 15px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            flex: 1;
            min-width: 120px;
        }

        .user-stat h4 {
            margin: 0 0 5px 0;
            color: #4CAF50;
        }

        .user-stat p {
            margin: 0;
            font-size: 18px;
            font-weight: bold;
        }

        .meal-plan {
            margin-bottom: 30px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 20px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            border-radius: 8px;
            padding: 15px;
            position: relative;
        }

        .meal-plan:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background-color: #f9fff9;
        }

        .meal-plan.selected {
            background-color: #e8f5e9;
            border: 2px solid #4CAF50;
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.2);
        }

        .meal {
            margin: 10px 0;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }

        .meal h4 {
            margin-top: 0;
            color: #4CAF50;
            display: flex;
            justify-content: space-between;
        }

        .meal-item {
            margin: 5px 0;
            display: flex;
            justify-content: space-between;
        }

        .meal-item-name {
            flex: 1;
        }

        .meal-item-weight {
            font-weight: bold;
            color: #333;
            margin-left: 10px;
            min-width: 80px;
            text-align: right;
        }

        .meal-item-calories {
            color: #666;
            width: 80px;
            text-align: right;
        }

        .select-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            display: none;
        }

        .selected .select-badge {
            display: block;
        }

        .save-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 24px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 20px 0;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .save-button:hover {
            background-color: #45a049;
        }

        .save-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        .save-container {
            text-align: center;
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: opacity 0.5s;
            opacity: 0;
            z-index: 1000;
        }

        .notification.show {
            opacity: 1;
        }

        .calorie-adjustments {
            background-color: #f0f8ff;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border-left: 4px solid #4682b4;
        }

        .adjustment-controls {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-top: 10px;
        }

        .adjustment-button {
            background-color: #4682b4;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 3px;
            cursor: pointer;
            font-weight: bold;
        }

        .adjustment-button:hover {
            background-color: #3a6d99;
        }

        .adjustment-value {
            font-weight: bold;
            font-size: 18px;
            width: 60px;
            text-align: center;
        }

        .plan-calories {
            font-weight: bold;
            color: #4682b4;
            margin-left: 10px;
        }

        .meal-type-calories {
            font-weight: normal;
            font-size: 14px;
        }

        .loading-message {
            text-align: center;
            padding: 20px;
            font-style: italic;
            color: #666;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="meal-plans.jsp">Meal Plans</a>
    <span style="float:right; color:white; padding:14px 16px;">
        <% if (userName != null) { %>
            Current User: <%= Character.toUpperCase(userName.charAt(0)) + userName.substring(1) %>
        <% } %>
    </span>
</div>

<div class="header">
    <img src="./images/download.gif" alt="Logo">
    <div>
        <h1>Personalized Meal Plans</h1>
        <p>Meal plans with portion sizes based on your caloric needs.</p>
    </div>
</div>

<div class="content">
    <div id="userInfoDisplay" class="user-info">
        <h3>Your Information</h3>
        <div class="user-stats">
            <div class="user-stat">
                <h4>Name</h4>
                <p id="userName">
                    <% if (userName != null && !userName.isEmpty()) { %>
                    <%= Character.toUpperCase(userName.charAt(0)) + userName.substring(1).toLowerCase() %>
                    <% } else { %>
                    Unknown
                    <% } %>
                </p>
            </div>
            <div class="user-stat">
                <h4>BMR</h4>
                <p id="bmrValue">
                    <%= String.format("%.2f", bmr) %> kcal/day
                </p>
            </div>
            <div class="user-stat">
                <h4>Daily Goal</h4>
                <p id="dailyGoalValue">
                    <%= String.format("%.2f", dailyGoal) %> kcal/day
                </p>
            </div>
        </div>
    </div>

    <div class="calorie-adjustments">
        <h3>Adjust Your Calorie Goal</h3>
        <p>Fine-tune your meal plan by adjusting calories up or down:</p>
        <div class="adjustment-controls">
            <button class="adjustment-button" onclick="adjustCalories(-100)">-100</button>
            <span id="calorieAdjustmentDisplay" class="adjustment-value">0</span>
            <button class="adjustment-button" onclick="adjustCalories(100)">+100</button>
            <span>Adjusted Daily Goal: <span id="adjustedGoal">Loading...</span> calories</span>
        </div>
    </div>

    <h2>Your Personalized Meal Plans</h2>
    <p>These meal plans are customized based on your caloric needs. The portion sizes are adjusted to meet your daily
        calorie goal.</p>

    <div id="mealPlansContainer">
        <div class="loading-message">Loading your personalized meal plans...</div>
    </div>

    <div class="save-container">
        <button id="saveButton" class="save-button" onclick="saveMealPlan()" disabled>Save Selected Meal Plan</button>
    </div>

    <div id="notification" class="notification">Meal plan saved successfully!</div>

    <p><a href="index.jsp">Return to food search</a> to find nutritional information for specific foods.</p>
</div>

<script>

    var userName = "<%= userName %>";
    var age = <%= age %>;
    var weight = <%= weight %>;
    var height = <%= height %>;
    var activityLevel = "<%= activityLevel %>";
    var bmr = <%= bmr %>;
    var dailyGoal = <%= dailyGoal %>;

    // Define meal plan templates with calorie densities (calories per 100g)
    const mealPlans = {
        balanced: {
            name: "Balanced Nutrition Plan",
            description: "A well-balanced meal plan with appropriate distribution of macronutrients.",
            meals: {
                breakfast: [
                    {name: "Oatmeal with berries and nuts", calorieDensity: 100, baseAmount: 100},
                    {name: "Greek yogurt", calorieDensity: 60, baseAmount: 150}
                ],
                lunch: [
                    {name: "Grilled chicken salad with olive oil dressing", calorieDensity: 150, baseAmount: 300},
                    {name: "Whole grain bread", calorieDensity: 240, baseAmount: 50}
                ],
                dinner: [
                    {name: "Baked salmon", calorieDensity: 200, baseAmount: 150},
                    {name: "Steamed vegetables", calorieDensity: 30, baseAmount: 200},
                    {name: "Brown rice", calorieDensity: 130, baseAmount: 100}
                ],
                snacks: [
                    {name: "Apple and peanut butter", calorieDensity: 170, baseAmount: 120},
                    {name: "Mixed nuts", calorieDensity: 600, baseAmount: 30}
                ]
            }
        },
        lowCarb: {
            name: "Low-Carb Plan",
            description: "A low-carbohydrate meal plan with focus on protein and healthy fats.",
            meals: {
                breakfast: [
                    {name: "Scrambled eggs with spinach and feta", calorieDensity: 150, baseAmount: 200},
                    {name: "Avocado slices", calorieDensity: 160, baseAmount: 100}
                ],
                lunch: [
                    {name: "Tuna salad lettuce wraps", calorieDensity: 140, baseAmount: 250},
                    {name: "Cucumber and bell pepper slices with hummus", calorieDensity: 70, baseAmount: 200}
                ],
                dinner: [
                    {name: "Grilled steak", calorieDensity: 250, baseAmount: 150},
                    {name: "Roasted Brussels sprouts", calorieDensity: 45, baseAmount: 150},
                    {name: "Cauliflower mash", calorieDensity: 40, baseAmount: 200}
                ],
                snacks: [
                    {name: "Cheese and olives", calorieDensity: 350, baseAmount: 60},
                    {name: "Hard-boiled eggs", calorieDensity: 155, baseAmount: 100}
                ]
            }
        },
        vegetarian: {
            name: "Vegetarian Plan",
            description: "A plant-based meal plan rich in nutrients and protein sources.",
            meals: {
                breakfast: [
                    {name: "Smoothie with spinach, banana, and plant protein", calorieDensity: 80, baseAmount: 300},
                    {name: "Whole grain toast with avocado", calorieDensity: 240, baseAmount: 80}
                ],
                lunch: [
                    {name: "Quinoa bowl with roasted vegetables", calorieDensity: 120, baseAmount: 300},
                    {name: "Lentil soup", calorieDensity: 100, baseAmount: 250}
                ],
                dinner: [
                    {name: "Tofu stir-fry with mixed vegetables", calorieDensity: 120, baseAmount: 300},
                    {name: "Brown rice", calorieDensity: 130, baseAmount: 150}
                ],
                snacks: [
                    {name: "Hummus with carrot sticks", calorieDensity: 80, baseAmount: 180},
                    {name: "Trail mix with dried fruits and nuts", calorieDensity: 480, baseAmount: 40}
                ]
            }
        }
    };

    // Global variables
    let selectedPlan = null;
    let userBMR = <%= bmr %>;
    let dailyCalorieGoal = <%= dailyGoal %>;
    let calorieAdjustment = 0;

    // Activity multipliers
    const activityMultipliers = {
        "Sedentary": 1.2,
        "Lightly Active": 1.375,
        "Moderately Active": 1.55,
        "Very Active": 1.725,
        "Extra Active": 1.9
    };

    // Meal distribution percentages
    const mealDistribution = {
        breakfast: 0.25,
        lunch: 0.35,
        dinner: 0.30,
        snacks: 0.10
    };

    // Calculate BMR using Mifflin-St Jeor Equation
    function calculateBMR(weight, height, age) {
        // Using male formula for now (the servlet code doesn't store gender)
        return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    }

    // Generate meal plans based on calorie goal
    function generateMealPlans(calorieGoal) {
        const mealPlansContainer = document.getElementById('mealPlansContainer');
        mealPlansContainer.innerHTML = '';

        // Calculate calories for each meal type
        const mealCalories = {
            breakfast: Math.round(calorieGoal * mealDistribution.breakfast),
            lunch: Math.round(calorieGoal * mealDistribution.lunch),
            dinner: Math.round(calorieGoal * mealDistribution.dinner),
            snacks: Math.round(calorieGoal * mealDistribution.snacks)
        };

        // Create HTML for each meal plan
        for (const [planId, plan] of Object.entries(mealPlans)) {
            const mealPlanDiv = document.createElement('div');
            mealPlanDiv.className = 'meal-plan';
            mealPlanDiv.onclick = function () {
                toggleSelection(this, planId);
            };

            let planHTML = `
    <div class="select-badge">Selected</div>
    <h3 id ="planName">`+plan.name +`<span class="plan-calories">(`+ calorieGoal + `calories)</span></h3>
    <p>`+ plan.description + `</p>`;

            // Generate each meal type
            for (const [mealType, mealItems] of Object.entries(plan.meals)) {
                const typeTotalCalories = mealCalories[mealType];

                planHTML += `
    <div class="meal">
        <h4>`+mealType.charAt(0).toUpperCase() + mealType.slice(1)+`
            <span class="meal-type-calories">(`+typeTotalCalories+` cal)</span>
        </h4>
`;

                // Calculate scaling factor for this meal type
                const baseCalories = mealItems.reduce((sum, item) => {
                    return sum + (item.calorieDensity * item.baseAmount / 100);
                }, 0);

                const scalingFactor = typeTotalCalories / baseCalories;

                // Add each food item with adjusted portion
                mealItems.forEach(item => {
                    const adjustedAmount = Math.round(item.baseAmount * scalingFactor);
                    const itemCalories = Math.round(item.calorieDensity * adjustedAmount / 100);

                    planHTML += `
    <div class="meal-item">
        <span class="meal-item-name">`+item.name+`</span>
        <span class="meal-item-weight">`+adjustedAmount+`g</span>
        <span class="meal-item-calories">`+itemCalories+` cal</span>
    </div>
`;
                });

                planHTML += `</div>`;
            }
            mealPlanDiv.innerHTML = planHTML;
            mealPlansContainer.appendChild(mealPlanDiv);

        }
    }

    // Adjust calories
    function adjustCalories(amount) {
        calorieAdjustment += amount;
        document.getElementById('calorieAdjustmentDisplay').textContent = calorieAdjustment > 0 ? +calorieAdjustment : calorieAdjustment;

        const adjustedGoal = dailyCalorieGoal + calorieAdjustment;
        document.getElementById('adjustedGoal').textContent = adjustedGoal;

        // Regenerate meal plans with new calorie goal
        generateMealPlans(adjustedGoal);

        // Reset selection
        selectedPlan = null;
        document.getElementById('saveButton').disabled = true;
        const allPlans = document.querySelectorAll('.meal-plan');
        allPlans.forEach(plan => {
            plan.classList.remove('selected');
        });
    }

    // Toggle meal plan selection
    function toggleSelection(element, planId) {
        // Remove selection from previously selected plan
        const allPlans = document.querySelectorAll('.meal-plan');
        allPlans.forEach(plan => {
            plan.classList.remove('selected');
        });

        // Select the clicked plan
        element.classList.add('selected');
        selectedPlan = planId;

        // Enable save button
        document.getElementById('saveButton').disabled = false;
    }

    // Save meal plan
    function saveMealPlan() {
        if (!selectedPlan) {
            alert('Please select a meal plan first.');
            return;
        }

        const calorieGoal = dailyCalorieGoal + calorieAdjustment;

        // Recalculate per-meal calories
        const mealCalories = {
            breakfast: Math.round(calorieGoal * mealDistribution.breakfast),
            lunch: Math.round(calorieGoal * mealDistribution.lunch),
            dinner: Math.round(calorieGoal * mealDistribution.dinner),
            snacks: Math.round(calorieGoal * mealDistribution.snacks)
        };

        const payload = {
            planName: mealPlans[selectedPlan].name,
            calories: mealCalories,
            meals: mealPlans[selectedPlan].meals
        };

        fetch("SaveMealPlan", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(payload)
        }).then(response => {
            if (response.redirected) {
                window.location.href = response.url;
            } else {
                alert("Failed to save meal plan.");
            }
        }).catch(error => {
            console.error("Error:", error);
            alert("Error saving meal plan.");
        });
    }
    generateMealPlans(dailyCalorieGoal);
</script>
</body>
</html>
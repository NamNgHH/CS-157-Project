<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diet Planner</title>
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .header img {
            margin-right: 20px;
        }
        .content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        #searchResults {
            margin-top: 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
            max-height: 300px;
            overflow-y: auto;
        }
        .food-item {
            padding: 8px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .food-item button {
            padding: 2px 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .controls {
            margin: 20px 0;
            display: flex;
            gap: 10px;
        }
        input, button, select {
            padding: 8px;
            margin: 5px 0;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="meal-plans.jsp">Meal Plans</a>
    <a href="diet_planner.jsp" class="active">Diet Planner</a>
</div>
<div class="header">
    <img src="./images/download.gif">
    <div>
        <h1>Diet Planner</h1>
        <p>Search for nutritional information about different foods.</p>
    </div>
</div>
<div class="content">
    <div class="container">
        <div class="controls">
            <input type="text" id="searchInput" placeholder="Search for food">
            <button onclick="searchFoods()">Search Food</button>
        </div>

        <div id="searchResults"></div>
    </div>
</div>

<script>
    function searchFoods() {
        const resultDiv = document.getElementById('searchResults');
        resultDiv.innerHTML = '<p>Loading...</p>';

        const searchTerm = document.getElementById('searchInput').value || 'apple';
        const API_KEY = "dctfXgFbUaCfb0s1WeDSmRKjjAoxc7iMRaz2nbxl";
        const url = `https://api.nal.usda.gov/fdc/v1/foods/search?query=${searchTerm}&api_key=${API_KEY}`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                const foods = data.foods;
                if (foods && foods.length > 0) {
                    let html = '<h3>Search Results:</h3>';
                    foods.slice(0, 10).forEach(food => {
                        html += `
                            <div class="food-item">
                                <span>${food.description}</span>
                                <button onclick="showNutrition('${food.fdcId}')">View Nutrition</button>
                            </div>`;
                    });
                    resultDiv.innerHTML = html;
                } else {
                    resultDiv.innerHTML = '<p>No results found</p>';
                }
            })
            .catch(error => {
                resultDiv.innerHTML = '<p>Error fetching data: ' + error.message + '</p>';
            });
    }

    function showNutrition(fdcId) {
        const resultDiv = document.getElementById('searchResults');
        resultDiv.innerHTML += '<p>Loading nutrition information...</p>';

        const API_KEY = "dctfXgFbUaCfb0s1WeDSmRKjjAoxc7iMRaz2nbxl";
        const url = `https://api.nal.usda.gov/fdc/v1/food/${fdcId}?api_key=${API_KEY}`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                let nutritionHtml = `
                    <div style="margin-top: 20px; padding: 15px; background-color: #fff; border-radius: 5px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                        <h3>Nutrition Information for ${data.description}</h3>
                        <table style="width: 100%; border-collapse: collapse;">
                            <tr style="background-color: #f2f2f2;">
                                <th style="padding: 8px; text-align: left; border-bottom: 1px solid #ddd;">Nutrient</th>
                                <th style="padding: 8px; text-align: right; border-bottom: 1px solid #ddd;">Amount</th>
                            </tr>`;

                if (data.foodNutrients) {
                    data.foodNutrients.slice(0, 15).forEach(nutrient => {
                        if (nutrient.nutrient && nutrient.amount) {
                            nutritionHtml += `
                                <tr>
                                    <td style="padding: 8px; text-align: left; border-bottom: 1px solid #ddd;">${nutrient.nutrient.name}</td>
                                    <td style="padding: 8px; text-align: right; border-bottom: 1px solid #ddd;">${nutrient.amount} ${nutrient.nutrient.unitName}</td>
                                </tr>`;
                        }
                    });
                }

                nutritionHtml += `
                        </table>
                    </div>`;

                resultDiv.innerHTML += nutritionHtml;
            })
            .catch(error => {
                resultDiv.innerHTML += '<p>Error fetching nutrition data: ' + error.message + '</p>';
            });
    }
</script>
</body>
</html>
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
            const url = `https://api.nal.usda.gov/fdc/v1/foods/search?query=${searchTerm}&api_key=${API_KEY}`;

            fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('HTTP error ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    const foods = data.foods;
                    if (foods && foods.length > 0) {
                        let html = '<h3>Search Results for "' + searchTerm + '":</h3>';
                        html += '<div class="search-results">';
                        foods.forEach(food => {
                            html += `<div class="food-item">- ${food.description}</div>`;
                        });
                        html += '</div>';
                        resultDiv.innerHTML = html;
                    } else {
                        resultDiv.innerHTML = '<p>No results found for "' + searchTerm + '"</p>';
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
</div>

<div class="header">
    <img src="/sample/images/download.gif" alt="Tomcat Logo">
    <div>
        <h1>Food Data Search Application</h1>
        <p>This application uses the USDA Food Data Central API to search for food information.</p>
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
    <p><%= new String("Hello! Welcome to the Food Data Search Application.") %></p>
</div>
</body>
</html>
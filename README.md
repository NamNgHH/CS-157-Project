# Calories Deficit Planner(Cs-157A-Project)
## Overview
This project is designed to help users make informed dietary decisions by providing essential macronutrient data through a search feature integrated with the USDA Food API. By inputting personal information such as height, weight, and activity level, users receive a tailored calorie recommendation based on one of our preset nutrition plans. 
### Key Features
- **User Registration & Login:** Secure account creation and authentication.
- **Meal Plan Management:** Users can save and modify one of the preset meal plans.
- **Food Search:** Integration with the USDA Food Data Central API to provide detailed nutritional data for various foods.
- **Nutritional Insights:** Displays information like calories, protein, carbohydrates, and fat for each food item.
- **Database-backed Storage:** User and meal plan data are stored in a relational database.
- **Responsive UI:** Built using JSP pages, styled with CSS, and makes use of JavaScript for interactive search functionality.

## Technologies used in this project
- __MySQL__  (8.0.xx)  
- __Apache Tomcat__ (Tomcat 11)  
- __Java__  
- __HTML__  
- __CSS__  
## Setting up
## Setup Instructions
### 1. **Install Prerequisites**
Make sure you have the following software installed:
- **Java JDK 17** (or compatible version)
- **Apache Tomcat** (version 9 or higher recommended)
- **Maven** (for dependency management and building)
- **MySQL** (or another compatible SQL database)

### 2. **Clone or Download the Project**
Clone the repository or download the source code to your machine.
``` shell
git clone <your-repo-url>
cd CS-157-Project
```
### 3. **Configure the Database**
1. **Create a Database:**
    - Open your MySQL client (CLI or GUI such as MySQL Workbench).
    - Run the provided script to set up the database tables:
``` sql
     -- In your MySQL client:
     SOURCE path/to/fitness_db.sql;
```
1. **Update Database Connection Settings:**
    - Ensure your database credentials (host, username, password) in the class match your local setup. `DBUtil`

### 4. **Build the Project with Maven**
From the project root directory, run:
``` shell
mvn clean package
```
This will compile your project and produce a `.war` file in the `target/` directory.
### 5. **Deploy to Tomcat**
1. **Copy the WAR File:**
    - Locate the generated `.war` file in the `target/` directory.
    - Copy it to your Tomcat’s `webapps` folder.

2. **Start Tomcat:**
    - Run Tomcat using its `bin/startup.sh` (Linux/Mac) or `bin/startup.bat` (Windows) script.

3. **Access the Application:**
    - Open your browser and go to:
``` 
     http://localhost:8080/CS-157-Project/
```
### 6. **Register and Log In**
- First, register a new account using the registration page.
- After registering, log in to access your dashboard and other features.

### 7. **Using the Application**
- **Search Foods:** Use the search bar on the homepage to look up foods and their nutritional info from the USDA API.
- **Meal Plans:** Create, view, and manage personalized preset meal plans and track nutritional data.

## Troubleshooting
- **Port Issues:** If Tomcat’s 8080 port is in use, change it in Tomcat’s `server.xml` or free the port.
- **Database Errors:** Double-check your MySQL service is running and your credentials match.
- **Dependencies:** Ensure your Maven dependencies are downloaded without errors.



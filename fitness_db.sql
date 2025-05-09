-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: fitness_db
-- ------------------------------------------------------
-- Server version	8.0.42

DROP DATABASE IF EXISTS fitness_db;
CREATE DATABASE fitness_db;
USE fitness_db;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calorie_plans`
--

DROP TABLE IF EXISTS `calorie_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calorie_plans` (
  `plan_id` int NOT NULL,
  `breakfast_calories` int DEFAULT NULL,
  `lunch_calories` int DEFAULT NULL,
  `dinner_calories` int DEFAULT NULL,
  `snack_calories` int DEFAULT NULL,
  PRIMARY KEY (`plan_id`),
  CONSTRAINT `calorie_plans_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`plan_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calorie_plans`
--

LOCK TABLES `calorie_plans` WRITE;
/*!40000 ALTER TABLE `calorie_plans` DISABLE KEYS */;
INSERT INTO `calorie_plans` VALUES (32,417,583,500,167),(33,417,583,500,167),(34,417,583,500,167),(35,417,583,500,167),(36,417,583,500,167),(37,417,583,500,167),(38,417,583,500,167),(39,417,583,500,167),(40,467,653,560,187),(41,417,583,500,167),(42,717,1003,860,287),(43,167,233,200,67),(44,1242,1738,1490,497);
/*!40000 ALTER TABLE `calorie_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `calories` int NOT NULL,
  `protein` float DEFAULT NULL,
  `carbs` float DEFAULT NULL,
  `fat` float DEFAULT NULL,
  `meal_time` varchar(20) DEFAULT NULL,
  `plan_id` int DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `fk_plan_id` (`plan_id`),
  CONSTRAINT `fk_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`plan_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (28,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,NULL,NULL),(29,'Whole grain bread',120,NULL,NULL,NULL,NULL,NULL),(30,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,NULL,NULL),(31,'Greek yogurt',90,NULL,NULL,NULL,NULL,NULL),(32,'Apple and peanut butter',204,NULL,NULL,NULL,NULL,NULL),(33,'Mixed nuts',180,NULL,NULL,NULL,NULL,NULL),(34,'Baked salmon',300,NULL,NULL,NULL,NULL,NULL),(35,'Steamed vegetables',60,NULL,NULL,NULL,NULL,NULL),(36,'Brown rice',130,NULL,NULL,NULL,NULL,NULL),(37,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,NULL,NULL),(38,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,NULL,NULL),(39,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,NULL,NULL),(40,'Avocado slices',160,NULL,NULL,NULL,NULL,NULL),(41,'Cheese and olives',210,NULL,NULL,NULL,NULL,NULL),(42,'Hard-boiled eggs',155,NULL,NULL,NULL,NULL,NULL),(43,'Grilled steak',375,NULL,NULL,NULL,NULL,NULL),(44,'Roasted Brussels sprouts',68,NULL,NULL,NULL,NULL,NULL),(45,'Cauliflower mash',80,NULL,NULL,NULL,NULL,NULL),(46,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,NULL,NULL),(47,'Lentil soup',250,NULL,NULL,NULL,NULL,NULL),(48,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,NULL,NULL),(49,'Whole grain toast with avocado',192,NULL,NULL,NULL,NULL,NULL),(50,'Hummus with carrot sticks',144,NULL,NULL,NULL,NULL,NULL),(51,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,NULL,NULL),(52,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,NULL,NULL),(53,'Brown rice',195,NULL,NULL,NULL,NULL,NULL),(54,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,NULL,NULL),(55,'Whole grain bread',120,NULL,NULL,NULL,NULL,NULL),(56,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,NULL,NULL),(57,'Greek yogurt',90,NULL,NULL,NULL,NULL,NULL),(58,'Apple and peanut butter',204,NULL,NULL,NULL,NULL,NULL),(59,'Mixed nuts',180,NULL,NULL,NULL,NULL,NULL),(60,'Baked salmon',300,NULL,NULL,NULL,NULL,NULL),(61,'Steamed vegetables',60,NULL,NULL,NULL,NULL,NULL),(62,'Brown rice',130,NULL,NULL,NULL,NULL,NULL),(63,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,NULL,NULL),(64,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,NULL,NULL),(65,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,NULL,NULL),(66,'Avocado slices',160,NULL,NULL,NULL,NULL,NULL),(67,'Cheese and olives',210,NULL,NULL,NULL,NULL,NULL),(68,'Hard-boiled eggs',155,NULL,NULL,NULL,NULL,NULL),(69,'Grilled steak',375,NULL,NULL,NULL,NULL,NULL),(70,'Roasted Brussels sprouts',68,NULL,NULL,NULL,NULL,NULL),(71,'Cauliflower mash',80,NULL,NULL,NULL,NULL,NULL),(72,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,NULL,NULL),(73,'Lentil soup',250,NULL,NULL,NULL,NULL,NULL),(74,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,NULL,NULL),(75,'Whole grain toast with avocado',192,NULL,NULL,NULL,NULL,NULL),(76,'Hummus with carrot sticks',144,NULL,NULL,NULL,NULL,NULL),(77,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,NULL,NULL),(78,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,NULL,NULL),(79,'Brown rice',195,NULL,NULL,NULL,NULL,NULL),(80,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',38),(81,'Whole grain bread',120,NULL,NULL,NULL,'lunch',38),(82,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',38),(83,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',38),(84,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',38),(85,'Mixed nuts',180,NULL,NULL,NULL,'snacks',38),(86,'Baked salmon',300,NULL,NULL,NULL,'dinner',38),(87,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',38),(88,'Brown rice',130,NULL,NULL,NULL,'dinner',38),(89,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',39),(90,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',39),(91,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',39),(92,'Avocado slices',160,NULL,NULL,NULL,'breakfast',39),(93,'Cheese and olives',210,NULL,NULL,NULL,'snacks',39),(94,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',39),(95,'Grilled steak',375,NULL,NULL,NULL,'dinner',39),(96,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',39),(97,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',39),(98,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',40),(99,'Lentil soup',250,NULL,NULL,NULL,'lunch',40),(100,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',40),(101,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',40),(102,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',40),(103,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',40),(104,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',40),(105,'Brown rice',195,NULL,NULL,NULL,'dinner',40),(106,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',41),(107,'Whole grain bread',120,NULL,NULL,NULL,'lunch',41),(108,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',41),(109,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',41),(110,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',41),(111,'Mixed nuts',180,NULL,NULL,NULL,'snacks',41),(112,'Baked salmon',300,NULL,NULL,NULL,'dinner',41),(113,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',41),(114,'Brown rice',130,NULL,NULL,NULL,'dinner',41),(115,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',42),(116,'Whole grain bread',120,NULL,NULL,NULL,'lunch',42),(117,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',42),(118,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',42),(119,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',42),(120,'Mixed nuts',180,NULL,NULL,NULL,'snacks',42),(121,'Baked salmon',300,NULL,NULL,NULL,'dinner',42),(122,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',42),(123,'Brown rice',130,NULL,NULL,NULL,'dinner',42),(124,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',43),(125,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',43),(126,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',43),(127,'Avocado slices',160,NULL,NULL,NULL,'breakfast',43),(128,'Cheese and olives',210,NULL,NULL,NULL,'snacks',43),(129,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',43),(130,'Grilled steak',375,NULL,NULL,NULL,'dinner',43),(131,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',43),(132,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',43),(133,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',44),(134,'Whole grain bread',120,NULL,NULL,NULL,'lunch',44),(135,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',44),(136,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',44),(137,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',44),(138,'Mixed nuts',180,NULL,NULL,NULL,'snacks',44),(139,'Baked salmon',300,NULL,NULL,NULL,'dinner',44),(140,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',44),(141,'Brown rice',130,NULL,NULL,NULL,'dinner',44);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  PRIMARY KEY (`plan_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `plans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (32,3,'Balanced Nutrition Plan'),(33,3,'Low-Carb Plan'),(34,3,'Vegetarian Plan'),(35,3,'Balanced Nutrition Plan'),(36,3,'Low-Carb Plan'),(37,3,'Vegetarian Plan'),(38,3,'Balanced Nutrition Plan'),(39,3,'Low-Carb Plan'),(40,3,'Vegetarian Plan'),(41,3,'Balanced Nutrition Plan'),(42,3,'Balanced Nutrition Plan'),(43,3,'Low-Carb Plan'),(44,3,'Balanced Nutrition Plan');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_credentials`
--

DROP TABLE IF EXISTS `user_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_credentials` (
  `UserID` int NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Username_2` (`Username`),
  CONSTRAINT `user_credentials_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_credentials`
--

LOCK TABLES `user_credentials` WRITE;
/*!40000 ALTER TABLE `user_credentials` DISABLE KEYS */;
INSERT INTO `user_credentials` VALUES (1,'chris','123'),(2,'khao','1234'),(3,'katie','tran'),(4,'yeng','her'),(5,'nam','123'),(6,'alex','000'),(7,'wonha','111'),(8,'josh','222'),(9,'kaden','999'),(10,'kha','000'),(11,'yes','no');
/*!40000 ALTER TABLE `user_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Age` int NOT NULL,
  `Weight` float NOT NULL,
  `Height` float NOT NULL,
  `ActivityLevel` varchar(50) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'chris',120,120,120,'Sedentary'),(2,'khao',120,120,120,'Sedentary'),(3,'katie',89,89,100,'Moderately Active'),(4,'yeng',120,120,120,'Sedentary'),(5,'nam',120,120,120,'Sedentary'),(6,'alex',120,120,120,'Sedentary'),(7,'wonha',120,120,120,'Lightly Active'),(8,'josh',89,300,130,'Very Active'),(9,'kaden',1,250,250,'Lightly Active'),(10,'kha',120,120,120,'Sedentary'),(11,'yes',99,99,199,'Sedentary');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-09  2:45:42

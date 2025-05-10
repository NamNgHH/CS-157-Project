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
INSERT INTO `calorie_plans` VALUES (1,422,591,507,169),(2,647,906,777,259),(3,547,766,657,219),(4,603,844,723,241),(5,678,949,813,271),(6,453,634,543,181),(7,631,883,757,252),(8,556,778,667,222),(9,606,848,727,242),(10,578,809,693,231),(11,478,669,573,191),(12,678,949,813,271),(13,895,1253,1074,358),(14,695,973,834,278),(15,770,1078,924,308),(16,510,714,612,204),(17,485,679,582,194),(18,460,644,552,184);
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
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',1),(2,'Whole grain bread',120,NULL,NULL,NULL,'lunch',1),(3,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',1),(4,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',1),(5,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',1),(6,'Mixed nuts',180,NULL,NULL,NULL,'snacks',1),(7,'Baked salmon',300,NULL,NULL,NULL,'dinner',1),(8,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',1),(9,'Brown rice',130,NULL,NULL,NULL,'dinner',1),(10,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',2),(11,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',2),(12,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',2),(13,'Avocado slices',160,NULL,NULL,NULL,'breakfast',2),(14,'Cheese and olives',210,NULL,NULL,NULL,'snacks',2),(15,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',2),(16,'Grilled steak',375,NULL,NULL,NULL,'dinner',2),(17,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',2),(18,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',2),(19,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',3),(20,'Lentil soup',250,NULL,NULL,NULL,'lunch',3),(21,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',3),(22,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',3),(23,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',3),(24,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',3),(25,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',3),(26,'Brown rice',195,NULL,NULL,NULL,'dinner',3),(27,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',4),(28,'Whole grain bread',120,NULL,NULL,NULL,'lunch',4),(29,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',4),(30,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',4),(31,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',4),(32,'Mixed nuts',180,NULL,NULL,NULL,'snacks',4),(33,'Baked salmon',300,NULL,NULL,NULL,'dinner',4),(34,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',4),(35,'Brown rice',130,NULL,NULL,NULL,'dinner',4),(36,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',5),(37,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',5),(38,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',5),(39,'Avocado slices',160,NULL,NULL,NULL,'breakfast',5),(40,'Cheese and olives',210,NULL,NULL,NULL,'snacks',5),(41,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',5),(42,'Grilled steak',375,NULL,NULL,NULL,'dinner',5),(43,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',5),(44,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',5),(45,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',6),(46,'Lentil soup',250,NULL,NULL,NULL,'lunch',6),(47,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',6),(48,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',6),(49,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',6),(50,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',6),(51,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',6),(52,'Brown rice',195,NULL,NULL,NULL,'dinner',6),(53,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',7),(54,'Whole grain bread',120,NULL,NULL,NULL,'lunch',7),(55,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',7),(56,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',7),(57,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',7),(58,'Mixed nuts',180,NULL,NULL,NULL,'snacks',7),(59,'Baked salmon',300,NULL,NULL,NULL,'dinner',7),(60,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',7),(61,'Brown rice',130,NULL,NULL,NULL,'dinner',7),(62,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',8),(63,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',8),(64,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',8),(65,'Avocado slices',160,NULL,NULL,NULL,'breakfast',8),(66,'Cheese and olives',210,NULL,NULL,NULL,'snacks',8),(67,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',8),(68,'Grilled steak',375,NULL,NULL,NULL,'dinner',8),(69,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',8),(70,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',8),(71,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',9),(72,'Lentil soup',250,NULL,NULL,NULL,'lunch',9),(73,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',9),(74,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',9),(75,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',9),(76,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',9),(77,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',9),(78,'Brown rice',195,NULL,NULL,NULL,'dinner',9),(79,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',10),(80,'Whole grain bread',120,NULL,NULL,NULL,'lunch',10),(81,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',10),(82,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',10),(83,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',10),(84,'Mixed nuts',180,NULL,NULL,NULL,'snacks',10),(85,'Baked salmon',300,NULL,NULL,NULL,'dinner',10),(86,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',10),(87,'Brown rice',130,NULL,NULL,NULL,'dinner',10),(88,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',11),(89,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',11),(90,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',11),(91,'Avocado slices',160,NULL,NULL,NULL,'breakfast',11),(92,'Cheese and olives',210,NULL,NULL,NULL,'snacks',11),(93,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',11),(94,'Grilled steak',375,NULL,NULL,NULL,'dinner',11),(95,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',11),(96,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',11),(97,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',12),(98,'Lentil soup',250,NULL,NULL,NULL,'lunch',12),(99,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',12),(100,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',12),(101,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',12),(102,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',12),(103,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',12),(104,'Brown rice',195,NULL,NULL,NULL,'dinner',12),(105,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',13),(106,'Whole grain bread',120,NULL,NULL,NULL,'lunch',13),(107,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',13),(108,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',13),(109,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',13),(110,'Mixed nuts',180,NULL,NULL,NULL,'snacks',13),(111,'Baked salmon',300,NULL,NULL,NULL,'dinner',13),(112,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',13),(113,'Brown rice',130,NULL,NULL,NULL,'dinner',13),(114,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',14),(115,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',14),(116,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',14),(117,'Avocado slices',160,NULL,NULL,NULL,'breakfast',14),(118,'Cheese and olives',210,NULL,NULL,NULL,'snacks',14),(119,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',14),(120,'Grilled steak',375,NULL,NULL,NULL,'dinner',14),(121,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',14),(122,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',14),(123,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',15),(124,'Lentil soup',250,NULL,NULL,NULL,'lunch',15),(125,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',15),(126,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',15),(127,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',15),(128,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',15),(129,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',15),(130,'Brown rice',195,NULL,NULL,NULL,'dinner',15),(131,'Grilled chicken salad with olive oil dressing',450,NULL,NULL,NULL,'lunch',16),(132,'Whole grain bread',120,NULL,NULL,NULL,'lunch',16),(133,'Oatmeal with berries and nuts',100,NULL,NULL,NULL,'breakfast',16),(134,'Greek yogurt',90,NULL,NULL,NULL,'breakfast',16),(135,'Apple and peanut butter',204,NULL,NULL,NULL,'snacks',16),(136,'Mixed nuts',180,NULL,NULL,NULL,'snacks',16),(137,'Baked salmon',300,NULL,NULL,NULL,'dinner',16),(138,'Steamed vegetables',60,NULL,NULL,NULL,'dinner',16),(139,'Brown rice',130,NULL,NULL,NULL,'dinner',16),(140,'Tuna salad lettuce wraps',350,NULL,NULL,NULL,'lunch',17),(141,'Cucumber and bell pepper slices with hummus',140,NULL,NULL,NULL,'lunch',17),(142,'Scrambled eggs with spinach and feta',300,NULL,NULL,NULL,'breakfast',17),(143,'Avocado slices',160,NULL,NULL,NULL,'breakfast',17),(144,'Cheese and olives',210,NULL,NULL,NULL,'snacks',17),(145,'Hard-boiled eggs',155,NULL,NULL,NULL,'snacks',17),(146,'Grilled steak',375,NULL,NULL,NULL,'dinner',17),(147,'Roasted Brussels sprouts',68,NULL,NULL,NULL,'dinner',17),(148,'Cauliflower mash',80,NULL,NULL,NULL,'dinner',17),(149,'Quinoa bowl with roasted vegetables',360,NULL,NULL,NULL,'lunch',18),(150,'Lentil soup',250,NULL,NULL,NULL,'lunch',18),(151,'Smoothie with spinach, banana, and plant protein',240,NULL,NULL,NULL,'breakfast',18),(152,'Whole grain toast with avocado',192,NULL,NULL,NULL,'breakfast',18),(153,'Hummus with carrot sticks',144,NULL,NULL,NULL,'snacks',18),(154,'Trail mix with dried fruits and nuts',192,NULL,NULL,NULL,'snacks',18),(155,'Tofu stir-fry with mixed vegetables',360,NULL,NULL,NULL,'dinner',18),(156,'Brown rice',195,NULL,NULL,NULL,'dinner',18);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,1,'Balanced Nutrition Plan'),(2,1,'Low-Carb Plan'),(3,1,'Vegetarian Plan'),(4,2,'Balanced Nutrition Plan'),(5,2,'Low-Carb Plan'),(6,2,'Vegetarian Plan'),(7,3,'Balanced Nutrition Plan'),(8,3,'Low-Carb Plan'),(9,3,'Vegetarian Plan'),(10,4,'Balanced Nutrition Plan'),(11,4,'Low-Carb Plan'),(12,4,'Vegetarian Plan'),(13,5,'Balanced Nutrition Plan'),(14,5,'Low-Carb Plan'),(15,5,'Vegetarian Plan'),(16,6,'Balanced Nutrition Plan'),(17,6,'Low-Carb Plan'),(18,6,'Vegetarian Plan');
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
INSERT INTO `user_credentials` VALUES (1,'Christianher89','Chris123'),(2,'YengHer96','Ethan55!'),(3,'NamNguyen21','Nguyen101?'),(4,'Alice50589','Aliceisthebest7'),(5,'BLee7','Bleed?$'),(6,'ClaraM4','M4door'),(7,'DJMustard','IMDJ'),(8,'EmPatel12','Harrypotter$'),(9,'KhanAcademy','MATH'),(10,'UponGrace','Kimberly101'),(11,'Thump999','STOMP!!'),(12,'imisabelle','Soccer4life'),(13,'KungFuMaster','FIGHT'),(14,'JohnDoe','000'),(15,'JaneDoe','111');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Christian Her',20,79.3,180.3,'Sedentary'),(2,'Yeng Her',20,63.5,162.5,'Moderately Active'),(3,'Nam Nguyen',20,68,165,'Lightly Active'),(4,'Alice Nguyen',25,58,165,'Moderately Active'),(5,'Brandon Lee',19,75,180,'Very Active'),(6,'Clara Martinez',23,52,160,'Lightly Active'),(7,'David Johnson',28,80,175,'Extra Active'),(8,'Emma Patel',18,54,158,'Moderately Active'),(9,'Faisal Khan',27,68,172,'Sedentary'),(10,'Grace Kim',22,60,168,'Lightly Active'),(11,'Henry Thompson',29,85,183,'Very Active'),(12,'Isabella Rossi',34,56,162,'Moderately Active'),(13,'Jackie Chan',71,70,178,'Extra Active'),(14,'John Doe',20,100,100,'Moderately Active'),(15,'Jane Doe',30,80,100,'Moderately Active');
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

-- Dump completed on 2025-05-09 22:49:37

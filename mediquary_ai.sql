-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: mediquary_ai
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment_slots`
--

DROP TABLE IF EXISTS `appointment_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_slots` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` int DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `slot_time` time DEFAULT NULL,
  `status` enum('free','occupied') DEFAULT 'free',
  `patient_id` int DEFAULT NULL,
  PRIMARY KEY (`slot_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `appointment_slots_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`),
  CONSTRAINT `appointment_slots_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_slots`
--

LOCK TABLES `appointment_slots` WRITE;
/*!40000 ALTER TABLE `appointment_slots` DISABLE KEYS */;
INSERT INTO `appointment_slots` VALUES (9,1,'2026-02-20','10:00:00','free',NULL),(10,1,'2026-02-20','10:15:00','occupied',1),(11,1,'2026-02-20','10:30:00','occupied',1),(12,1,'2026-02-20','10:45:00','free',NULL),(13,1,'2026-02-20','11:00:00','free',NULL),(14,1,'2026-02-20','11:15:00','free',NULL),(15,1,'2026-02-20','11:30:00','free',NULL),(16,1,'2026-02-20','11:45:00','free',NULL),(17,1,'2026-02-20','10:00:00','occupied',1),(18,1,'2026-02-20','10:15:00','occupied',1),(19,1,'2026-02-20','10:30:00','occupied',1),(20,1,'2026-02-20','10:45:00','free',NULL),(21,1,'2026-02-20','11:00:00','free',NULL),(22,1,'2026-02-20','11:15:00','free',NULL),(23,1,'2026-02-20','11:30:00','free',NULL),(24,1,'2026-02-20','11:45:00','free',NULL),(25,2,'2026-02-20','10:00:00','free',NULL),(26,2,'2026-02-20','10:15:00','free',NULL),(27,2,'2026-02-20','10:30:00','free',NULL),(28,2,'2026-02-20','10:45:00','free',NULL),(29,2,'2026-02-20','11:00:00','free',NULL),(30,2,'2026-02-20','11:15:00','free',NULL),(31,2,'2026-02-20','11:30:00','free',NULL),(32,2,'2026-02-20','11:45:00','free',NULL),(33,3,'2026-02-20','10:00:00','occupied',1),(34,3,'2026-02-20','10:15:00','free',NULL),(35,3,'2026-02-20','10:30:00','free',NULL),(36,3,'2026-02-20','10:45:00','free',NULL),(37,3,'2026-02-20','11:00:00','free',NULL),(38,3,'2026-02-20','11:15:00','free',NULL),(39,3,'2026-02-20','11:30:00','free',NULL),(40,3,'2026-02-20','11:45:00','free',NULL),(41,4,'2026-02-20','10:00:00','free',NULL),(42,4,'2026-02-20','10:15:00','free',NULL),(43,4,'2026-02-20','10:30:00','free',NULL),(44,4,'2026-02-20','10:45:00','free',NULL),(45,4,'2026-02-20','11:00:00','free',NULL),(46,4,'2026-02-20','11:15:00','free',NULL),(47,4,'2026-02-20','11:30:00','free',NULL),(48,4,'2026-02-20','11:45:00','free',NULL),(49,5,'2026-02-20','10:00:00','free',NULL),(50,5,'2026-02-20','10:15:00','free',NULL),(51,5,'2026-02-20','10:30:00','free',NULL),(52,5,'2026-02-20','10:45:00','free',NULL),(53,5,'2026-02-20','11:00:00','free',NULL),(54,5,'2026-02-20','11:15:00','free',NULL),(55,5,'2026-02-20','11:30:00','free',NULL),(56,5,'2026-02-20','11:45:00','free',NULL);
/*!40000 ALTER TABLE `appointment_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `status` enum('requested','confirmed','completed','cancelled') DEFAULT 'requested',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,1,1,'2026-02-10','10:00:00','confirmed','2026-02-05 09:51:13'),(2,1,1,'2026-02-10','10:00:00','requested','2026-02-14 11:46:58'),(3,1,1,'2026-02-10','10:30:00','requested','2026-02-14 11:47:41'),(4,1,1,'2026-02-10','10:30:00','requested','2026-02-14 14:42:34'),(5,1,1,'2026-02-10','11:00:00','requested','2026-02-14 14:46:18'),(6,1,1,'2026-02-10','10:45:00','requested','2026-02-14 14:47:08'),(7,1,1,'2026-02-10','11:00:00','requested','2026-02-15 16:00:25'),(8,1,1,'2026-02-20','10:00:00','requested','2026-02-15 18:22:21'),(9,1,3,'2026-02-20','10:00:00','requested','2026-02-15 18:26:43'),(10,1,1,'2026-02-20','10:30:00','requested','2026-02-16 03:13:54'),(11,1,1,'2026-02-20','10:15:00','requested','2026-02-16 06:54:04'),(12,1,1,'2026-02-20','10:15:00','requested','2026-02-16 07:46:57'),(13,1,1,'2026-02-20','10:30:00','requested','2026-02-16 15:14:03');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_agents`
--

DROP TABLE IF EXISTS `delivery_agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_agents` (
  `agent_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `vehicle_type` varchar(20) DEFAULT NULL,
  `status` enum('available','busy') DEFAULT 'available',
  `rating` decimal(2,1) DEFAULT '0.0',
  PRIMARY KEY (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_agents`
--

LOCK TABLES `delivery_agents` WRITE;
/*!40000 ALTER TABLE `delivery_agents` DISABLE KEYS */;
INSERT INTO `delivery_agents` VALUES (1,'Ravi Kumar','9876543210','Bike','available',4.6),(2,'Suresh Reddy','9876543221','Bike','available',4.4),(3,'Anil Sharma','9876543232','Scooter','busy',4.2);
/*!40000 ALTER TABLE `delivery_agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_availability`
--

DROP TABLE IF EXISTS `doctor_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_availability` (
  `availability_id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` int DEFAULT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `slot_duration` int DEFAULT NULL,
  PRIMARY KEY (`availability_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_availability_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_availability`
--

LOCK TABLES `doctor_availability` WRITE;
/*!40000 ALTER TABLE `doctor_availability` DISABLE KEYS */;
INSERT INTO `doctor_availability` VALUES (1,1,'Monday','10:00:00','13:00:00',15);
/*!40000 ALTER TABLE `doctor_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_verification_logs`
--

DROP TABLE IF EXISTS `doctor_verification_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_verification_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `prescription_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `action` enum('approved','modified','rejected') DEFAULT NULL,
  `remarks` text,
  `action_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `prescription_id` (`prescription_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_verification_logs_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`prescription_id`),
  CONSTRAINT `doctor_verification_logs_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_verification_logs`
--

LOCK TABLES `doctor_verification_logs` WRITE;
/*!40000 ALTER TABLE `doctor_verification_logs` DISABLE KEYS */;
INSERT INTO `doctor_verification_logs` VALUES (1,1,1,'approved','AI extraction verified','2026-02-05 08:51:29'),(2,1,1,'approved','Valid prescription','2026-02-05 09:52:02'),(3,1,1,'approved','Valid prescription','2026-02-05 09:52:10');
/*!40000 ALTER TABLE `doctor_verification_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `experience_years` int DEFAULT NULL,
  `room_number` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,1,'Cardiology','Heart Care',10,'301'),(2,2,'ENT','Otolaryngology',8,'210'),(3,3,'General Medicine','Internal Medicine',12,'105'),(4,4,'Gynecology','Women Health',9,'412'),(5,5,'Orthopedics','Bone & Joint',15,'520');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_records`
--

DROP TABLE IF EXISTS `medical_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_records` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `prescription_id` int DEFAULT NULL,
  `patient_id` int DEFAULT NULL,
  `medicine_name` varchar(100) DEFAULT NULL,
  `dosage` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `instructions` text,
  PRIMARY KEY (`record_id`),
  KEY `prescription_id` (`prescription_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `medical_records_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`prescription_id`),
  CONSTRAINT `medical_records_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_records`
--

LOCK TABLES `medical_records` WRITE;
/*!40000 ALTER TABLE `medical_records` DISABLE KEYS */;
INSERT INTO `medical_records` VALUES (3,1,1,'Paracetamol','500mg','5 days','After food'),(4,1,1,'Cetirizine','10mg','3 days','At night'),(5,1,1,'Paracetamol','500mg','5 days','After food');
/*!40000 ALTER TABLE `medical_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_delivery`
--

DROP TABLE IF EXISTS `order_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_delivery` (
  `delivery_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `pharmacy_id` int DEFAULT NULL,
  `agent_id` int DEFAULT NULL,
  `delivery_status` enum('assigned','picked_up','in_transit','delivered') DEFAULT 'assigned',
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`delivery_id`),
  KEY `order_id` (`order_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `agent_id` (`agent_id`),
  CONSTRAINT `order_delivery_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_delivery_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`pharmacy_id`),
  CONSTRAINT `order_delivery_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `delivery_agents` (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_delivery`
--

LOCK TABLES `order_delivery` WRITE;
/*!40000 ALTER TABLE `order_delivery` DISABLE KEYS */;
INSERT INTO `order_delivery` VALUES (1,1,1,1,'delivered','2026-02-05 09:38:55'),(2,1,1,1,'assigned','2026-02-05 09:53:19');
/*!40000 ALTER TABLE `order_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `prescription_id` int DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `delivery_fee` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','agent_assigned','picked_up','in_transit','delivered','cancelled') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `patient_id` (`patient_id`),
  KEY `prescription_id` (`prescription_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`prescription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,120.00,20.00,'pending','2026-02-05 08:51:48'),(2,1,1,120.00,20.00,'pending','2026-02-05 09:52:19');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `address` text,
  `patient_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,6,'Female','1990-05-14','A+','Chennai','Sarah Jenkins'),(2,7,'Male','1988-11-22','B+','Bangalore','Rahul Verma'),(3,8,'Female','1995-03-10','O+','Hyderabad','Anita Kumar'),(4,9,'Male','2000-07-18','AB-','Coimbatore','Karthik R');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacies`
--

DROP TABLE IF EXISTS `pharmacies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacies` (
  `pharmacy_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `address` text,
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT '0.0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pharmacy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacies`
--

LOCK TABLES `pharmacies` WRITE;
/*!40000 ALTER TABLE `pharmacies` DISABLE KEYS */;
INSERT INTO `pharmacies` VALUES (1,'Apollo Pharmacy','MG Road','Chennai','9001112233',4.5,'2026-02-05 09:38:15'),(2,'MedPlus Store','Brigade Road','Bangalore','9002223344',4.3,'2026-02-05 09:38:15'),(3,'Care Pharmacy','HiTech City','Hyderabad','9003334455',4.1,'2026-02-05 09:38:15');
/*!40000 ALTER TABLE `pharmacies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy_inventory`
--

DROP TABLE IF EXISTS `pharmacy_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy_inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `pharmacy_id` int DEFAULT NULL,
  `medicine_name` varchar(100) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  CONSTRAINT `pharmacy_inventory_ibfk_1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`pharmacy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_inventory`
--

LOCK TABLES `pharmacy_inventory` WRITE;
/*!40000 ALTER TABLE `pharmacy_inventory` DISABLE KEYS */;
INSERT INTO `pharmacy_inventory` VALUES (1,1,'Paracetamol',200,25.00),(2,1,'Cetirizine',150,20.00),(3,2,'Paracetamol',100,27.00),(4,2,'Amoxicillin',80,85.00),(5,3,'Ibuprofen',90,35.00);
/*!40000 ALTER TABLE `pharmacy_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `prescription_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `file_path` text,
  `status` enum('uploaded','ai_processed','approved','modified','rejected','completed') DEFAULT 'uploaded',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prescription_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
INSERT INTO `prescriptions` VALUES (1,1,'prescriptions/pres_001.jpg','approved','2026-02-05 08:49:43'),(2,1,'prescriptions/rahul_heart.pdf','uploaded','2026-02-05 09:51:36');
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_logs`
--

DROP TABLE IF EXISTS `query_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `query_logs` (
  `query_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_query` text,
  `generated_sql` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`query_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `query_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_logs`
--

LOCK TABLES `query_logs` WRITE;
/*!40000 ALTER TABLE `query_logs` DISABLE KEYS */;
INSERT INTO `query_logs` VALUES (1,1,'Show my medicines','SELECT medicine_name, dosage FROM medical_records WHERE patient_id=1','2026-02-05 08:51:55'),(2,1,'Show available slots for Dr. Ananya',NULL,'2026-02-05 09:50:14'),(3,1,'What medicines am I taking?',NULL,'2026-02-05 09:53:59');
/*!40000 ALTER TABLE `query_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `pharmacy_id` int DEFAULT NULL,
  `agent_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rating_id`),
  KEY `patient_id` (`patient_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `agent_id` (`agent_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`pharmacy_id`),
  CONSTRAINT `ratings_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `delivery_agents` (`agent_id`),
  CONSTRAINT `ratings_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,1,1,NULL,5,'Fast delivery and genuine medicines','2026-02-05 09:39:14'),(2,1,NULL,1,4,'Polite and on-time delivery','2026-02-05 09:39:23'),(3,1,1,NULL,5,'Very fast delivery','2026-02-05 09:53:34');
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_subscriptions`
--

DROP TABLE IF EXISTS `store_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_subscriptions` (
  `subscription_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `pharmacy_id` int DEFAULT NULL,
  `plan_name` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('active','expired') DEFAULT 'active',
  PRIMARY KEY (`subscription_id`),
  KEY `patient_id` (`patient_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  CONSTRAINT `store_subscriptions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `store_subscriptions_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`pharmacy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_subscriptions`
--

LOCK TABLES `store_subscriptions` WRITE;
/*!40000 ALTER TABLE `store_subscriptions` DISABLE KEYS */;
INSERT INTO `store_subscriptions` VALUES (1,1,1,'Gold Plan','2026-01-01','2026-12-31','active'),(2,2,2,'Silver Plan','2026-02-01','2026-08-01','active');
/*!40000 ALTER TABLE `store_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('patient','doctor','agent','admin') DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Dr Emily Chen','emily.chen@hospital.com','pwd123','doctor','9123456789','2026-02-05 07:38:56'),(2,'Dr Ananya Rao','ananya.rao@hospital.com','pwd123','doctor','9876543211','2026-02-05 07:38:56'),(3,'Dr Vikram Patel','vikram.patel@hospital.com','pwd123','doctor','9988776655','2026-02-05 07:38:56'),(4,'Dr Meera Iyer','meera.iyer@hospital.com','pwd123','doctor','9090909090','2026-02-05 07:38:56'),(5,'Dr Rahul Sharma','rahul.sharma@hospital.com','pwd123','doctor','9012345678','2026-02-05 07:38:56'),(6,'Sarah Jenkins','sarah.jenkins@gmail.com','pwd123','patient','9876543210','2026-02-05 08:34:58'),(7,'Rahul Verma','rahul.verma@gmail.com','pwd123','patient','9123456789','2026-02-05 08:34:58'),(8,'Anita Kumar','anita.kumar@gmail.com','pwd123','patient','9988776655','2026-02-05 08:34:58'),(9,'Karthik R','karthik.r@gmail.com','pwd123','patient','9090909090','2026-02-05 08:34:58'),(10,'Rahul Kumar','rahul@gmail.com','hashed_pwd','patient','9876540001','2026-02-05 09:49:03');
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

-- Dump completed on 2026-02-16 21:06:49

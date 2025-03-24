-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: medical_app
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_name` varchar(100) NOT NULL,
  `patient_age` int NOT NULL,
  `patient_mobile` varchar(15) NOT NULL,
  `appointment_date` date NOT NULL,
  `doctor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,'sai',20,'7306329261','2025-03-28',2),(2,'dinesh',22,'8655895535','2025-03-31',2),(3,'surya',55,'8655895535','2025-03-29',13),(4,'surya',6,'7306329261','2025-04-18',1),(5,'dinesh',12,'7306329261','2025-03-28',1),(6,'Praveen',56,'9849645768','2025-03-15',1);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctorname` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` int NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `rating` float NOT NULL,
  `password` varchar(100) NOT NULL DEFAULT '123456',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Dr. Rajesh Kumar','Male',45,'Fungal Infection Specialist','Vizag',4.5,'123456'),(2,'Dr. Priya Sharma','Female',38,'Fungal Infection Specialist','Vizag',4.7,'123456'),(3,'Dr. Anil Reddy','Male',50,'Fungal Infection Specialist','Vizag',4.6,'123456'),(4,'Dr. Sunita Gupta','Female',42,'Hepatitis Specialist','Vizag',4.8,'123456'),(5,'Dr. Ramesh Patel','Male',47,'Hepatitis Specialist','Vizag',4.6,'123456'),(6,'Dr. Kavita Singh','Female',39,'Hepatitis Specialist','Vizag',4.9,'123456'),(7,'Dr. Vikram Rao','Male',44,'Hepatitis Specialist','Vizag',4.7,'123456'),(8,'Dr. Neha Desai','Female',37,'Hepatitis Specialist','Vizag',4.5,'123456'),(9,'Dr. Arjun Mehta','Male',49,'Hepatitis Specialist','Vizag',4.8,'123456'),(10,'Dr. Anjali Iyer','Female',46,'Liver Disease Specialist','Vizag',4.6,'123456'),(11,'Dr. Sanjay Verma','Male',51,'Liver Disease Specialist','Vizag',4.7,'123456'),(12,'Dr. Meera Nair','Female',40,'Liver Disease Specialist','Vizag',4.9,'123456'),(13,'Dr. Rahul Joshi','Male',48,'Tuberculosis Specialist','Vizag',4.8,'123456'),(14,'Dr. Sneha Kapoor','Female',36,'Tuberculosis Specialist','Vizag',4.7,'123456'),(15,'Dr. Karthik Menon','Male',43,'Tuberculosis Specialist','Vizag',4.6,'123456'),(16,'Dr. Ananya Das','Female',39,'General Physician','Vizag',4.5,'123456'),(17,'Dr. Rohit Malhotra','Male',44,'General Physician','Vizag',4.6,'123456'),(18,'Dr. Shalini Rao','Female',41,'General Physician','Vizag',4.7,'123456'),(19,'Dr. Deepak Choudhary','Male',47,'Pulmonologist','Vizag',4.8,'123456'),(20,'Dr. Nandini Sharma','Female',38,'Pulmonologist','Vizag',4.7,'123456'),(21,'Dr. Rajiv Kapoor','Male',50,'Pulmonologist','Vizag',4.9,'123456'),(22,'Dr. Anjali Reddy','Female',42,'Proctologist','Vizag',4.6,'123456'),(23,'Dr. Vikas Gupta','Male',45,'Proctologist','Vizag',4.7,'123456'),(24,'Dr. Priya Nair','Female',39,'Proctologist','Vizag',4.8,'123456'),(25,'Dr. Rajesh Iyer','Male',48,'Cardiologist','Vizag',4.9,'123456'),(26,'Dr. Sunita Rao','Female',44,'Cardiologist','Vizag',4.8,'123456'),(27,'Dr. Arjun Desai','Male',50,'Cardiologist','Vizag',4.7,'123456'),(28,'Dr. Kavita Patel','Female',41,'Vascular Surgeon','Vizag',4.6,'123456'),(29,'Dr. Ramesh Nair','Male',46,'Vascular Surgeon','Vizag',4.7,'123456'),(30,'Dr. Neha Kapoor','Female',39,'Vascular Surgeon','Vizag',4.8,'123456'),(31,'Dr. Anil Sharma','Male',47,'Endocrinologist','Vizag',4.7,'123456'),(32,'Dr. Priya Reddy','Female',42,'Endocrinologist','Vizag',4.8,'123456'),(33,'Dr. Rajiv Gupta','Male',49,'Endocrinologist','Vizag',4.6,'123456'),(34,'Dr. Sneha Iyer','Female',38,'Endocrinologist','Vizag',4.7,'123456'),(35,'Dr. Vikram Kapoor','Male',45,'Endocrinologist','Vizag',4.8,'123456'),(36,'Dr. Anjali Mehta','Female',43,'Endocrinologist','Vizag',4.9,'123456'),(37,'Dr. Rahul Rao','Male',46,'Endocrinologist','Vizag',4.6,'123456'),(38,'Dr. Nandini Patel','Female',40,'Endocrinologist','Vizag',4.7,'123456'),(39,'Dr. Karthik Sharma','Male',44,'Endocrinologist','Vizag',4.8,'123456'),(40,'Dr. Ananya Reddy','Female',42,'Orthopedic Surgeon','Vizag',4.7,'123456'),(41,'Dr. Rohit Gupta','Male',47,'Orthopedic Surgeon','Vizag',4.8,'123456'),(42,'Dr. Shalini Kapoor','Female',39,'Orthopedic Surgeon','Vizag',4.6,'123456'),(43,'Dr. Deepak Rao','Male',48,'Rheumatologist','Vizag',4.7,'123456'),(44,'Dr. Neha Sharma','Female',41,'Rheumatologist','Vizag',4.8,'123456'),(45,'Dr. Rajiv Patel','Male',45,'Rheumatologist','Vizag',4.9,'123456'),(46,'Dr. Anjali Kapoor','Female',43,'ENT Specialist','Vizag',4.6,'123456'),(47,'Dr. Vikas Reddy','Male',46,'ENT Specialist','Vizag',4.7,'123456'),(48,'Dr. Priya Iyer','Female',40,'ENT Specialist','Vizag',4.8,'123456'),(49,'Dr. Rahul Mehta','Male',44,'Dermatologist','Vizag',4.7,'123456'),(50,'Dr. Sneha Nair','Female',38,'Dermatologist','Vizag',4.8,'123456'),(51,'Dr. Karthik Rao','Male',42,'Dermatologist','Vizag',4.6,'123456'),(52,'Dr. Ananya Patel','Female',41,'Urologist','Vizag',4.7,'123456'),(53,'Dr. Rohit Sharma','Male',45,'Urologist','Vizag',4.8,'123456'),(54,'Dr. Shalini Gupta','Female',39,'Urologist','Vizag',4.9,'123456'),(55,'Dr. Deepak Kapoor','Male',47,'Dermatologist','Vizag',4.6,'123456'),(56,'Dr. Nandini Reddy','Female',42,'Dermatologist','Vizag',4.7,'123456'),(57,'Dr. Rajiv Iyer','Male',44,'Dermatologist','Vizag',4.8,'123456'),(58,'Dr. Anjali Sharma','Female',43,'Hepatitis Specialist','Vizag',4.7,'123456'),(59,'Dr. Vikram Patel','Male',46,'Hepatitis Specialist','Vizag',4.8,'123456'),(60,'Dr. Priya Rao','Female',40,'Hepatitis Specialist','Vizag',4.9,'123456'),(61,'Dr. Rahul Gupta','Male',44,'Hepatitis Specialist','Vizag',4.7,'123456'),(62,'Dr. Sneha Kapoor','Female',38,'Hepatitis Specialist','Vizag',4.8,'123456'),(63,'Dr. Karthik Reddy','Male',42,'Hepatitis Specialist','Vizag',4.6,'123456'),(64,'Dr. Ananya Mehta','Female',41,'Allergist','Vizag',4.7,'123456'),(65,'Dr. Rohit Nair','Male',45,'Allergist','Vizag',4.8,'123456'),(66,'Dr. Shalini Sharma','Female',39,'Allergist','Vizag',4.9,'123456'),(67,'Dr. Deepak Iyer','Male',47,'Hepatitis Specialist','Vizag',4.6,'123456'),(68,'Dr. Nandini Kapoor','Female',42,'Hepatitis Specialist','Vizag',4.7,'123456'),(69,'Dr. Rajiv Patel','Male',44,'Hepatitis Specialist','Vizag',4.8,'123456'),(70,'Dr. Anjali Rao','Female',43,'Gastroenterologist','Vizag',4.7,'123456'),(71,'Dr. Vikas Sharma','Male',46,'Gastroenterologist','Vizag',4.8,'123456'),(72,'Dr. Priya Gupta','Female',40,'Gastroenterologist','Vizag',4.9,'123456'),(73,'Dr. Rahul Reddy','Male',44,'Gastroenterologist','Vizag',4.7,'123456'),(74,'Dr. Sneha Iyer','Female',38,'Gastroenterologist','Vizag',4.8,'123456'),(75,'Dr. Karthik Kapoor','Male',42,'Gastroenterologist','Vizag',4.6,'123456'),(76,'Dr. Ananya Patel','Female',41,'Toxicologist','Vizag',4.7,'123456'),(77,'Dr. Rohit Sharma','Male',45,'Toxicologist','Vizag',4.8,'123456'),(78,'Dr. Shalini Gupta','Female',39,'Toxicologist','Vizag',4.9,'123456'),(79,'Dr. Deepak Kapoor','Male',47,'Gastroenterologist','Vizag',4.6,'123456'),(80,'Dr. Nandini Reddy','Female',42,'Gastroenterologist','Vizag',4.7,'123456'),(81,'Dr. Rajiv Iyer','Male',44,'Gastroenterologist','Vizag',4.8,'123456'),(82,'Dr. Anjali Sharma','Female',43,'Infectious Disease Specialist','Vizag',4.7,'123456'),(83,'Dr. Vikram Patel','Male',46,'Infectious Disease Specialist','Vizag',4.8,'123456'),(84,'Dr. Priya Rao','Female',40,'Infectious Disease Specialist','Vizag',4.9,'123456'),(85,'Dr. Rahul Gupta','Male',44,'Endocrinologist','Vizag',4.7,'123456'),(86,'Dr. Sneha Kapoor','Female',38,'Endocrinologist','Vizag',4.8,'123456'),(87,'Dr. Karthik Reddy','Male',42,'Endocrinologist','Vizag',4.6,'123456'),(88,'Dr. Ananya Mehta','Female',41,'Gastroenterologist','Vizag',4.7,'123456'),(89,'Dr. Rohit Nair','Male',45,'Gastroenterologist','Vizag',4.8,'123456'),(90,'Dr. Shalini Sharma','Female',39,'Gastroenterologist','Vizag',4.9,'123456'),(91,'Dr. Deepak Iyer','Male',47,'Pulmonologist','Vizag',4.6,'123456'),(92,'Dr. Nandini Kapoor','Female',42,'Pulmonologist','Vizag',4.7,'123456'),(93,'Dr. Rajiv Patel','Male',44,'Pulmonologist','Vizag',4.8,'123456'),(94,'Dr. Anjali Rao','Female',43,'Cardiologist','Vizag',4.7,'123456'),(95,'Dr. Vikas Sharma','Male',46,'Cardiologist','Vizag',4.8,'123456'),(96,'Dr. Priya Gupta','Female',40,'Cardiologist','Vizag',4.9,'123456'),(97,'Dr. Rahul Reddy','Male',44,'Neurologist','Vizag',4.7,'123456'),(98,'Dr. Sneha Iyer','Female',38,'Neurologist','Vizag',4.8,'123456'),(99,'Dr. Karthik Kapoor','Male',42,'Neurologist','Vizag',4.6,'123456'),(100,'Dr. Ananya Patel','Female',41,'Orthopedic Surgeon','Vizag',4.7,'123456'),(101,'Dr. Rohit Sharma','Male',45,'Orthopedic Surgeon','Vizag',4.8,'123456'),(102,'Dr. Shalini Gupta','Female',39,'Orthopedic Surgeon','Vizag',4.9,'123456'),(103,'Dr. Deepak Kapoor','Male',47,'Neurologist','Vizag',4.6,'123456'),(104,'Dr. Nandini Reddy','Female',42,'Neurologist','Vizag',4.7,'123456'),(105,'Dr. Rajiv Iyer','Male',44,'Neurologist','Vizag',4.8,'123456'),(106,'Dr. Anjali Sharma','Female',43,'Hepatologist','Vizag',4.7,'123456'),(107,'Dr. Vikram Patel','Male',46,'Hepatologist','Vizag',4.8,'123456'),(108,'Dr. Priya Rao','Female',40,'Hepatologist','Vizag',4.9,'123456'),(109,'Dr. Rahul Gupta','Male',44,'Infectious Disease Specialist','Vizag',4.7,'123456'),(110,'Dr. Sneha Kapoor','Female',38,'Infectious Disease Specialist','Vizag',4.8,'123456'),(111,'Dr. Karthik Reddy','Male',42,'Infectious Disease Specialist','Vizag',4.6,'123456'),(112,'Dr. Ananya Mehta','Female',41,'Infectious Disease Specialist','Vizag',4.7,'123456'),(113,'Dr. Rohit Nair','Male',45,'Infectious Disease Specialist','Vizag',4.8,'123456'),(114,'Dr. Shalini Sharma','Female',39,'Infectious Disease Specialist','Vizag',4.9,'123456'),(115,'Dr. Deepak Iyer','Male',47,'Infectious Disease Specialist','Vizag',4.6,'123456'),(116,'Dr. Nandini Kapoor','Female',42,'Infectious Disease Specialist','Vizag',4.7,'123456'),(117,'Dr. Rajiv Patel','Male',44,'Infectious Disease Specialist','Vizag',4.8,'123456'),(118,'Dr. Anjali Rao','Female',43,'Infectious Disease Specialist','Vizag',4.7,'123456'),(119,'Dr. Vikas Sharma','Male',46,'Infectious Disease Specialist','Vizag',4.8,'123456'),(120,'Dr. Priya Gupta','Female',40,'Infectious Disease Specialist','Vizag',4.9,'123456'),(121,'Dr. Rahul Reddy','Male',44,'Dermatologist','Vizag',4.7,'123456'),(122,'Dr. Sneha Iyer','Female',38,'Dermatologist','Vizag',4.8,'123456'),(123,'Dr. Karthik Kapoor','Male',42,'Dermatologist','Vizag',4.6,'123456'),(124,'Dr.Naidu','Male',55,'ENT','vizag',5,'123456'),(125,'Dr.Naidu','Male',55,'ENT','hyderabad',5,'23'),(126,'rakesh','Male',55,'General  Phy','vizianagaram',5,'123456');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'saikiran','pudisaikiran27@gmail.com','123456'),(2,'rakesh','Somireddysaikiran369@gmail.com','23456'),(3,'akshith','p3506450@gmail.com','25896');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-24 20:25:07

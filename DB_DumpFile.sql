-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: employee
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `EmployeeId` int NOT NULL,
  `Line1` varchar(200) DEFAULT NULL,
  `Line2` varchar(200) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `TLine1` varchar(200) DEFAULT NULL,
  `TLine2` varchar(200) DEFAULT NULL,
  `TCity` varchar(50) DEFAULT NULL,
  `TState` varchar(50) DEFAULT NULL,
  `TPostalCode` varchar(10) DEFAULT NULL,
  `TCountry` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`EmployeeId`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (34,'ABC','XYZ','Ucity','Ustate','Ustate','Ucountry',NULL,NULL,NULL,NULL,NULL,NULL),(35,'C1','C1','HK','CS','CS','China','null','null','null','null','null','null'),(37,'MMM','NNN','CCC','OOO','OOO','US','MMM T','NNN T','CCC T','OOO T','562105','US T'),(42,'Mysuru Nagara','','Mysore','Karnataka','562125','India','Mysuru Nagara','','Mysore','Karnataka','562125','India'),(43,'thane village, shidlaghatta Tq, Chikkaballapur dist','','Bangalore','Karnataka','562125','India','thane village, shidlaghatta Tq, Chikkaballapur dist','','Bangalore','Karnataka','562125','India'),(44,'aaaaaa','','aaaaaaaaa','aaaaaaaaaaaa','1111111','aaaaaaaaa','aaaaaa','','aaaaaaaaa','aaaaaaaaaaaa','1111111','aaaaaaaaa');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `AttendanceID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `CheckInTime` time DEFAULT NULL,
  `CheckOutTime` time DEFAULT NULL,
  `Remarks` varchar(150) DEFAULT NULL,
  `IsButtonClicked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`AttendanceID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (52,16,'2024-06-26','13:24:12','15:00:00',NULL,0),(53,16,'2024-06-25','10:00:00','18:00:00',NULL,0),(54,17,'2024-06-26','17:07:45','17:07:53',NULL,0),(55,17,'2024-06-25',NULL,NULL,NULL,0),(56,17,'2024-06-25','10:00:00','17:30:00',NULL,1),(57,17,'2024-06-27','10:35:39','16:40:00',NULL,1),(58,18,'2024-06-26',NULL,NULL,'Not Logged In',0),(59,19,'2024-06-26',NULL,NULL,'Not Logged In',0),(60,20,'2024-06-26',NULL,NULL,'Not Logged In',0),(61,21,'2024-06-26',NULL,NULL,'Not Logged In',0),(63,23,'2024-06-26',NULL,NULL,'Not Logged In',0),(65,16,'2024-06-27',NULL,NULL,'Not Logged In',0),(66,18,'2024-06-27',NULL,NULL,'Not Logged In',0),(67,19,'2024-06-27',NULL,NULL,'Not Logged In',0),(68,20,'2024-06-27',NULL,NULL,'Not Logged In',0),(69,21,'2024-06-27',NULL,NULL,'Not Logged In',0),(71,23,'2024-06-27',NULL,NULL,'Not Logged In',0),(72,16,'2024-06-28','17:57:24',NULL,NULL,0),(73,17,'2024-06-28',NULL,NULL,'Not Logged In',0),(74,18,'2024-06-28',NULL,NULL,'Not Logged In',0),(75,19,'2024-06-28',NULL,NULL,'Not Logged In',0),(76,20,'2024-06-28',NULL,NULL,'Not Logged In',0),(77,21,'2024-06-28',NULL,NULL,'Not Logged In',0),(79,23,'2024-06-28',NULL,NULL,'Not Logged In',0),(80,16,'2024-06-29',NULL,NULL,'Weekend',0),(81,17,'2024-06-29',NULL,NULL,'Weekend',0),(82,18,'2024-06-29',NULL,NULL,'Weekend',0),(83,19,'2024-06-29',NULL,NULL,'Weekend',0),(84,20,'2024-06-29',NULL,NULL,'Weekend',0),(85,21,'2024-06-29',NULL,NULL,'Weekend',0),(87,23,'2024-06-29',NULL,NULL,'Weekend',0),(95,16,'2024-06-30',NULL,NULL,'Weekend',0),(96,17,'2024-06-30',NULL,NULL,'Weekend',0),(97,18,'2024-06-30',NULL,NULL,'Weekend',0),(98,19,'2024-06-30',NULL,NULL,'Weekend',0),(99,20,'2024-06-30',NULL,NULL,'Weekend',0),(100,21,'2024-06-30',NULL,NULL,'Weekend',0),(102,23,'2024-06-30',NULL,NULL,'Weekend',0),(103,16,'2024-07-01','10:00:00','18:37:34','Not Logged In',1),(104,17,'2024-07-01','10:00:00','17:00:00','Not Logged In',1),(105,18,'2024-07-01','10:00:00','17:00:00','-',1),(106,19,'2024-07-01',NULL,NULL,'Not Logged In',0),(107,20,'2024-07-01',NULL,NULL,'Not Logged In',0),(108,21,'2024-07-01',NULL,NULL,'Not Logged In',0),(110,23,'2024-07-01',NULL,NULL,'Not Logged In',0),(118,16,'2024-07-02','16:36:20','16:36:25',NULL,0),(119,17,'2024-07-02',NULL,NULL,'Not Logged In',1),(120,18,'2024-07-02','10:00:00','15:00:00','-',1),(121,19,'2024-07-02',NULL,NULL,'Not Logged In',0),(122,20,'2024-07-02',NULL,NULL,'Not Logged In',0),(123,21,'2024-07-02',NULL,NULL,'Not Logged In',0),(125,23,'2024-07-02',NULL,NULL,'Not Logged In',0),(126,26,'2024-07-02',NULL,NULL,'Not Logged In',0),(127,28,'2024-07-02',NULL,NULL,'Not Logged In',0),(134,16,'2024-07-03','10:00:00','17:00:00','-',1),(135,17,'2024-07-03',NULL,NULL,'Not Logged In',0),(136,18,'2024-07-03',NULL,NULL,'Not Logged In',0),(137,19,'2024-07-03',NULL,NULL,'Not Logged In',0),(138,20,'2024-07-03',NULL,NULL,'Not Logged In',0),(139,21,'2024-07-03',NULL,NULL,'Not Logged In',0),(141,23,'2024-07-03',NULL,NULL,'Not Logged In',0),(142,26,'2024-07-03',NULL,NULL,'Not Logged In',0),(143,28,'2024-07-03',NULL,NULL,'Not Logged In',0),(149,16,'2024-07-04',NULL,NULL,'Not Logged In',0),(150,17,'2024-07-04',NULL,NULL,'Leave',0),(151,18,'2024-07-04',NULL,NULL,'Not Logged In',0),(152,19,'2024-07-04',NULL,NULL,'Not Logged In',0),(153,20,'2024-07-04',NULL,NULL,'Not Logged In',0),(154,21,'2024-07-04',NULL,NULL,'Not Logged In',0),(156,23,'2024-07-04',NULL,NULL,'Not Logged In',0),(157,26,'2024-07-04',NULL,NULL,'Not Logged In',0),(158,28,'2024-07-04',NULL,NULL,'Not Logged In',0),(164,16,'2024-07-05',NULL,NULL,'Not Logged In',0),(165,17,'2024-07-05',NULL,NULL,'Leave',0),(166,18,'2024-07-05',NULL,NULL,'Leave',0),(167,19,'2024-07-05',NULL,NULL,'Not Logged In',0),(168,20,'2024-07-05',NULL,NULL,'Not Logged In',0),(169,21,'2024-07-05',NULL,NULL,'Not Logged In',0),(171,23,'2024-07-05',NULL,NULL,'Not Logged In',0),(172,26,'2024-07-05',NULL,NULL,'Not Logged In',0),(173,28,'2024-07-05',NULL,NULL,'Not Logged In',0),(179,16,'2024-07-06',NULL,NULL,'Weekend',0),(180,17,'2024-07-06',NULL,NULL,'Weekend',0),(181,18,'2024-07-06',NULL,NULL,'Weekend',0),(182,19,'2024-07-06',NULL,NULL,'Weekend',0),(183,20,'2024-07-06',NULL,NULL,'Weekend',0),(184,21,'2024-07-06',NULL,NULL,'Weekend',0),(186,23,'2024-07-06',NULL,NULL,'Weekend',0),(187,26,'2024-07-06',NULL,NULL,'Weekend',0),(188,28,'2024-07-06',NULL,NULL,'Weekend',0),(194,16,'2024-07-07',NULL,NULL,'Weekend',0),(195,17,'2024-07-07',NULL,NULL,'Weekend',0),(196,18,'2024-07-07',NULL,NULL,'Weekend',0),(197,19,'2024-07-07',NULL,NULL,'Weekend',0),(198,20,'2024-07-07',NULL,NULL,'Weekend',0),(199,21,'2024-07-07',NULL,NULL,'Weekend',0),(201,23,'2024-07-07',NULL,NULL,'Weekend',0),(202,26,'2024-07-07',NULL,NULL,'Weekend',0),(203,28,'2024-07-07',NULL,NULL,'Weekend',0),(210,17,'2024-07-08',NULL,NULL,'Leave',0),(211,18,'2024-07-08',NULL,NULL,'Not Logged In',0),(212,19,'2024-07-08',NULL,NULL,'Not Logged In',0),(213,20,'2024-07-08',NULL,NULL,'Not Logged In',0),(214,21,'2024-07-08',NULL,NULL,'Not Logged In',0),(216,23,'2024-07-08',NULL,NULL,'Not Logged In',0),(217,26,'2024-07-08',NULL,NULL,'Not Logged In',0),(218,28,'2024-07-08',NULL,NULL,'Not Logged In',0),(220,17,'2024-07-10',NULL,NULL,'Not Logged In',0),(221,18,'2024-07-10',NULL,NULL,'Not Logged In',0),(222,19,'2024-07-10',NULL,NULL,'Not Logged In',0),(223,20,'2024-07-10',NULL,NULL,'Not Logged In',0),(224,21,'2024-07-10',NULL,NULL,'Not Logged In',0),(226,23,'2024-07-10',NULL,NULL,'Not Logged In',0),(227,26,'2024-07-10',NULL,NULL,'Not Logged In',0),(228,28,'2024-07-10',NULL,NULL,'Not Logged In',0),(234,16,'2024-07-12','10:00:00','17:00:00',NULL,0),(235,16,'2024-07-11','10:15:00','18:10:00',NULL,0),(236,16,'2024-07-10','09:30:30','18:45:27',NULL,0),(237,16,'2024-07-09','11:12:41','17:23:53',NULL,0),(238,16,'2024-07-08','10:02:31','17:37:13',NULL,0),(239,17,'2024-07-12',NULL,NULL,'Not Logged In',0),(240,18,'2024-07-12',NULL,NULL,'Not Logged In',0),(241,19,'2024-07-12',NULL,NULL,'Not Logged In',0),(242,20,'2024-07-12',NULL,NULL,'Not Logged In',0),(243,21,'2024-07-12',NULL,NULL,'Not Logged In',0),(245,23,'2024-07-12',NULL,NULL,'Not Logged In',0),(246,26,'2024-07-12',NULL,NULL,'Not Logged In',0),(247,28,'2024-07-12',NULL,NULL,'Not Logged In',0),(254,16,'2024-07-14',NULL,NULL,'Weekend',0),(255,17,'2024-07-14',NULL,NULL,'Weekend',0),(256,18,'2024-07-14',NULL,NULL,'Weekend',0),(257,19,'2024-07-14',NULL,NULL,'Weekend',0),(258,20,'2024-07-14',NULL,NULL,'Weekend',0),(259,21,'2024-07-14',NULL,NULL,'Weekend',0),(261,23,'2024-07-14',NULL,NULL,'Weekend',0),(262,26,'2024-07-14',NULL,NULL,'Weekend',0),(263,28,'2024-07-14',NULL,NULL,'Weekend',0),(269,16,'2024-07-16','16:44:38','16:44:55',NULL,0),(270,16,'2024-07-17','14:07:50',NULL,NULL,0),(271,17,'2024-07-16',NULL,NULL,'Leave',0),(272,18,'2024-07-16',NULL,NULL,'Not Logged In',1),(273,19,'2024-07-16',NULL,NULL,'Not Logged In',0),(274,20,'2024-07-16',NULL,NULL,'Not Logged In',0),(275,21,'2024-07-16',NULL,NULL,'Not Logged In',0),(277,23,'2024-07-16',NULL,NULL,'Not Logged In',0),(278,26,'2024-07-16',NULL,NULL,'Not Logged In',0),(279,28,'2024-07-16',NULL,NULL,'Not Logged In',0),(286,16,'2024-07-23',NULL,NULL,'Not Logged In',0),(287,17,'2024-07-23',NULL,NULL,'Leave',0),(288,18,'2024-07-23',NULL,NULL,'Not Logged In',0),(289,19,'2024-07-23',NULL,NULL,'Not Logged In',0),(290,20,'2024-07-23',NULL,NULL,'Not Logged In',0),(291,21,'2024-07-23',NULL,NULL,'Not Logged In',0),(293,23,'2024-07-23',NULL,NULL,'Not Logged In',0),(294,26,'2024-07-23',NULL,NULL,'Not Logged In',0),(295,28,'2024-07-23',NULL,NULL,'Not Logged In',0),(296,34,'2024-07-23',NULL,NULL,'Not Logged In',0),(297,35,'2024-07-23',NULL,NULL,'Not Logged In',0),(298,37,'2024-07-23',NULL,NULL,'Not Logged In',0),(301,42,'2024-07-26','10:29:40','18:36:31','-',1),(302,19,'2024-07-26','10:42:24','18:42:41','-',1),(303,16,'2024-07-25',NULL,NULL,'Not Logged In',0),(304,17,'2024-07-25',NULL,NULL,'Not Logged In',0),(305,18,'2024-07-25',NULL,NULL,'Not Logged In',0),(306,19,'2024-07-25','10:00:00','19:00:00','-',1),(307,20,'2024-07-25',NULL,NULL,'Not Logged In',0),(308,21,'2024-07-25',NULL,NULL,'Not Logged In',0),(309,23,'2024-07-25',NULL,NULL,'Not Logged In',0),(310,26,'2024-07-25',NULL,NULL,'Not Logged In',0),(311,28,'2024-07-25',NULL,NULL,'Not Logged In',0),(312,34,'2024-07-25',NULL,NULL,'Not Logged In',0),(313,35,'2024-07-25',NULL,NULL,'Not Logged In',0),(314,37,'2024-07-25',NULL,NULL,'Not Logged In',0),(315,42,'2024-07-25',NULL,NULL,'Not Logged In',0),(318,16,'2024-07-26','10:30:24','18:00:00','-',1),(319,19,'2024-07-30','16:51:39',NULL,NULL,0),(320,16,'2024-07-30',NULL,NULL,'Not Logged In',0),(321,17,'2024-07-30',NULL,NULL,'Not Logged In',0),(322,18,'2024-07-30',NULL,NULL,'Not Logged In',0),(323,20,'2024-07-30',NULL,NULL,'Not Logged In',0),(324,21,'2024-07-30',NULL,NULL,'Not Logged In',0),(325,23,'2024-07-30',NULL,NULL,'Not Logged In',0),(326,26,'2024-07-30',NULL,NULL,'Not Logged In',0),(327,28,'2024-07-30',NULL,NULL,'Not Logged In',0),(328,34,'2024-07-30',NULL,NULL,'Leave',0),(329,35,'2024-07-30',NULL,NULL,'Not Logged In',0),(330,37,'2024-07-30',NULL,NULL,'Not Logged In',0),(331,42,'2024-07-30',NULL,NULL,'Not Logged In',0),(335,16,'2024-08-05',NULL,NULL,'Not Logged In',0),(336,17,'2024-08-05',NULL,NULL,'Not Logged In',0),(337,18,'2024-08-05',NULL,NULL,'Not Logged In',0),(338,19,'2024-08-05',NULL,NULL,'Not Logged In',0),(339,20,'2024-08-05',NULL,NULL,'Not Logged In',0),(340,21,'2024-08-05',NULL,NULL,'Not Logged In',0),(341,23,'2024-08-05',NULL,NULL,'Not Logged In',0),(342,26,'2024-08-05',NULL,NULL,'Not Logged In',0),(343,28,'2024-08-05',NULL,NULL,'Not Logged In',0),(344,34,'2024-08-05',NULL,NULL,'Not Logged In',0),(345,35,'2024-08-05',NULL,NULL,'Not Logged In',0),(346,37,'2024-08-05',NULL,NULL,'Not Logged In',0),(347,42,'2024-08-05',NULL,NULL,'Not Logged In',0),(348,43,'2024-08-05',NULL,NULL,'Not Logged In',0),(349,44,'2024-08-05',NULL,NULL,'Not Logged In',0),(350,19,'2024-08-09','20:21:18','20:27:10',NULL,0),(351,16,'2024-08-11',NULL,NULL,'Weekend',0),(352,17,'2024-08-11',NULL,NULL,'Weekend',0),(353,18,'2024-08-11',NULL,NULL,'Weekend',0),(354,19,'2024-08-11',NULL,NULL,'Weekend',0),(355,20,'2024-08-11',NULL,NULL,'Weekend',0),(356,21,'2024-08-11',NULL,NULL,'Weekend',0),(357,23,'2024-08-11',NULL,NULL,'Weekend',0),(358,26,'2024-08-11',NULL,NULL,'Weekend',0),(359,28,'2024-08-11',NULL,NULL,'Weekend',0),(360,34,'2024-08-11',NULL,NULL,'Weekend',0),(361,35,'2024-08-11',NULL,NULL,'Weekend',0),(362,37,'2024-08-11',NULL,NULL,'Weekend',0),(363,42,'2024-08-11',NULL,NULL,'Weekend',0),(364,43,'2024-08-11',NULL,NULL,'Weekend',0),(365,44,'2024-08-11',NULL,NULL,'Weekend',0),(366,16,'2024-08-14',NULL,NULL,'Not Logged In',0),(367,17,'2024-08-14',NULL,NULL,'Not Logged In',0),(368,18,'2024-08-14',NULL,NULL,'Not Logged In',0),(369,19,'2024-08-14',NULL,NULL,'Leave',0),(370,20,'2024-08-14',NULL,NULL,'Not Logged In',0),(371,21,'2024-08-14',NULL,NULL,'Not Logged In',0),(372,23,'2024-08-14',NULL,NULL,'Not Logged In',0),(373,26,'2024-08-14',NULL,NULL,'Not Logged In',0),(374,28,'2024-08-14',NULL,NULL,'Not Logged In',0),(375,34,'2024-08-14',NULL,NULL,'Not Logged In',0),(376,35,'2024-08-14',NULL,NULL,'Not Logged In',0),(377,37,'2024-08-14',NULL,NULL,'Leave',0),(378,42,'2024-08-14',NULL,NULL,'Not Logged In',0),(379,43,'2024-08-14',NULL,NULL,'Leave',0),(380,44,'2024-08-14',NULL,NULL,'Leave',0),(381,16,'2024-08-19',NULL,NULL,'Not Logged In',0),(382,17,'2024-08-19',NULL,NULL,'Not Logged In',0),(383,18,'2024-08-19',NULL,NULL,'Not Logged In',0),(384,19,'2024-08-19',NULL,NULL,'Not Logged In',0),(385,20,'2024-08-19',NULL,NULL,'Not Logged In',0),(386,21,'2024-08-19',NULL,NULL,'Not Logged In',0),(387,23,'2024-08-19',NULL,NULL,'Not Logged In',0),(388,26,'2024-08-19',NULL,NULL,'Not Logged In',0),(389,28,'2024-08-19',NULL,NULL,'Not Logged In',0),(390,34,'2024-08-19',NULL,NULL,'Not Logged In',0),(391,35,'2024-08-19',NULL,NULL,'Not Logged In',0),(392,37,'2024-08-19',NULL,NULL,'Leave',0),(393,42,'2024-08-19',NULL,NULL,'Not Logged In',0),(394,43,'2024-08-19',NULL,NULL,'Not Logged In',0),(395,44,'2024-08-19',NULL,NULL,'Not Logged In',0),(396,16,'2024-08-22',NULL,NULL,'Not Logged In',0),(397,17,'2024-08-22',NULL,NULL,'Not Logged In',0),(398,18,'2024-08-22',NULL,NULL,'Not Logged In',0),(399,19,'2024-08-22',NULL,NULL,'Not Logged In',0),(400,20,'2024-08-22',NULL,NULL,'Not Logged In',0),(401,21,'2024-08-22',NULL,NULL,'Not Logged In',0),(402,23,'2024-08-22',NULL,NULL,'Not Logged In',0),(403,26,'2024-08-22',NULL,NULL,'Not Logged In',0),(404,28,'2024-08-22',NULL,NULL,'Not Logged In',0),(405,34,'2024-08-22',NULL,NULL,'Not Logged In',0),(406,35,'2024-08-22',NULL,NULL,'Not Logged In',0),(407,37,'2024-08-22',NULL,NULL,'Leave',0),(408,42,'2024-08-22',NULL,NULL,'Not Logged In',0),(409,43,'2024-08-22',NULL,NULL,'Not Logged In',0),(410,44,'2024-08-22',NULL,NULL,'Not Logged In',0),(411,16,'2024-09-02',NULL,NULL,'Not Logged In',0),(412,17,'2024-09-02',NULL,NULL,'Not Logged In',0),(413,18,'2024-09-02',NULL,NULL,'Not Logged In',0),(414,19,'2024-09-02',NULL,NULL,'Not Logged In',0),(415,20,'2024-09-02',NULL,NULL,'Not Logged In',0),(416,21,'2024-09-02',NULL,NULL,'Not Logged In',0),(417,23,'2024-09-02',NULL,NULL,'Not Logged In',0),(418,26,'2024-09-02',NULL,NULL,'Not Logged In',0),(419,28,'2024-09-02',NULL,NULL,'Not Logged In',0),(420,34,'2024-09-02',NULL,NULL,'Not Logged In',0),(421,35,'2024-09-02',NULL,NULL,'Not Logged In',0),(422,37,'2024-09-02',NULL,NULL,'Not Logged In',0),(423,42,'2024-09-02',NULL,NULL,'Not Logged In',0),(424,43,'2024-09-02',NULL,NULL,'Not Logged In',0),(425,44,'2024-09-02',NULL,NULL,'Not Logged In',0),(426,16,'2024-09-05',NULL,NULL,'Not Logged In',0),(427,17,'2024-09-05',NULL,NULL,'Not Logged In',0),(428,18,'2024-09-05',NULL,NULL,'Not Logged In',0),(429,19,'2024-09-05',NULL,NULL,'Not Logged In',0),(430,20,'2024-09-05',NULL,NULL,'Not Logged In',0),(431,21,'2024-09-05',NULL,NULL,'Not Logged In',0),(432,23,'2024-09-05',NULL,NULL,'Not Logged In',0),(433,26,'2024-09-05',NULL,NULL,'Not Logged In',0),(434,28,'2024-09-05',NULL,NULL,'Not Logged In',0),(435,34,'2024-09-05',NULL,NULL,'Not Logged In',0),(436,35,'2024-09-05',NULL,NULL,'Not Logged In',0),(437,37,'2024-09-05',NULL,NULL,'Not Logged In',0),(438,42,'2024-09-05',NULL,NULL,'Not Logged In',0),(439,43,'2024-09-05',NULL,NULL,'Not Logged In',0),(440,44,'2024-09-05',NULL,NULL,'Not Logged In',0),(441,16,'2024-09-10',NULL,NULL,'Not Logged In',0),(442,17,'2024-09-10',NULL,NULL,'Not Logged In',0),(443,18,'2024-09-10',NULL,NULL,'Not Logged In',0),(444,19,'2024-09-10',NULL,NULL,'Not Logged In',0),(445,20,'2024-09-10',NULL,NULL,'Not Logged In',0),(446,21,'2024-09-10',NULL,NULL,'Not Logged In',0),(447,23,'2024-09-10',NULL,NULL,'Not Logged In',0),(448,26,'2024-09-10',NULL,NULL,'Not Logged In',0),(449,28,'2024-09-10',NULL,NULL,'Not Logged In',0),(450,34,'2024-09-10',NULL,NULL,'Not Logged In',0),(451,35,'2024-09-10',NULL,NULL,'Not Logged In',0),(452,37,'2024-09-10',NULL,NULL,'Not Logged In',0),(453,42,'2024-09-10',NULL,NULL,'Not Logged In',0),(454,43,'2024-09-10',NULL,NULL,'Not Logged In',0),(455,44,'2024-09-10',NULL,NULL,'Not Logged In',0),(456,16,'2024-09-22',NULL,NULL,'Weekend',0),(457,17,'2024-09-22',NULL,NULL,'Weekend',0),(458,18,'2024-09-22',NULL,NULL,'Weekend',0),(459,19,'2024-09-22',NULL,NULL,'Weekend',0),(460,20,'2024-09-22',NULL,NULL,'Weekend',0),(461,21,'2024-09-22',NULL,NULL,'Weekend',0),(462,23,'2024-09-22',NULL,NULL,'Weekend',0),(463,26,'2024-09-22',NULL,NULL,'Weekend',0),(464,28,'2024-09-22',NULL,NULL,'Weekend',0),(465,34,'2024-09-22',NULL,NULL,'Weekend',0),(466,35,'2024-09-22',NULL,NULL,'Weekend',0),(467,37,'2024-09-22',NULL,NULL,'Weekend',0),(468,42,'2024-09-22',NULL,NULL,'Weekend',0),(469,43,'2024-09-22',NULL,NULL,'Weekend',0),(470,44,'2024-09-22',NULL,NULL,'Weekend',0);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendanceupdate`
--

DROP TABLE IF EXISTS `attendanceupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendanceupdate` (
  `AttendanceId` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Date` date NOT NULL,
  `CheckInTime` time DEFAULT NULL,
  `CheckOutTime` time DEFAULT NULL,
  `EmployeeId` int DEFAULT NULL,
  PRIMARY KEY (`AttendanceId`),
  KEY `attendanceupdate_ibfk_1` (`EmployeeId`),
  CONSTRAINT `attendanceupdate_ibfk_1` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendanceupdate`
--

LOCK TABLES `attendanceupdate` WRITE;
/*!40000 ALTER TABLE `attendanceupdate` DISABLE KEYS */;
INSERT INTO `attendanceupdate` VALUES (119,'Rushal Premanand','2024-07-02','11:30:00','18:00:00',17),(272,'Ananth  Kumar ','2024-07-16','10:00:00','17:00:00',18);
/*!40000 ALTER TABLE `attendanceupdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `PersonalEmail` varchar(100) DEFAULT NULL,
  `PersonalMobile` varchar(15) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `RoleID` int DEFAULT NULL,
  `maritalstatus` varchar(20) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `EmergencyMobile` varchar(10) DEFAULT NULL,
  `EmergencyName` varchar(20) DEFAULT NULL,
  `bloodGroup` varchar(15) DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT '1',
  `Nationality` varchar(50) DEFAULT NULL,
  `PersonalHome` varchar(15) DEFAULT NULL,
  `EmergencyRelation` varchar(150) DEFAULT NULL,
  `WorkEmail` varchar(100) DEFAULT NULL,
  `JobLocation` varchar(150) DEFAULT NULL,
  `empno` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `Email` (`PersonalEmail`),
  UNIQUE KEY `empno` (`empno`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (16,'Suresh','Babbu','1980-01-01','suresh@gmail.com','9080706050','2017-05-26',1,'Married','Male','9988776655','Mother','A Positive',1,NULL,NULL,NULL,NULL,NULL,'EMV01'),(17,'Rushal','Premanand','2001-02-12','rushal1218prem@gmail.com','9176009764','2023-10-11',2,'Married','','9012543789','Premanand','',1,NULL,NULL,NULL,NULL,NULL,'EMV02'),(18,'Ananth ','Kumar ','2000-06-04','ananthtd234@gmail.com','7892869519','2023-10-11',2,'Single','Male','1234567890','Ananth Jr','B +ve',1,'Indian','null','borther hood','abcd@gmail.com','HSR Layout','EMV03'),(19,'Sagar','H','1996-12-11','hejajisagar@gmail.com','7349101964','2023-10-11',5,'Single','Male','1928374650','Ragas','O Positive',1,NULL,NULL,NULL,NULL,NULL,'EMV04'),(20,'Jayasree','C','2000-01-07','cjayasree01@gmail.com','77999374544','2023-10-11',4,'Single','Female','8877991122','SreeJaya','AB -ve',1,'Indian','8969545463','sis','abcd@gmail.com','Electronic City','EMV05'),(21,'Prabhu','Sundaram','1980-01-01','prabhu@gmail.com','9080706050','2008-06-27',3,'Married','Male','7080905867','Sundar','AB Positive',1,NULL,NULL,NULL,NULL,NULL,'EMV06'),(23,'Manager','MGR','2024-06-01','manager@gmail.com','9192939495','2024-06-06',3,'Single','Others','9911882277','CEO','O Negative',1,NULL,NULL,NULL,NULL,NULL,'EMV07'),(26,'Ajay','Kumar','2000-07-04','awsde@gmail.com','1234567111','2024-07-02',4,'Single','Male','9988776655','ccccc','A Negative',1,NULL,NULL,NULL,NULL,NULL,'EMV08'),(28,'A','B','2024-07-02','asd@gmail.com','9080706050','2024-07-03',2,'Single','Male','9988776655','ccccc','B Positive',1,NULL,NULL,NULL,NULL,NULL,'EMV09'),(34,'Test','User','2024-07-19','testabc@gmail.com','1234567890','2024-07-19',2,'Married','Single','7897897989','TestEmergency','A +ve',1,'Unknown','1234567890','TestRelation','workabc@gmail.com','Ulocation','EMV10'),(35,'Jackie','Chan','2024-07-10','Jackie@gmail.com','1111111111','2024-07-20',4,'Married','','8888888888','Jamie','B +ve',1,'China','2222222222','Friend','chan@gmail.com','China','EMV11'),(37,'Adam','Levine','2024-06-30','adam@gmail.com','1111111111','2024-07-31',5,'Married','','6666666666','Camila','AB +ve',1,'American','123332132321','Wife','adamwork@gmail.com','Paris','EMV12'),(42,'Ramesh','Kumar','1992-07-16','ramesh@gmail.com','8855674819','2024-03-13',5,'Married','Male','7685673919','Anthamma','A -ve',1,'India','','borther hood','abc@gmail.com','Bengaluru',NULL),(43,'Santosh','reddy','1994-04-07','san@gmail.com','8869747281','2024-02-14',6,'Married','Male','9980765828','Thamma','AB -ve',1,'Indian','','bro','work@gmail.com','Bengaluru','EMV14'),(44,'Ram','sri','1998-04-16','ram@gmail.com','1111111','2024-01-03',2,'Married','Male','1111111111','aaaaaaaaa','O +ve',1,'India','','aaaaaaaaaaa','ram@gmail.com','aaaaaa',NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holidays` (
  `holidayid` int NOT NULL AUTO_INCREMENT,
  `holidayDate` date DEFAULT NULL,
  `holidayName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`holidayid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (16,'2024-01-15','Pongal/Sankranthi'),(17,'2024-01-26','Republic Day'),(18,'2024-04-11','Ramzan/Eid'),(19,'2024-05-01','May Day'),(20,'2024-08-15','Independence Day'),(21,'2024-10-02','Gandhi Jayanthi'),(22,'2024-10-31','Diwali'),(23,'2024-11-01','Kannada Rajyotsava'),(30,'2024-01-01','New Year'),(31,'2024-12-25','Christmas Day');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaves` (
  `LeaveID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `LeaveType` varchar(50) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `LeaveStatus` varchar(20) DEFAULT NULL,
  `AppliedDate` date DEFAULT NULL,
  `ApprovedDate` date DEFAULT NULL,
  `ApprovedBy` int DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `rejectReason` varchar(500) DEFAULT NULL,
  `TotalDays` int DEFAULT NULL,
  PRIMARY KEY (`LeaveID`),
  KEY `EmployeeID` (`EmployeeID`),
  KEY `ApprovedBy` (`ApprovedBy`),
  CONSTRAINT `leaves_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE,
  CONSTRAINT `leaves_ibfk_2` FOREIGN KEY (`ApprovedBy`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (39,17,'Casual Leave','2024-07-03','2024-07-03','Rejected','2024-07-02','2024-07-02',16,'testing','a',1),(40,17,'Sick Leave','2024-07-04','2024-07-04','Rejected','2024-07-02','2024-07-02',16,'Sick','dfgdhfjk',1),(45,17,'Casual Leave','2024-07-03','2024-07-03','Rejected','2024-07-03','2024-07-03',16,'casual','Not Approved\r\n',1),(48,17,'Casual Leave','2024-07-04','2024-07-04','Cancelled','2024-07-03','2024-07-03',16,'Casual',NULL,1),(50,17,'Casual Leave','2024-07-05','2024-07-05','Rejected','2024-07-04','2024-07-04',16,'asd','afd',1),(51,18,'Sick Leave','2024-07-05','2024-07-05','Cancelled','2024-07-04','2024-07-04',16,'Sick',NULL,1),(53,19,'Casual Leave','2024-07-04','2024-07-05','Approved','2024-07-04','2024-07-12',16,'Casual',NULL,2),(54,17,'Casual Leave','2024-07-05','2024-07-08','Approved','2024-07-05',NULL,NULL,'Casual',NULL,2),(55,17,'Casual Leave','2024-07-05','2024-07-08','Approved','2024-07-05',NULL,NULL,'Casual',NULL,2),(58,17,'Casual Leave','2024-07-08','2024-07-08','Rejected','2024-07-05','2024-07-12',16,'Testing','Stupid guy asking for leave\r\n',1),(59,17,'Sick Leave','2024-07-10','2024-07-11','Approved','2024-07-05','2024-07-12',16,'asddsa',NULL,2),(60,17,'Sick Leave','2024-07-22','2024-07-23','Approved','2024-07-05','2024-07-12',16,'afdafadf',NULL,2),(61,17,'Annual Leave','2024-07-16','2024-07-18','Rejected','2024-07-05','2024-07-05',16,'Taking rest','gggg',3),(62,17,'Annual Leave','2024-07-15','2024-07-18','Approved','2024-07-05','2024-07-12',16,'Taafsasf',NULL,4),(63,18,'Sick Leave','2024-07-05','2024-07-05','Approved','2024-07-05',NULL,NULL,'Sick',NULL,1),(64,18,'Annual Leave','2024-07-18','2024-07-18','Approved','2024-07-05',NULL,NULL,'asdadadads',NULL,1),(65,18,'Sick Leave','2024-07-22','2024-07-22','Pending','2024-07-05','2024-07-15',16,'asdfghjkl','Testing\r\n',1),(68,18,'sick','2024-07-18','2024-07-18','Cancelled','2024-07-16','2024-07-16',16,'asfdgfhj',NULL,1),(69,18,'sick','2024-07-18','2024-07-18','Approved','2024-07-16','2024-07-16',16,'asfdgfhj',NULL,1),(71,16,'casual','2024-07-19','2024-07-19','Approved','2024-07-19','2024-07-19',16,'abcd',NULL,1),(72,16,'sick','2024-07-22','2024-07-22','Rejected','2024-07-19','2024-07-19',16,'Fever','not approved',1),(73,21,'casual','2024-07-24','2024-07-24','Pending','2024-07-24',NULL,NULL,'don\'t know',NULL,1),(91,16,'sick','2024-07-26','2024-07-29','Pending','2024-07-25',NULL,NULL,'',NULL,2),(94,17,'casual','2024-07-26','2024-07-26','Cancelled','2024-07-26',NULL,NULL,'sddfghj',NULL,1),(95,17,'casual','2024-07-26','2024-07-26','Approved','2024-07-26','2024-07-26',21,'kjbh',NULL,1),(96,16,'casual','2024-07-29','2024-07-29','Pending','2024-07-29',NULL,NULL,'',NULL,1),(97,34,'sick','2024-07-30','2024-07-30','Approved','2024-07-30','2024-07-30',23,'sdfg',NULL,1),(98,16,'casual','2024-08-01','2024-08-01','Pending','2024-08-01',NULL,NULL,'thago',NULL,1),(101,19,'casual','2024-08-09','2024-08-09','Pending','2024-08-09',NULL,NULL,'abcd',NULL,1),(102,16,'casual','2024-08-12','2024-08-12','Pending','2024-08-12',NULL,NULL,'sumne',NULL,1),(103,18,'casual','2024-08-12','2024-08-12','Approved','2024-08-12','2024-08-12',16,'Nothing',NULL,1),(104,18,'casual','2024-08-12','2024-08-12','Approved','2024-08-12','2024-08-12',16,'simply',NULL,1),(105,19,'casual','2024-08-12','2024-08-14','Approved','2024-08-12','2024-08-12',16,'sumne',NULL,3),(106,19,'casual','2024-08-12','2024-08-13','Approved','2024-08-12','2024-08-12',16,'',NULL,2),(107,17,'casual','2024-08-12','2024-08-12','Approved','2024-08-12','2024-08-12',16,'',NULL,1),(108,43,'casual','2024-08-12','2024-08-14','Approved','2024-08-12','2024-08-12',16,'',NULL,3),(109,43,'casual','2024-08-16','2024-08-16','Approved','2024-08-12','2024-08-12',16,'',NULL,1),(110,44,'casual','2024-08-12','2024-08-13','Approved','2024-08-12','2024-08-12',16,'',NULL,2),(111,44,'casual','2024-08-13','2024-08-14','Cancelled','2024-08-12','2024-08-12',16,'',NULL,2),(112,44,'casual','2024-08-13','2024-08-14','Cancelled','2024-08-12','2024-08-12',16,'',NULL,2),(113,44,'sick','2024-08-13','2024-08-13','Approved','2024-08-12','2024-08-12',16,'',NULL,1),(114,44,'casual','2024-08-13','2024-08-14','Approved','2024-08-12','2024-08-12',16,'',NULL,2),(116,37,'casual','2024-08-12','2024-08-23','Approved','2024-08-12','2024-08-12',16,'',NULL,9);
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leavesstock`
--

DROP TABLE IF EXISTS `leavesstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leavesstock` (
  `employeeid` int NOT NULL,
  `consumedLeaves` int DEFAULT '0',
  `AvailableLeaves` int DEFAULT '0',
  PRIMARY KEY (`employeeid`),
  CONSTRAINT `leavesStock_ibfk_1` FOREIGN KEY (`employeeid`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leavesstock`
--

LOCK TABLES `leavesstock` WRITE;
/*!40000 ALTER TABLE `leavesstock` DISABLE KEYS */;
INSERT INTO `leavesstock` VALUES (16,6,9),(17,0,19),(18,2,17),(19,22,-3),(20,0,19),(21,2,17),(23,0,19),(26,0,17),(28,0,17),(34,1,16),(35,0,17),(37,9,8),(42,0,9),(43,4,-2),(44,5,0);
/*!40000 ALTER TABLE `leavesstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `mgrId` int NOT NULL AUTO_INCREMENT,
  `manager` int DEFAULT NULL,
  `employee` int DEFAULT NULL,
  PRIMARY KEY (`mgrId`),
  KEY `manager` (`manager`),
  KEY `employee` (`employee`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`employee`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE,
  CONSTRAINT `manager_ibfk_2` FOREIGN KEY (`manager`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (16,21,17),(18,21,19),(20,23,34);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`RoleID`),
  UNIQUE KEY `rolename` (`rolename`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (7,'Backend Developer'),(5,'Clound Engineer'),(2,'Developer'),(6,'FrontEnd Developer'),(1,'HR'),(3,'Manager'),(4,'Tester'),(9,'UI developer');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_credentials`
--

DROP TABLE IF EXISTS `user_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_credentials` (
  `EmployeeID` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `user_credentials_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_credentials`
--

LOCK TABLES `user_credentials` WRITE;
/*!40000 ALTER TABLE `user_credentials` DISABLE KEYS */;
INSERT INTO `user_credentials` VALUES (16,'Suresh','$2a$10$.CLSxcStEwMw6F2YnBgAJeGLm14rlzimSAObYytXWOESqqO.BogTa'),(17,'Rushal','$2a$10$xZ9mBV1QF3VE2f3mDDCIauZItCymx2PDYUn8yOXgI819UwQxxb8NS'),(18,'Ananth','$2a$10$KfiWRRzeuWGSsMjO0c3o6uBZFcoKiWbHqesw2/5BHoKC2uR96c2Mq'),(19,'Sagar','$2a$10$qBLazlCS91/bTKkOPGoZmeNytKf5SS8oMfXDMCyfLLkia83hdHzlm'),(20,'Jayasree','$2a$10$xoqYno5gMvAXAF52SBqTzeAHPuM3Gc1yRCclmixq8MV6nEOZEccbC'),(21,'Prabhu','$2a$10$lUVxbCZpODiirLKt4.hqhePfL/EuGB3zHS1Kw1n.Mg6J16eGdFake'),(23,'Manager','$2a$10$PAkOdhe.5tcSQHMD8kYBSe.44jH3mO3E22BCzqgWhOEk2XyVMwZPi'),(26,'Ajay','$2a$10$x84cRDhfimQDyqMaa3I.tuZWgy3aP92C96/FU6QBNvGr29U7BEpb6'),(28,'AAA','$2a$10$nDFm8zSYixGCx2x8O7r5QOU2QpEkGC16wgw6HYm.ogVauymf3yIfS'),(34,'TestABC','$2a$10$7dDaWYM3r/a3JU3wY9rGael04ujmEIek8UbwjIUOTvE6PY6nB9X9a'),(35,'Jackie','$2a$10$.FflZF83eLHb.d3aGRkIkum7sLa6rO3t2Ll5BLsGzECqvtw.jlhri'),(37,'Adam','$2a$10$l4vEDXxQWGQLRL0maYgCuOLJuxFhC3LeGpf6G8KfypPKmokgFLU/W'),(42,'Ramesh','$2a$10$/6tUvhyL4ZdfK9tI0fpsG.GriopeiBViJttuOHcnBDaIjEMdXgUXm'),(43,'Santhosh','$2a$10$y7igXHJCIZ5gAC1lEqzU2uQbgRFgsw10hIChQA1IFpjT4gyHxbxC.'),(44,'Ram','$2a$10$xltsf83vdxptsY.DkdVcoeiQrGnJ/QRI/SpNKPCnR4iCeYMVIO5vO');
/*!40000 ALTER TABLE `user_credentials` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-23 11:20:03

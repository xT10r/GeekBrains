-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

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
-- Current Database: `shop`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `shop`;

--
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Раздели интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Мат. платы'),(3,'Видеокарты'),(4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL);
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `discount` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Скидки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,9,'2021-10-17 22:50:27','2021-12-27 23:46:27'),(2,15,'2021-10-05 23:13:27','2021-12-27 23:46:27'),(3,8,'2021-12-18 23:26:27','2021-12-27 23:46:27'),(4,16,'2021-12-18 22:33:27','2021-12-27 23:46:27'),(5,26,'2021-12-06 23:17:27','2021-12-27 23:46:27'),(6,25,'2021-11-09 23:35:27','2021-12-27 23:46:27'),(7,26,'2021-10-03 23:10:27','2021-12-27 23:46:27'),(8,25,'2021-11-06 23:17:27','2021-12-27 23:46:27'),(9,18,'2021-11-12 22:08:27','2021-12-27 23:46:27'),(10,14,'2021-12-07 22:50:27','2021-12-27 23:46:27'),(11,24,'2021-10-14 22:16:27','2021-12-27 23:46:27'),(12,22,'2021-12-01 22:27:27','2021-12-27 23:46:27'),(13,7,'2021-12-02 23:07:27','2021-12-27 23:46:27'),(14,9,'2021-09-29 23:26:27','2021-12-27 23:46:27'),(15,5,'2021-09-28 22:09:27','2021-12-27 23:46:27'),(16,13,'2021-12-21 22:55:27','2021-12-27 23:46:27'),(17,28,'2021-09-21 23:42:27','2021-12-27 23:46:27'),(18,26,'2021-12-24 23:06:27','2021-12-27 23:46:27'),(19,12,'2021-12-07 22:17:27','2021-12-27 23:46:27'),(20,11,'2021-10-02 22:14:27','2021-12-27 23:46:27');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `total` int unsigned DEFAULT '1' COMMENT 'Количество заказанных товаров',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Состав заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `description` text COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор Intel',7890.00,1,'2021-12-27 14:20:06','2021-12-27 14:20:06'),(2,'Intel Core i5-7400','Процессор Intel',12700.00,1,'2021-12-27 14:20:06','2021-12-27 14:20:06'),(3,'AMD FX-8320E','Процессор AMD',4780.00,1,'2021-12-27 14:20:06','2021-12-27 14:20:06'),(4,'AMD FX-8320','Процессор AMD',7120.00,1,'2021-12-27 14:20:06','2021-12-27 14:20:06'),(5,'ASUS ROG MAXIMUS X HERO','Z370, Socket 1151-V2, DDR4, ATX',19310.00,2,'2021-12-27 14:20:06','2021-12-27 14:20:06'),(6,'Gigabyte H310M S2H','H310, Socket 1151-V2, DDR4, mATX',4790.00,2,'2021-12-27 14:20:06','2021-12-27 14:20:06'),(7,'MSI B250M GAMING PRO','B250, Socket 1151, DDR4, mATX',5060.00,2,'2021-12-27 14:20:06','2021-12-27 14:20:06');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `products_names_view`
--

DROP TABLE IF EXISTS `products_names_view`;
/*!50001 DROP VIEW IF EXISTS `products_names_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `products_names_view` AS SELECT 
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `catalog_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `storehouses`
--

DROP TABLE IF EXISTS `storehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Склады';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses`
--

LOCK TABLES `storehouses` WRITE;
/*!40000 ALTER TABLE `storehouses` DISABLE KEYS */;
/*!40000 ALTER TABLE `storehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses_products`
--

DROP TABLE IF EXISTS `storehouses_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouses_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `value` int unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Заказы на складе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses_products`
--

LOCK TABLES `storehouses_products` WRITE;
/*!40000 ALTER TABLE `storehouses_products` DISABLE KEYS */;
INSERT INTO `storehouses_products` VALUES (1,1,1,30,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(2,1,2,99,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(3,1,3,6,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(4,2,4,34,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(5,2,3,0,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(6,2,5,52,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(7,3,7,12,'2021-12-24 16:51:07','2021-12-24 16:51:07'),(8,4,8,0,'2021-12-24 16:51:07','2021-12-24 16:51:07');
/*!40000 ALTER TABLE `storehouses_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user-af8718d0-51','1977-01-30','2021-12-24 16:50:55','2021-12-24 16:50:55'),(2,'user-af871d73-91','1987-02-27','2021-12-24 16:51:05','2021-12-24 16:51:05'),(3,'user-af873ba0-61','1997-01-24','2021-12-24 16:51:05','2021-12-24 16:51:05'),(4,'user-af87473b-2','1987-08-26','2021-12-24 16:50:57','2021-12-24 16:50:57'),(5,'user-af875492-53','2003-03-27','2021-12-24 16:51:00','2021-12-24 16:51:00'),(6,'user-af8763d5-57','1986-03-01','2021-12-24 16:51:02','2021-12-24 16:51:02'),(7,'user-af876bb7-3','1971-06-30','2021-12-24 16:51:05','2021-12-24 16:51:05'),(8,'user-af877260-86','1995-06-19','2021-12-24 16:51:05','2021-12-24 16:51:05'),(9,'user-af87737b-55','1979-05-23','2021-12-24 16:51:05','2021-12-24 16:51:05'),(10,'user-af8798f3-41','1978-01-27','2021-12-24 16:51:04','2021-12-24 16:51:04'),(11,'user-af879d34-70','1979-01-20','2021-12-24 16:51:02','2021-12-24 16:51:02'),(12,'user-af879e1a-29','1994-02-28','2021-12-24 16:51:05','2021-12-24 16:51:05'),(13,'user-af879ecc-98','1972-05-28','2021-12-24 16:51:05','2021-12-24 16:51:05'),(14,'user-af879f6d-3','1993-12-21','2021-12-24 16:51:05','2021-12-24 16:51:05'),(15,'user-af87a006-83','2003-10-28','2021-12-24 16:51:04','2021-12-24 16:51:04'),(16,'user-af87a0ae-1','1998-11-23','2021-12-24 16:51:02','2021-12-24 16:51:02'),(17,'user-af87a154-71','1995-03-02','2021-12-24 16:51:05','2021-12-24 16:51:05'),(18,'user-af87a1f8-83','1991-11-22','2021-12-24 16:51:05','2021-12-24 16:51:05'),(19,'user-af87a290-20','1987-01-28','2021-12-24 16:51:05','2021-12-24 16:51:05'),(20,'user-af87a327-99','1975-10-27','2021-12-24 16:51:04','2021-12-24 16:51:04'),(21,'user-af87a3cf-69','1997-09-24','2021-12-24 16:51:02','2021-12-24 16:51:02'),(22,'user-af87a470-5','1972-11-27','2021-12-24 16:51:05','2021-12-24 16:51:05'),(23,'user-af87a509-50','1985-11-25','2021-12-24 16:51:05','2021-12-24 16:51:05'),(24,'user-af87a5a1-73','1978-12-21','2021-12-24 16:51:05','2021-12-24 16:51:05'),(25,'user-aff7cda2-53','1964-05-31','2021-12-24 16:50:00','2021-12-24 16:50:00'),(26,'user-aff7d2ee-39','2005-03-20','2021-12-24 16:50:00','2021-12-24 16:50:00'),(27,'user-aff7d42f-2','1980-04-20','2021-12-24 16:50:00','2021-12-24 16:50:00'),(28,'user-b0b9fcc3-56','1972-05-12','2021-12-24 16:51:06','2021-12-24 16:51:06'),(29,'user-b0ba013f-27','1972-08-03','2021-12-24 16:51:06','2021-12-24 16:51:06'),(30,'user-a2a7022f-60','2003-06-01','2022-01-04 14:27:47','2022-01-04 14:28:56'),(31,'user-a2a7bd20-28','1989-03-03','2022-01-04 14:28:46','2022-01-04 14:28:26'),(32,'user-a2a80bc5-38','1972-03-08','2022-01-04 14:28:01','2022-01-04 14:28:43'),(33,'user-a2a848f0-86','1971-05-04','2022-01-04 14:28:41','2022-01-04 14:28:23'),(34,'user-a2a89c02-51','1990-09-05','2022-01-04 14:28:38','2022-01-04 14:27:54'),(35,'user-a2a96c78-82','1978-10-09','2022-01-04 14:28:46','2022-01-04 14:28:39'),(36,'user-a2a9b8ed-50','2003-06-03','2022-01-04 14:27:49','2022-01-04 14:28:38'),(37,'user-a2a9ea44-44','1977-05-01','2022-01-04 14:28:41','2022-01-04 14:28:47'),(38,'user-a2aa2e01-41','1991-08-04','2022-01-04 14:27:44','2022-01-04 14:28:16'),(39,'user-a2aa5ca5-32','1990-12-06','2022-01-04 14:28:21','2022-01-04 14:28:10'),(40,'user-a2aa8c36-35','1990-03-08','2022-01-04 14:27:58','2022-01-04 14:28:03'),(41,'user-a2aacddc-41','1972-02-01','2022-01-04 14:28:47','2022-01-04 14:27:58'),(42,'user-a2aafcb1-66','1981-04-03','2022-01-04 14:28:05','2022-01-04 14:28:53'),(43,'user-a2ab2c7a-81','1989-09-07','2022-01-04 14:28:16','2022-01-04 14:28:56'),(44,'user-a2ab6a2d-92','1973-09-05','2022-01-04 14:27:55','2022-01-04 14:28:32'),(45,'user-a2ab9265-47','2000-06-11','2022-01-04 14:28:06','2022-01-04 14:28:09'),(46,'user-a2abc233-71','1973-11-07','2022-01-04 14:27:57','2022-01-04 14:27:54'),(47,'user-a2ac0663-77','1971-11-12','2022-01-04 14:27:58','2022-01-04 14:28:04'),(48,'user-a2ac3292-73','1996-09-07','2022-01-04 14:28:26','2022-01-04 14:28:05'),(49,'user-a2ac59eb-36','1995-02-27','2022-01-04 14:28:08','2022-01-04 14:27:47');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `sample`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sample` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sample`;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Учетные данные пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'user-3a97e8f8-95','50b20c4b75'),(2,'user-3a985200-86','7e4f2388d0'),(3,'user-3a98a510-96','4ac9e5181c'),(4,'user-3a98ca46-54','a263632d3d'),(5,'user-3a98f4c2-61','b2b876dd42'),(6,'user-3a99327b-76','b3365c069c'),(7,'user-3a995c41-4','dedbf5b306'),(8,'user-3a998378-91','da95c4a30a'),(9,'user-3a99b8bf-97','cea52bcf61'),(10,'user-3a99d8cc-29','1d840c9a78'),(11,'user-3a99fdb2-80','1bf8f51497'),(12,'user-3a9a269c-56','8f63118142'),(13,'user-3a9a5e07-48','0516e2695c'),(14,'user-3a9a865f-11','56a79ab9de'),(15,'user-3a9aabcc-87','3299dfac04'),(16,'user-3a9ae928-59','d73ca94dca'),(17,'user-3a9b0df9-42','b1c01618c9'),(18,'user-3a9b3a64-70','9a11024681'),(19,'user-3a9b64da-50','b7aa80f2c2'),(20,'user-3a9b9bcc-33','7bd777147d');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson_06_03_some_dates`
--

DROP TABLE IF EXISTS `lesson_06_03_some_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_06_03_some_dates` (
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Календарное поле'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Календарные даты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_06_03_some_dates`
--

LOCK TABLES `lesson_06_03_some_dates` WRITE;
/*!40000 ALTER TABLE `lesson_06_03_some_dates` DISABLE KEYS */;
INSERT INTO `lesson_06_03_some_dates` VALUES ('2018-08-01 00:00:00'),('2018-08-04 00:00:00'),('2018-08-16 00:00:00'),('2018-08-17 00:00:00');
/*!40000 ALTER TABLE `lesson_06_03_some_dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson_06_04_some_dates`
--

DROP TABLE IF EXISTS `lesson_06_04_some_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_06_04_some_dates` (
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Календарное поле'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Календарные даты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_06_04_some_dates`
--

LOCK TABLES `lesson_06_04_some_dates` WRITE;
/*!40000 ALTER TABLE `lesson_06_04_some_dates` DISABLE KEYS */;
INSERT INTO `lesson_06_04_some_dates` VALUES ('2021-11-26 00:00:00'),('2021-11-27 00:00:00'),('2021-11-28 00:00:00'),('2021-11-29 00:00:00'),('2021-11-30 00:00:00');
/*!40000 ALTER TABLE `lesson_06_04_some_dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `username`
--

DROP TABLE IF EXISTS `username`;
/*!50001 DROP VIEW IF EXISTS `username`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `username` AS SELECT 
 1 AS `id`,
 1 AS `user`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user-af8718d0-51','1977-01-30','2021-12-24 16:50:55','2021-12-24 16:50:55');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `shop`
--

USE `shop`;

--
-- Final view structure for view `products_names_view`
--

/*!50001 DROP VIEW IF EXISTS `products_names_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `products_names_view` (`product_id`,`product_name`,`catalog_name`) AS select `p`.`id` AS `id`,`p`.`name` AS `name`,`c`.`name` AS `name` from (`products` `p` left join `catalogs` `c` on((`p`.`catalog_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `sample`
--

USE `sample`;

--
-- Final view structure for view `username`
--

/*!50001 DROP VIEW IF EXISTS `username`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `username` (`id`,`user`) AS select `acc`.`id` AS `id`,`acc`.`name` AS `name` from `accounts` `acc` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-04 15:23:23

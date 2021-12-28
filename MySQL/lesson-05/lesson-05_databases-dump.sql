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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Раздели интернет-магазина';
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user-af8718d0-51','1977-01-30','2021-12-24 16:50:55','2021-12-24 16:50:55'),(2,'user-af871d73-91','1987-02-27','2021-12-24 16:51:05','2021-12-24 16:51:05'),(3,'user-af873ba0-61','1997-01-24','2021-12-24 16:51:05','2021-12-24 16:51:05'),(4,'user-af87473b-2','1987-08-26','2021-12-24 16:50:57','2021-12-24 16:50:57'),(5,'user-af875492-53','2003-03-27','2021-12-24 16:51:00','2021-12-24 16:51:00'),(6,'user-af8763d5-57','1986-03-01','2021-12-24 16:51:02','2021-12-24 16:51:02'),(7,'user-af876bb7-3','1971-06-30','2021-12-24 16:51:05','2021-12-24 16:51:05'),(8,'user-af877260-86','1995-06-19','2021-12-24 16:51:05','2021-12-24 16:51:05'),(9,'user-af87737b-55','1979-05-23','2021-12-24 16:51:05','2021-12-24 16:51:05'),(10,'user-af8798f3-41','1978-01-27','2021-12-24 16:51:04','2021-12-24 16:51:04'),(11,'user-af879d34-70','1979-01-20','2021-12-24 16:51:02','2021-12-24 16:51:02'),(12,'user-af879e1a-29','1994-02-28','2021-12-24 16:51:05','2021-12-24 16:51:05'),(13,'user-af879ecc-98','1972-05-28','2021-12-24 16:51:05','2021-12-24 16:51:05'),(14,'user-af879f6d-3','1993-12-21','2021-12-24 16:51:05','2021-12-24 16:51:05'),(15,'user-af87a006-83','2003-10-28','2021-12-24 16:51:04','2021-12-24 16:51:04'),(16,'user-af87a0ae-1','1998-11-23','2021-12-24 16:51:02','2021-12-24 16:51:02'),(17,'user-af87a154-71','1995-03-02','2021-12-24 16:51:05','2021-12-24 16:51:05'),(18,'user-af87a1f8-83','1991-11-22','2021-12-24 16:51:05','2021-12-24 16:51:05'),(19,'user-af87a290-20','1987-01-28','2021-12-24 16:51:05','2021-12-24 16:51:05'),(20,'user-af87a327-99','1975-10-27','2021-12-24 16:51:04','2021-12-24 16:51:04'),(21,'user-af87a3cf-69','1997-09-24','2021-12-24 16:51:02','2021-12-24 16:51:02'),(22,'user-af87a470-5','1972-11-27','2021-12-24 16:51:05','2021-12-24 16:51:05'),(23,'user-af87a509-50','1985-11-25','2021-12-24 16:51:05','2021-12-24 16:51:05'),(24,'user-af87a5a1-73','1978-12-21','2021-12-24 16:51:05','2021-12-24 16:51:05'),(25,'user-aff7cda2-53','1964-05-31','2021-12-24 16:50:00','2021-12-24 16:50:00'),(26,'user-aff7d2ee-39','2005-03-20','2021-12-24 16:50:00','2021-12-24 16:50:00'),(27,'user-aff7d42f-2','1980-04-20','2021-12-24 16:50:00','2021-12-24 16:50:00'),(28,'user-b0b9fcc3-56','1972-05-12','2021-12-24 16:51:06','2021-12-24 16:51:06'),(29,'user-b0ba013f-27','1972-08-03','2021-12-24 16:51:06','2021-12-24 16:51:06');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `example`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `example` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `example`;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `label` varchar(255) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Полеты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES ('Moscow','Москва'),('Saint Petersburg','Санкт-Петербург'),('Saratov','Саратов'),('Chebarkul','Чебаркуль'),('Chelyabinsk','Челябинск'),('Miass','Миасс');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Полеты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'Chelyabinsk','Miass'),(2,'Saratov','Chebarkul'),(3,'Saint Petersburg','Chelyabinsk'),(4,'Moscow','Saint Petersburg'),(5,'Miass','Saint Petersburg'),(6,'Chelyabinsk','Saint Petersburg'),(7,'Saratov','Saint Petersburg'),(8,'Miass','Moscow'),(9,'Chebarkul','Saint Petersburg'),(10,'Saint Petersburg','Moscow'),(11,'Saint Petersburg','Saratov'),(12,'Moscow','Chelyabinsk'),(13,'Saint Petersburg','Miass'),(14,'Chebarkul','Saratov'),(15,'Saratov','Miass'),(16,'Miass','Chelyabinsk'),(17,'Chelyabinsk','Saratov'),(18,'Chebarkul','Miass'),(19,'Chebarkul','Moscow'),(20,'Miass','Chebarkul'),(21,'Moscow','Miass'),(22,'Saratov','Moscow'),(23,'Chelyabinsk','Moscow'),(24,'Miass','Saratov'),(25,'Moscow','Chebarkul'),(26,'Saint Petersburg','Chebarkul'),(27,'Saratov','Chelyabinsk'),(28,'Moscow','Saratov'),(29,'Chebarkul','Chelyabinsk'),(30,'Chelyabinsk','Chebarkul');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'hello');
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

-- Dump completed on 2021-12-28  0:53:28

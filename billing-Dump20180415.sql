CREATE DATABASE  IF NOT EXISTS `billing` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `billing`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: billing
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(45) NOT NULL,
  `gst_number` varchar(45) DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Star Electricalsss','1000','3, junction road, vridhachalam.'),(2,'India Electricals','1222','4, junction road, vridhachalam.'),(3,'Metro Electricals','1333','67, cuddalore road, vridhachalam.'),(4,'Taj Mahabub','1555',''),(5,'Sakthi Electricals','1666',''),(6,'c1ccc','g1ggg',''),(7,'c2','g2',''),(8,'c3','g3',''),(9,'c4','g4',''),(10,'c5','g5',''),(11,'c6','g6',''),(12,'c7','g7',''),(13,'c8','g8',''),(14,'c14','g14','');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_dated` date NOT NULL,
  `quantity` int(11) NOT NULL,
  `sales` decimal(9,2) NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `product_product_id` int(11) NOT NULL,
  `customer_customer_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`,`product_product_id`,`customer_customer_id`),
  KEY `fk_invoice_product1_idx` (`product_product_id`),
  KEY `fk_invoice_customer1_idx` (`customer_customer_id`),
  CONSTRAINT `fk_invoice_customer1` FOREIGN KEY (`customer_customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_product1` FOREIGN KEY (`product_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,'2017-11-11',20,1792.00,1792.00,3,2);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `hsn_code` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'TL','HSN011',NULL),(2,'TL Slim','HSN011',NULL),(3,'CFL5w','HSN012',NULL),(4,'999999','HSN012',NULL),(5,'GrindBelt36A','HSN010',NULL),(18,'asdf','hn1',NULL),(19,'lkjhh','hsn0933',NULL),(20,'Product9','HSN988',NULL),(21,'Product10','HSN989',NULL),(22,'Product11','HSN011',NULL),(23,'Product11','HSN977',NULL),(24,'','',NULL),(25,'','',NULL),(26,'','',NULL),(27,'','',NULL),(28,'Product11','HSN099',NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `stock_entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `gst_percentage` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_price` decimal(9,2) NOT NULL,
  `date_of_purchase` date NOT NULL,
  `product_product_id` int(11) NOT NULL,
  `supplier_supplier_id` int(11) NOT NULL,
  PRIMARY KEY (`stock_entry_id`,`product_product_id`,`supplier_supplier_id`),
  KEY `fk_stock_product_idx` (`product_product_id`),
  KEY `fk_stock_supplier1_idx` (`supplier_supplier_id`),
  CONSTRAINT `fk_stock_product` FOREIGN KEY (`product_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stock_supplier1` FOREIGN KEY (`supplier_supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,18,300,39.00,'2017-10-15',4,3),(2,18,500,38.00,'2017-09-11',2,4),(3,28,100,80.00,'2017-07-14',5,2),(4,12,500,95.00,'2017-11-28',3,1),(5,18,600,61.92,'2017-11-06',1,5),(7,12,500,44.00,'2018-01-20',18,39),(8,28,400,65.00,'2018-02-25',19,4),(9,12,1000,70.00,'2018-03-08',20,3),(10,18,500,190.95,'2018-03-13',21,2),(11,12,455,454.00,'2018-03-11',22,43),(12,18,45,456.00,'2018-03-02',22,3),(13,12,600,45.25,'2018-03-03',22,1);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(45) NOT NULL,
  `gst_number` varchar(45) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Surya Electricals ff','12321'),(2,'Power Traders','23456'),(3,'Electricals Spares','12345'),(4,'Blue Lightings Traders','34521'),(5,'Mega Spares','234511'),(6,'Cool Fan Providers','CScserzxYUIO9fjwqXDSdjlsjfXCk'),(7,'s233','g2333'),(8,'s3','g3'),(9,'s4','g4'),(10,'s5','g5'),(11,'s6','g6'),(12,'s7','g7'),(13,'s8','g8'),(14,'s9','g9'),(15,'s10 s','g10aa'),(16,'s1sdfsdf1','g11sdfwerdf3'),(17,'s11','g11'),(18,'s12','g12'),(19,'s13','g13'),(20,'s14','g14'),(21,'s21sss','g21gggg'),(22,'s22','g22'),(23,'s23','g23'),(24,'s24','g24'),(30,'sss1','null'),(31,'sss2','null'),(32,'sss3','null'),(33,'sss1','null'),(34,'sss2','null'),(35,'sss3','null'),(36,'sss1','null'),(37,'sss2','null'),(38,'sss3','null'),(39,'zzxxyy sss','null'),(40,'Blue Lightings Traders','null'),(41,'Electricals Spares','null'),(42,'Power Traders','null'),(43,'Example Supplier','null'),(44,'Electricals Spares','null'),(45,'','null'),(46,'','null'),(47,'','null'),(48,'','null'),(49,'Surya Electricals ff','null');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-15 22:56:16

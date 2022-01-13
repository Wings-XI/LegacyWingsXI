-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 10:58 AM
-- Server version: 10.5.6-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `topaz`
--

-- --------------------------------------------------------

--
-- Table structure for table `abilities_charges`
--

DROP TABLE IF EXISTS `abilities_charges`;
CREATE TABLE `abilities_charges` (
  `recastId` smallint(5) UNSIGNED NOT NULL,
  `job` tinyint(2) UNSIGNED NOT NULL,
  `level` tinyint(2) UNSIGNED NOT NULL,
  `maxCharges` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `chargeTime` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `meritModID` smallint(4) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM AVG_ROW_LENGTH=56 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `abilities_charges`
--

INSERT INTO `abilities_charges` VALUES(231, 20, 10, 1, 240, 0);
INSERT INTO `abilities_charges` VALUES(231, 20, 30, 2, 120, 0);
INSERT INTO `abilities_charges` VALUES(231, 20, 50, 3, 80, 0);
INSERT INTO `abilities_charges` VALUES(231, 20, 70, 4, 60, 0);
INSERT INTO `abilities_charges` VALUES(231, 20, 90, 5, 48, 0);
INSERT INTO `abilities_charges` VALUES(195, 17, 40, 2, 60, 1410);
INSERT INTO `abilities_charges` VALUES(102, 9, 25, 3, 60, 902);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `abilities_charges`
--
ALTER TABLE `abilities_charges`
  ADD PRIMARY KEY (`recastId`,`job`,`level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

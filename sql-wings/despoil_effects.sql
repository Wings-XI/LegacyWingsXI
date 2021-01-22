-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:14 PM
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
-- Table structure for table `despoil_effects`
--

DROP TABLE IF EXISTS `despoil_effects`;
CREATE TABLE `despoil_effects` (
  `itemId` smallint(5) UNSIGNED NOT NULL,
  `effectId` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `despoil_effects`
--

INSERT INTO `despoil_effects` VALUES(644, 149);
INSERT INTO `despoil_effects` VALUES(842, 146);
INSERT INTO `despoil_effects` VALUES(881, 149);
INSERT INTO `despoil_effects` VALUES(955, 167);
INSERT INTO `despoil_effects` VALUES(2334, 175);
INSERT INTO `despoil_effects` VALUES(4376, 147);
INSERT INTO `despoil_effects` VALUES(4400, 13);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `despoil_effects`
--
ALTER TABLE `despoil_effects`
  ADD PRIMARY KEY (`itemId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

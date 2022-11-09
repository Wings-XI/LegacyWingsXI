-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:13 PM
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
-- Table structure for table `conquest_system`
--

DROP TABLE IF EXISTS `conquest_system`;
CREATE TABLE `conquest_system` (
  `region_id` tinyint(2) NOT NULL DEFAULT 0,
  `region_control` tinyint(2) NOT NULL DEFAULT 0,
  `region_control_prev` tinyint(2) NOT NULL DEFAULT 0,
  `sandoria_influence` int(10) NOT NULL DEFAULT 0,
  `bastok_influence` int(10) NOT NULL DEFAULT 0,
  `windurst_influence` int(10) NOT NULL DEFAULT 0,
  `beastmen_influence` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conquest_system`
--

INSERT INTO `conquest_system` VALUES(0, 0, 1, 5000, 0, 0, 0);
INSERT INTO `conquest_system` VALUES(1, 2, 1, 886, 2427, 441, 246);
INSERT INTO `conquest_system` VALUES(2, 1, 1, 1630, 1787, 654, 929);
INSERT INTO `conquest_system` VALUES(3, 1, 1, 0, 5000, 0, 0);
INSERT INTO `conquest_system` VALUES(4, 1, 0, 800, 4139, 0, 61);
INSERT INTO `conquest_system` VALUES(5, 0, 0, 0, 0, 5000, 0);
INSERT INTO `conquest_system` VALUES(6, 3, 0, 0, 0, 5000, 0);
INSERT INTO `conquest_system` VALUES(7, 0, 0, 8, 4992, 0, 0);
INSERT INTO `conquest_system` VALUES(8, 3, 0, 0, 0, 0, 5003);
INSERT INTO `conquest_system` VALUES(9, 0, 3, 81, 1222, 82, 3615);
INSERT INTO `conquest_system` VALUES(10, 2, 3, 1532, 2796, 492, 180);
INSERT INTO `conquest_system` VALUES(11, 1, 3, 2112, 1202, 1475, 211);
INSERT INTO `conquest_system` VALUES(12, 3, 3, 1717, 1440, 1686, 157);
INSERT INTO `conquest_system` VALUES(13, 2, 3, 1629, 2408, 143, 820);
INSERT INTO `conquest_system` VALUES(14, 1, 3, 1121, 1269, 452, 2158);
INSERT INTO `conquest_system` VALUES(15, 3, 3, 2122, 437, 256, 2185);
INSERT INTO `conquest_system` VALUES(16, 1, 3, 1095, 2942, 154, 809);
INSERT INTO `conquest_system` VALUES(17, 3, 3, 0, 0, 0, 5000);
INSERT INTO `conquest_system` VALUES(18, 3, 3, 213, 229, 526, 4032);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `conquest_system`
--
ALTER TABLE `conquest_system`
  ADD PRIMARY KEY (`region_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

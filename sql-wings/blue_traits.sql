-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 06:58 PM
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
-- Table structure for table `blue_traits`
--

DROP TABLE IF EXISTS `blue_traits`;
CREATE TABLE `blue_traits` (
  `trait_category` smallint(2) UNSIGNED NOT NULL,
  `trait_points_needed` smallint(2) UNSIGNED NOT NULL,
  `traitid` tinyint(3) UNSIGNED NOT NULL,
  `modifier` smallint(5) UNSIGNED NOT NULL,
  `value` smallint(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blue_traits`
--

INSERT INTO `blue_traits` VALUES(1, 2, 32, 230, 8);
INSERT INTO `blue_traits` VALUES(2, 2, 9, 370, 1);
INSERT INTO `blue_traits` VALUES(3, 2, 35, 227, 8);
INSERT INTO `blue_traits` VALUES(4, 2, 24, 295, 1);
INSERT INTO `blue_traits` VALUES(4, 4, 24, 295, 2);
INSERT INTO `blue_traits` VALUES(4, 6, 24, 295, 3);
INSERT INTO `blue_traits` VALUES(4, 8, 24, 295, 4);
INSERT INTO `blue_traits` VALUES(5, 2, 48, 240, 2);
INSERT INTO `blue_traits` VALUES(6, 2, 5, 28, 20);
INSERT INTO `blue_traits` VALUES(7, 2, 39, 231, 8);
INSERT INTO `blue_traits` VALUES(8, 2, 3, 23, 10); -- ATT
INSERT INTO `blue_traits` VALUES(8, 2, 3, 24, 10); -- RATT
INSERT INTO `blue_traits` VALUES(9, 2, 11, 359, 10);
INSERT INTO `blue_traits` VALUES(10, 2, 8, 5, 10);
INSERT INTO `blue_traits` VALUES(10, 4, 8, 5, 30);
INSERT INTO `blue_traits` VALUES(11, 2, 4, 1, 10);
INSERT INTO `blue_traits` VALUES(12, 2, 33, 229, 8);
INSERT INTO `blue_traits` VALUES(13, 2, 6, 29, 10);
INSERT INTO `blue_traits` VALUES(14, 8, 10, 369, 1);
INSERT INTO `blue_traits` VALUES(15, 2, 7, 2, 30);
INSERT INTO `blue_traits` VALUES(15, 4, 7, 2, 90);
INSERT INTO `blue_traits` VALUES(16, 2, 1, 25, 10); -- ACC
INSERT INTO `blue_traits` VALUES(16, 2, 1, 26, 10); -- RACC
INSERT INTO `blue_traits` VALUES(17, 2, 13, 296, 25);
INSERT INTO `blue_traits` VALUES(18, 2, 2, 68, 10);
INSERT INTO `blue_traits` VALUES(19, 2, 58, 249, 2);
INSERT INTO `blue_traits` VALUES(20, 2, 14, 73, 10);
INSERT INTO `blue_traits` VALUES(20, 4, 14, 73, 25);
INSERT INTO `blue_traits` VALUES(21, 2, 17, 291, 10);
INSERT INTO `blue_traits` VALUES(22, 2, 12, 170, 5);
INSERT INTO `blue_traits` VALUES(22, 4, 12, 170, 15);
INSERT INTO `blue_traits` VALUES(23, 2, 106, 174, 8);
INSERT INTO `blue_traits` VALUES(24, 2, 15, 288, 7);
INSERT INTO `blue_traits` VALUES(24, 4, 16, 302, 5);
INSERT INTO `blue_traits` VALUES(25, 2, 18, 259, 10);
INSERT INTO `blue_traits` VALUES(25, 4, 18, 259, 15);
INSERT INTO `blue_traits` VALUES(25, 6, 18, 259, 25);
INSERT INTO `blue_traits` VALUES(26, 2, 70, 306, 15);
INSERT INTO `blue_traits` VALUES(27, 2, 110, 487, 5);
INSERT INTO `blue_traits` VALUES(28, 2, 20, 897, 50);
INSERT INTO `blue_traits` VALUES(28, 3, 19, 303, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blue_traits`
--
ALTER TABLE `blue_traits`
  ADD PRIMARY KEY (`trait_category`,`trait_points_needed`,`modifier`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

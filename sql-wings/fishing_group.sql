-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:08 PM
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
-- Table structure for table `fishing_group`
--

DROP TABLE IF EXISTS `fishing_group`;
CREATE TABLE `fishing_group` (
  `groupid` int(10) UNSIGNED NOT NULL,
  `fishid` int(10) UNSIGNED NOT NULL,
  `rarity` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `requiredmoon` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `moonbonus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `requiredtime` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `timebonus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `requiredday` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `daybonus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `requiredweather` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `weatherbonus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `fishing_groupcol` varchar(45) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fishing_group`
--

INSERT INTO `fishing_group` VALUES(1, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 4462, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 4464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 4473, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(1, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4383, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4481, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(2, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(3, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(3, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 591, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(4, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(5, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(6, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(7, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(8, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(8, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(8, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(8, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(8, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(8, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(9, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(10, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 4464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(11, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(12, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(12, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(12, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(13, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(14, 16451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(15, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(15, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(15, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(15, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(15, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 4354, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 4379, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(16, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(17, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(18, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(18, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(18, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(19, 4354, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(19, 4379, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(19, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(19, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(19, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(20, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(20, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(20, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(20, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(20, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 4477, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(21, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(22, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(23, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(24, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(24, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(24, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(24, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(24, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(24, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 4500, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 4501, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(25, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 4484, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 4500, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 5330, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(26, 5329, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(27, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 4354, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 5126, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(28, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(29, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(29, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(29, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(29, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(29, 5125, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(29, 5126, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(30, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(30, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(30, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(30, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(30, 5126, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 4463, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(31, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(32, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(32, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(32, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(32, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(32, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(33, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(34, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(34, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(34, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(34, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 4528, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(35, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 4454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(36, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(37, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(38, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 4354, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 4379, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(39, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(40, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(40, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 4291, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(41, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(42, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 4477, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(43, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(44, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(45, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(45, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(45, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(45, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(45, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(46, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(46, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(46, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(46, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(46, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4383, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4481, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(47, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(48, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(49, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(50, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(51, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 12316, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(52, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(53, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(53, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(53, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(53, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(53, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(53, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(54, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 4462, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(55, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(56, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(56, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(56, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(56, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(56, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(56, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(57, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(58, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(58, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(58, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(58, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(59, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(59, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(59, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(59, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(59, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(59, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4383, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4481, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(60, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 4314, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 4317, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 4318, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 4484, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 5121, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 5131, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(61, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4317, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4318, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4484, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 5121, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 5131, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(62, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 4318, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 4484, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 5121, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 5131, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(63, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(64, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 12316, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(65, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 4484, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(66, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(67, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(67, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4305, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4317, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(68, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4485, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 5120, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(69, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4314, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4318, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4476, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4480, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4485, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 5121, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 5127, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(70, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(71, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(72, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(73, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 4474, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(74, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 4454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 4470, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(75, 16451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(76, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(76, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(77, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 4474, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 12316, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(78, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 4478, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(79, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(80, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 4308, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(81, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 4454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(82, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(83, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(83, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(83, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(83, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(83, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 1522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 4473, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 16451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(84, 16537, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(85, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(85, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(86, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(86, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(86, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(86, 4528, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 4291, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 4306, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(87, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(88, 4309, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(88, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(88, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 4291, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 4306, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(89, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 4291, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 4306, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 4477, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(90, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 4291, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 4306, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(91, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 4385, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 4484, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 4500, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(92, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(93, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(93, 4291, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(93, 4306, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(93, 4309, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(93, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(93, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 591, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(94, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(95, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 1135, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(96, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 1135, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 1210, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4304, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4361, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(97, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 1135, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4304, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4361, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(98, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(99, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(99, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(99, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(99, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(99, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(99, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(100, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(100, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(100, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(100, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(100, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4307, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4462, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 4473, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(101, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 4473, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(102, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 4307, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 4464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(103, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 490, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 4464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(104, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 4464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(105, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(106, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 4288, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 4383, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(107, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 887, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 4305, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 4580, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 12316, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(108, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(109, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(109, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(109, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(110, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(110, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(110, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 4307, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 4464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(111, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 4307, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(112, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(113, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 4307, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 4462, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(114, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(115, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(116, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(116, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 4289, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 4290, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 4579, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(117, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(118, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(118, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(118, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 1624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 1638, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 4313, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 4316, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 16606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(119, 16655, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(120, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(120, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(120, 4454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(120, 5129, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(120, 5130, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(121, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(121, 4500, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(121, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(122, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(122, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(122, 5130, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(123, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(123, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(123, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(123, 4463, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(123, 5130, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(123, 13456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(124, 2341, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(124, 5447, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(124, 5448, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(124, 5449, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(124, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 2341, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 4310, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 5458, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 5459, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 5460, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(125, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 5137, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 5458, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 5459, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 5460, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 5461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 5462, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(126, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(127, 2216, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(127, 4309, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(127, 4313, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(127, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(127, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 5139, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 5458, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 5459, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 5460, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 5461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(128, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 5137, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 5458, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 5459, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 5460, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 5461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 5462, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(129, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(130, 5447, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(130, 5448, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(130, 5449, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(130, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 5135, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 5453, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 5454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 5455, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 5456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(131, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 5138, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 5463, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 5464, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 5465, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(132, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 2341, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 5133, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 5453, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 5454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 5455, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 5456, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(133, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 5136, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 5453, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 5454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 5455, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 5457, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(134, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 4480, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 4485, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 5127, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 5132, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 5134, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 5141, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(135, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4305, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4361, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4476, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4479, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4480, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4485, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(136, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4305, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4361, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4475, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4476, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4479, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4480, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4485, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 5127, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(137, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 2341, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 5140, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 5448, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 5449, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 5450, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 5451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
INSERT INTO `fishing_group` VALUES(138, 5452, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');


-- UPDATE by XENTIS - 28/02/21
-- //START

-- Vunkerl Inlet [S] - Bridge
INSERT INTO `fishing_group` VALUES(139, 5466, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Trumpet Shell*/
INSERT INTO `fishing_group` VALUES(139, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Bastore Sardine*/
INSERT INTO `fishing_group` VALUES(139, 4481, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Ogre Eel*/
INSERT INTO `fishing_group` VALUES(139, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Quus*/
INSERT INTO `fishing_group` VALUES(139, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Cobalt Jellyfish*/
INSERT INTO `fishing_group` VALUES(139, 5472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Garpike*/
INSERT INTO `fishing_group` VALUES(139, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Bastore Bream*/
INSERT INTO `fishing_group` VALUES(139, 5468, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Matsya*/
INSERT INTO `fishing_group` VALUES(139, 5475, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Gigant Octopus*/

INSERT INTO `fishing_group` VALUES(139, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Arrowwood Log*/
INSERT INTO `fishing_group` VALUES(139, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Bucket*/
INSERT INTO `fishing_group` VALUES(139, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
INSERT INTO `fishing_group` VALUES(139, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Subligar*/
-- Vunkerl Inlet [S] - Lake Joroia
INSERT INTO `fishing_group` VALUES(140, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Crayfish*/
INSERT INTO `fishing_group` VALUES(140, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(140, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tricolored Carp*/
INSERT INTO `fishing_group` VALUES(140, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Giant Catfish*/
INSERT INTO `fishing_group` VALUES(140, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Dark Bass*/
INSERT INTO `fishing_group` VALUES(140, 5472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Garpike*/
INSERT INTO `fishing_group` VALUES(140, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Arrowwood Log*/
INSERT INTO `fishing_group` VALUES(140, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
-- Vunkerl Inlet [S] - Memjar Spring
INSERT INTO `fishing_group` VALUES(141, 5472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Garpike*/
-- Vunkerl Inlet [S] - Ludiwa Spring
INSERT INTO `fishing_group` VALUES(142, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(142, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tricolored Carp*/
INSERT INTO `fishing_group` VALUES(142, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Dark Bass*/
INSERT INTO `fishing_group` VALUES(142, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(142, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gold Carp*/
INSERT INTO `fishing_group` VALUES(142, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/

-- Rolanberry Fields [S] - Small Fountain 1
INSERT INTO `fishing_group` VALUES(143, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Crayfish*/
INSERT INTO `fishing_group` VALUES(143, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(143, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
-- Rolanberry Fields [S] - Fountain of Promises
INSERT INTO `fishing_group` VALUES(144, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(144, 688, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Arrowwood Log*/
-- Rolanberry Fields [S] - Fountain of Partings
INSERT INTO `fishing_group` VALUES(145, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Crayfish*/
INSERT INTO `fishing_group` VALUES(145, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(145, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Giant Catfish*/
INSERT INTO `fishing_group` VALUES(145, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(145, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
-- Rolanberry Fields [S] - Small Fountain 2
INSERT INTO `fishing_group` VALUES(146, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(146, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(146, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
-- Pashhow Marshlands [S] - Whole Zone
INSERT INTO `fishing_group` VALUES(147, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Copper Frog*/
INSERT INTO `fishing_group` VALUES(147, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Giant Catfish*/
INSERT INTO `fishing_group` VALUES(147, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(147, 5471, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gerrothorax*/
INSERT INTO `fishing_group` VALUES(147, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Cap*/

-- West Sarutabaruta [S] - Pond
INSERT INTO `fishing_group` VALUES(148, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(148, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Giant Catfish*/
INSERT INTO `fishing_group` VALUES(148, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Dark Bass*/
-- West Sarutabaruta [S] - Seaside
INSERT INTO `fishing_group` VALUES(149, 4481, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Ogre Eel*/
INSERT INTO `fishing_group` VALUES(149, 4383, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gold Lobster*/
INSERT INTO `fishing_group` VALUES(149, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Bluetail*/
INSERT INTO `fishing_group` VALUES(149, 4461, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Bastore Bream*/
INSERT INTO `fishing_group` VALUES(149, 624, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Pamtam Kelp*/
INSERT INTO `fishing_group` VALUES(149, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
INSERT INTO `fishing_group` VALUES(149, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Subligar*/

-- North Gustaberg [S] - Whole Zone
INSERT INTO `fishing_group` VALUES(150, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Copper Frog*/
INSERT INTO `fishing_group` VALUES(150, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tricolored Carp*/
INSERT INTO `fishing_group` VALUES(150, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Black Eel*/
INSERT INTO `fishing_group` VALUES(150, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gold Carp*/
INSERT INTO `fishing_group` VALUES(150, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Bucket*/
INSERT INTO `fishing_group` VALUES(150, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
INSERT INTO `fishing_group` VALUES(150, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Subligar*/

-- Grauberg [S] - All Waterside
INSERT INTO `fishing_group` VALUES(151, 4515, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Copper Frog*/
INSERT INTO `fishing_group` VALUES(151, 5469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Brass Loach*/
INSERT INTO `fishing_group` VALUES(151, 4429, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Black Eel*/
INSERT INTO `fishing_group` VALUES(151, 5474, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Ca Cuong*/
INSERT INTO `fishing_group` VALUES(151, 4477, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gavial Fish*/
INSERT INTO `fishing_group` VALUES(151, 5470, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Pirarucu*/
INSERT INTO `fishing_group` VALUES(151, 14117, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Leggings*/
INSERT INTO `fishing_group` VALUES(151, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Subligar*/
-- Grauberg [S] - Waterfall
INSERT INTO `fishing_group` VALUES(152, 4477, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gavial Fish*/

-- La Vaule [S] - Pond
INSERT INTO `fishing_group` VALUES(153, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Giant Catfish*/
INSERT INTO `fishing_group` VALUES(153, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Dark Bass*/
INSERT INTO `fishing_group` VALUES(153, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Bucket*/
-- La Vaule [S] - Other Waterside
INSERT INTO `fishing_group` VALUES(154, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(154, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tricolored Carp*/
INSERT INTO `fishing_group` VALUES(154, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(154, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gold Carp*/

-- Jugner Forest [S] - Lake Mechieume - Mouth & Main
INSERT INTO `fishing_group` VALUES(155, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(155, 4469, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Giant Catfish*/
INSERT INTO `fishing_group` VALUES(155, 4428, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Dark Bass*/
INSERT INTO `fishing_group` VALUES(155, 4402, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Red Terrapin*/
INSERT INTO `fishing_group` VALUES(155, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gold Carp*/
INSERT INTO `fishing_group` VALUES(155, 4454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Emperor Fish*/
INSERT INTO `fishing_group` VALUES(155, 5476, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Abaia*/
INSERT INTO `fishing_group` VALUES(155, 12522, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Rusty Cap*/
-- Jugner Forest [S] - River
INSERT INTO `fishing_group` VALUES(156, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Crayfish*/
INSERT INTO `fishing_group` VALUES(156, 4401, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Moat Carp*/
INSERT INTO `fishing_group` VALUES(156, 4379, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Cheval Salmon*/
INSERT INTO `fishing_group` VALUES(156, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tricolored Carp*/
INSERT INTO `fishing_group` VALUES(156, 4354, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Shining Trout*/

-- Batallia Downs [S] - South Seaside
INSERT INTO `fishing_group` VALUES(157, 4443, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Cobalt Jellyfish*/
INSERT INTO `fishing_group` VALUES(157, 4360, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Bastore Sardine*/
INSERT INTO `fishing_group` VALUES(157, 4403, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Yellow Globe*/
INSERT INTO `fishing_group` VALUES(157, 4483, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tiger Cod*/
INSERT INTO `fishing_group` VALUES(157, 4482, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Nosteau Herring*/
INSERT INTO `fishing_group` VALUES(157, 5128, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Cone Calamary*/
INSERT INTO `fishing_group` VALUES(157, 4399, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Bluetail*/
INSERT INTO `fishing_group` VALUES(157, 4451, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Silver Shark*/
INSERT INTO `fishing_group` VALUES(157, 5472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Garpike*/
INSERT INTO `fishing_group` VALUES(157, 5467, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Megalodon*/
INSERT INTO `fishing_group` VALUES(157, 4384, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Black Sole*/
INSERT INTO `fishing_group` VALUES(157, 5473, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Bastore Sweeper*/
INSERT INTO `fishing_group` VALUES(157, 14242, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0'); /*Rusty Subligar*/

-- East Ronfaure [S] - Whole Zone
INSERT INTO `fishing_group` VALUES(158, 4472, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Crayfish*/
INSERT INTO `fishing_group` VALUES(158, 4379, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Cheval Salmon*/
INSERT INTO `fishing_group` VALUES(158, 4426, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Tricolored Carp*/
INSERT INTO `fishing_group` VALUES(158, 4354, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Shining Trout*/
INSERT INTO `fishing_group` VALUES(158, 4427, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Gold Carp*/
INSERT INTO `fishing_group` VALUES(158, 13454, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');/*Copper Ring*/
-- //END


--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_group`
--
ALTER TABLE `fishing_group`
  ADD PRIMARY KEY (`groupid`,`fishid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

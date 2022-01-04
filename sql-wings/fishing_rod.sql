-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:10 PM
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
-- Table structure for table `fishing_rod`
--

DROP TABLE IF EXISTS `fishing_rod`;
CREATE TABLE `fishing_rod` (
  `rodid` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `material` tinyint(2) UNSIGNED NOT NULL,
  `size_type` tinyint(3) UNSIGNED NOT NULL,
  `flags` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `durability` tinyint(3) UNSIGNED NOT NULL DEFAULT 10,
  `fish_attack` tinyint(3) UNSIGNED NOT NULL,
  `lgd_bonus_attack` tinyint(3) UNSIGNED NOT NULL,
  `miss_regen` tinyint(3) UNSIGNED NOT NULL,
  `lgd_miss_regen` tinyint(3) UNSIGNED NOT NULL,
  `fish_time` tinyint(3) UNSIGNED NOT NULL,
  `lgd_bonus_time` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `sm_delay_bonus` tinyint(2) UNSIGNED NOT NULL,
  `sm_move_bonus` tinyint(2) UNSIGNED NOT NULL,
  `lg_delay_bonus` tinyint(2) UNSIGNED NOT NULL,
  `lg_move_bonus` tinyint(2) UNSIGNED NOT NULL,
  `multiplier` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `breakable` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `broken_rodid` int(10) UNSIGNED NOT NULL,
  `mmm` tinyint(2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fishing_rod`
--

INSERT INTO `fishing_rod` VALUES(17011, 'Ebisu Fishing Rod', 1, 2, 4, 40, 0, 50, 50, 125, 30, 10, 2, 1, 1, 0, 3, 0, 0, 0);
INSERT INTO `fishing_rod` VALUES(17012, 'Judges Rod', 1, 2, 0, 50, 100, 100, 10, 50, 60, 30, 2, 1, 1, 0, 5, 0, 0, 0);
INSERT INTO `fishing_rod` VALUES(17014, 'Hume Fishing Rod', 0, 0, 2, 22, 25, 0, 90, 0, 30, 0, 2, 1, 0, 2, 3, 1, 1832, 0);
INSERT INTO `fishing_rod` VALUES(17015, 'Halcyon Rod', 1, 0, 2, 26, 0, 0, 50, 0, 41, 0, 2, 1, 0, 2, 3, 1, 1833, 0);
INSERT INTO `fishing_rod` VALUES(17380, 'Mithran Fishing Rod', 0, 1, 1, 32, 30, 0, 65, 0, 30, 0, 0, 0, 1, 0, 3, 1, 483, 0);
INSERT INTO `fishing_rod` VALUES(17381, 'Composite Fishing Rod', 1, 1, 1, 34, 0, 0, 50, 0, 43, 0, 0, 0, 1, 0, 2, 1, 473, 0);
INSERT INTO `fishing_rod` VALUES(17382, 'Single Hook Fishing Rod', 1, 1, 1, 30, 0, 0, 50, 0, 45, 0, 0, 0, 1, 0, 3, 1, 472, 0);
INSERT INTO `fishing_rod` VALUES(17383, 'Clothespole', 0, 1, 1, 28, 30, 0, 70, 0, 30, 0, 0, 0, 1, 0, 3, 1, 482, 0);
INSERT INTO `fishing_rod` VALUES(17384, 'Carbon Fishing Rod', 1, 0, 0, 25, 0, 0, 50, 0, 43, 0, 2, 1, 1, 0, 4, 1, 490, 0);
INSERT INTO `fishing_rod` VALUES(17385, 'Glass Fiber Fishing Rod', 1, 0, 0, 24, 0, 0, 50, 0, 45, 0, 2, 1, 1, 0, 4, 1, 491, 0);
INSERT INTO `fishing_rod` VALUES(17386, 'Lu Shang\'s Fishing Rod', 0, 2, 0, 38, 10, 20, 120, 110, 40, 10, 2, 1, 1, 0, 2, 1, 489, 0);
INSERT INTO `fishing_rod` VALUES(17387, 'Tarutaru Fishing Rod', 0, 0, 0, 18, 30, 0, 80, 0, 30, 0, 2, 1, 1, 0, 4, 1, 484, 0);
INSERT INTO `fishing_rod` VALUES(17388, 'Fastwater Fishing Rod', 0, 0, 0, 16, 35, 0, 75, 0, 30, 0, 2, 1, 1, 0, 2, 1, 488, 0);
INSERT INTO `fishing_rod` VALUES(17389, 'Bamboo Fishing Rod', 0, 0, 0, 14, 40, 0, 70, 0, 30, 0, 2, 1, 1, 0, 2, 1, 487, 0);
INSERT INTO `fishing_rod` VALUES(17390, 'Yew Fishing Rod', 0, 0, 0, 10, 45, 0, 55, 0, 30, 0, 2, 1, 1, 0, 2, 1, 486, 0);
INSERT INTO `fishing_rod` VALUES(17391, 'Willow Fishing Rod', 0, 0, 0, 12, 50, 0, 50, 0, 30, 0, 2, 1, 1, 0, 2, 1, 485, 0);
INSERT INTO `fishing_rod` VALUES(19319, 'Maze Monger Fishing Rod', 1, 2, 0, 30, 0, 0, 100, 0, 30, 0, 2, 1, 1, 10, 2, 1, 2526, 1);
INSERT INTO `fishing_rod` VALUES(19320, 'Lu Shang\'s Fishing Rod +1', 0, 2, 0, 38, 10, 20, 120, 110, 50, 10, 2, 1, 1, 0, 2, 1, 9091, 0);
INSERT INTO `fishing_rod` VALUES(19321, 'Ebisu Fishing Rod +1', 1, 2, 4, 40, 0, 50, 50, 125, 40, 10, 2, 1, 1, 0, 3, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_rod`
--
ALTER TABLE `fishing_rod`
  ADD PRIMARY KEY (`rodid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

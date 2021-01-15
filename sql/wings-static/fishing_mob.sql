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
-- Table structure for table `fishing_mob`
--

DROP TABLE IF EXISTS `fishing_mob`;
CREATE TABLE `fishing_mob` (
  `mobid` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `zoneid` smallint(5) UNSIGNED NOT NULL,
  `level` tinyint(3) UNSIGNED NOT NULL,
  `size` tinyint(3) UNSIGNED NOT NULL,
  `base_delay` tinyint(2) UNSIGNED NOT NULL,
  `base_move` tinyint(2) UNSIGNED NOT NULL,
  `log` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `quest` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `nm` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `nm_flags` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `areaid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `rarity` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `min_respawn` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `required_lureid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `required_key_item` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `disabled` tinyint(2) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fishing_mob`
--

INSERT INTO `fishing_mob` VALUES(17252353, 'Palm_Crab', 116, 10, 16, 14, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17252354, 'Savanna_Crab', 116, 20, 15, 11, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17252355, 'Mud_Pugil', 116, 30, 16, 10, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17252356, 'Pug_Pugil', 116, 40, 17, 9, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17252357, 'Fighting_Pugil', 116, 50, 19, 8, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17396141, 'Odontotyrannus', 151, 20, 15, 10, 15, 0, 91, 1, 0, 1, 0, 0, 17001, 0, 0);
INSERT INTO `fishing_mob` VALUES(17489921, 'Scavenger Crab', 174, 20, 15, 11, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17489922, 'Scavenger Crab', 174, 20, 15, 11, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17489923, 'Stygian Pugil', 174, 30, 16, 10, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17489924, 'Stygian Pugil', 174, 30, 16, 10, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17489925, 'Devil Manta', 174, 50, 19, 8, 15, 255, 255, 1, 106, 1, 0, 600, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17678337, 'Sea Pugil', 220, 10, 16, 14, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17678338, 'Ocean Crab', 220, 40, 17, 9, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17678339, 'Ocean Pugil', 220, 30, 16, 10, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17678340, 'Pirate Pugil', 220, 40, 17, 9, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17682433, 'Sea Pugil', 221, 10, 16, 14, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17682434, 'Ocean Crab', 221, 40, 17, 9, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17682435, 'Ocean Pugil', 221, 30, 16, 10, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `fishing_mob` VALUES(17682436, 'Pirate Pugil', 221, 40, 17, 9, 15, 255, 255, 0, 0, 0, 0, 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_mob`
--
ALTER TABLE `fishing_mob`
  ADD PRIMARY KEY (`mobid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 11:23 AM
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
-- Table structure for table `automaton_spells`
--

DROP TABLE IF EXISTS `automaton_spells`;
CREATE TABLE `automaton_spells` (
  `spellid` smallint(4) UNSIGNED NOT NULL,
  `skilllevel` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `heads` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `enfeeble` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `immunity` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `removes` int(6) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM AVG_ROW_LENGTH=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `automaton_spells`
--

INSERT INTO `automaton_spells` VALUES(1, 12, 31, 0, 0, 136129);
INSERT INTO `automaton_spells` VALUES(2, 45, 31, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(3, 81, 31, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(4, 147, 31, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(5, 207, 16, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(14, 27, 16, 0, 0, 3);
INSERT INTO `automaton_spells` VALUES(15, 36, 16, 0, 0, 4);
INSERT INTO `automaton_spells` VALUES(16, 45, 16, 0, 0, 5);
INSERT INTO `automaton_spells` VALUES(17, 60, 16, 0, 0, 6);
INSERT INTO `automaton_spells` VALUES(18, 120, 16, 0, 0, 7);
INSERT INTO `automaton_spells` VALUES(19, 105, 16, 0, 0, 2079);
INSERT INTO `automaton_spells` VALUES(20, 90, 16, 0, 0, 594974);
INSERT INTO `automaton_spells` VALUES(23, 0, 61, 134, 0, 0);
INSERT INTO `automaton_spells` VALUES(24, 96, 61, 134, 0, 0);
INSERT INTO `automaton_spells` VALUES(56, 42, 61, 13, 128, 0);
INSERT INTO `automaton_spells` VALUES(58, 21, 61, 4, 32, 0);
INSERT INTO `automaton_spells` VALUES(59, 57, 61, 6, 16, 0);
INSERT INTO `automaton_spells` VALUES(108, 66, 16, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(110, 135, 16, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(111, 232, 16, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(144, 60, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(145, 153, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(146, 251, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(147, 281, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(149, 75, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(150, 178, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(151, 256, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(152, 286, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(154, 45, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(155, 138, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(156, 246, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(157, 276, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(159, 15, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(160, 108, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(161, 227, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(162, 266, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(164, 90, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(165, 203, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(166, 261, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(169, 30, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(170, 123, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(171, 236, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(172, 271, 40, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(220, 18, 61, 3, 256, 0);
INSERT INTO `automaton_spells` VALUES(230, 33, 61, 135, 0, 0);
INSERT INTO `automaton_spells` VALUES(231, 111, 61, 135, 0, 0);
INSERT INTO `automaton_spells` VALUES(245, 45, 32, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(247, 78, 32, 0, 0, 0);
INSERT INTO `automaton_spells` VALUES(254, 27, 61, 5, 64, 0);
INSERT INTO `automaton_spells` VALUES(270, 120, 32, 140, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `automaton_spells`
--
ALTER TABLE `automaton_spells`
  ADD PRIMARY KEY (`spellid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

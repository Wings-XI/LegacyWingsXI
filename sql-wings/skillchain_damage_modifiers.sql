-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:31 PM
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
-- Table structure for table `skillchain_damage_modifiers`
--

DROP TABLE IF EXISTS `skillchain_damage_modifiers`;
CREATE TABLE `skillchain_damage_modifiers` (
  `chain_level` enum('1','2','3','4') NOT NULL DEFAULT '1',
  `chain_count` enum('1','2','3','4','5') NOT NULL DEFAULT '1',
  `initial_modifier` int(3) NOT NULL DEFAULT 1,
  `magic_burst_modifier` int(3) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `skillchain_damage_modifiers`
--

INSERT INTO `skillchain_damage_modifiers` VALUES('1', '1', 500, 1300);
INSERT INTO `skillchain_damage_modifiers` VALUES('1', '2', 600, 1350);
INSERT INTO `skillchain_damage_modifiers` VALUES('1', '3', 700, 1400);
INSERT INTO `skillchain_damage_modifiers` VALUES('1', '4', 800, 1450);
INSERT INTO `skillchain_damage_modifiers` VALUES('1', '5', 900, 1500);
INSERT INTO `skillchain_damage_modifiers` VALUES('2', '1', 600, 1300);
INSERT INTO `skillchain_damage_modifiers` VALUES('2', '2', 750, 1350);
INSERT INTO `skillchain_damage_modifiers` VALUES('2', '3', 1000, 1400);
INSERT INTO `skillchain_damage_modifiers` VALUES('2', '4', 1250, 1450);
INSERT INTO `skillchain_damage_modifiers` VALUES('2', '5', 1500, 1500);
INSERT INTO `skillchain_damage_modifiers` VALUES('3', '1', 1000, 1300);
INSERT INTO `skillchain_damage_modifiers` VALUES('3', '2', 1500, 1350);
INSERT INTO `skillchain_damage_modifiers` VALUES('3', '3', 1750, 1400);
INSERT INTO `skillchain_damage_modifiers` VALUES('3', '4', 2000, 1450);
INSERT INTO `skillchain_damage_modifiers` VALUES('3', '5', 2250, 1500);
INSERT INTO `skillchain_damage_modifiers` VALUES('4', '1', 1000, 1300);
INSERT INTO `skillchain_damage_modifiers` VALUES('4', '2', 1500, 1350);
INSERT INTO `skillchain_damage_modifiers` VALUES('4', '3', 1750, 1400);
INSERT INTO `skillchain_damage_modifiers` VALUES('4', '4', 2000, 1450);
INSERT INTO `skillchain_damage_modifiers` VALUES('4', '5', 2250, 1500);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `skillchain_damage_modifiers`
--
ALTER TABLE `skillchain_damage_modifiers`
  ADD PRIMARY KEY (`chain_level`,`chain_count`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

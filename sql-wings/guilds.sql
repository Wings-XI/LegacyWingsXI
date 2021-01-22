-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:12 PM
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
-- Table structure for table `guilds`
--

DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds` (
  `id` tinyint(1) UNSIGNED NOT NULL,
  `points_name` varchar(20) NOT NULL
) ENGINE=MyISAM AVG_ROW_LENGTH=13 DEFAULT CHARSET=utf8 PACK_KEYS=1;

--
-- Dumping data for table `guilds`
--

INSERT INTO `guilds` VALUES(0, 'guild_fishing');
INSERT INTO `guilds` VALUES(1, 'guild_woodworking');
INSERT INTO `guilds` VALUES(2, 'guild_smithing');
INSERT INTO `guilds` VALUES(3, 'guild_goldsmithing');
INSERT INTO `guilds` VALUES(4, 'guild_weaving');
INSERT INTO `guilds` VALUES(5, 'guild_leathercraft');
INSERT INTO `guilds` VALUES(6, 'guild_bonecraft');
INSERT INTO `guilds` VALUES(7, 'guild_alchemy');
INSERT INTO `guilds` VALUES(8, 'guild_cooking');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

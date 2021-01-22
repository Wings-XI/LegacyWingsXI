-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:09 PM
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
-- Table structure for table `fishing_lure`
--

DROP TABLE IF EXISTS `fishing_lure`;
CREATE TABLE `fishing_lure` (
  `lureid` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `luretype` tinyint(2) UNSIGNED NOT NULL,
  `maxhook` tinyint(2) UNSIGNED NOT NULL,
  `losable` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `flags` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `mmm` tinyint(2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fishing_lure`
--

INSERT INTO `fishing_lure` VALUES(16992, 'Slice of Bluetail', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16993, 'Peeled Crayfish', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16994, 'Slice of Moat Carp', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16995, 'Rotten Meat', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16996, 'Ball of Sardine Paste', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16997, 'Ball of Crayfish Paste', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16998, 'Ball of Insect Paste', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(16999, 'Ball of Trout Paste', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17000, 'Meatball', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17001, 'Giant Shell Bug', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17002, 'Robber Rig', 1, 1, 1, 4, 0);
INSERT INTO `fishing_lure` VALUES(17005, 'Lufaise Fly', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17006, 'Drill Calamary', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17007, 'Dwarf Pugil', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17008, 'Regular Maze Monger Ball', 1, 1, 1, 0, 1);
INSERT INTO `fishing_lure` VALUES(17009, 'Large Maze Monger Ball', 1, 1, 1, 0, 1);
INSERT INTO `fishing_lure` VALUES(17392, 'Slice of Sardine', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17393, 'Slice of Cod', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17394, 'Peeled Lobster', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17395, 'Lugworm', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17396, 'Little Worm', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17397, 'Shell Bug', 0, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17398, 'Rogue Rig', 1, 1, 1, 2, 0);
INSERT INTO `fishing_lure` VALUES(17399, 'Sabiki Rig', 1, 3, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17400, 'Sinking Minnow', 1, 1, 1, 1, 0);
INSERT INTO `fishing_lure` VALUES(17401, 'Lizard Lure', 1, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17402, 'Shrimp Lure', 1, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17403, 'Frog Lure', 1, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17404, 'Worm Lure', 1, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17405, 'Fly Lure', 1, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(17407, 'Minnow', 1, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(19323, 'Maze Monger Minnow', 2, 1, 1, 0, 1);
INSERT INTO `fishing_lure` VALUES(19324, 'Dried Squid', 2, 1, 1, 0, 0);
INSERT INTO `fishing_lure` VALUES(19326, 'Sea Dragon Liver', 0, 1, 1, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_lure`
--
ALTER TABLE `fishing_lure`
  ADD PRIMARY KEY (`lureid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

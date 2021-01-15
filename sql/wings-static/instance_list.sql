-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:15 PM
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
-- Table structure for table `instance_list`
--

DROP TABLE IF EXISTS `instance_list`;
CREATE TABLE `instance_list` (
  `instanceid` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `instance_name` varchar(35) NOT NULL DEFAULT '',
  `entrance_zone` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `time_limit` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `start_x` float(7,3) NOT NULL DEFAULT 0.000,
  `start_y` float(7,3) NOT NULL DEFAULT 0.000,
  `start_z` float(7,3) NOT NULL DEFAULT 0.000,
  `start_rot` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `music_day` smallint(3) NOT NULL DEFAULT -1,
  `music_night` smallint(3) NOT NULL DEFAULT -1,
  `battlesolo` smallint(3) NOT NULL DEFAULT -1,
  `battlemulti` smallint(3) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `instance_list`
--

INSERT INTO `instance_list` VALUES(0, 'TEST', 0, 0, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(1, 'leujaoam_cleansing', 79, 30, 280.000, -7.500, 35.000, 195, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(12, 'preemptive_strike', 52, 30, -60.350, -5.000, 27.670, 46, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(21, 'excavation_duty', 61, 30, 124.999, -39.309, 19.999, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(23, 'troll_fugitives', 61, 30, -459.912, -9.860, 342.319, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(32, 'requiem', 79, 30, -458.409, -10.000, -320.966, 90, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(41, 'golden_salvage', 54, 30, 386.000, -12.000, 17.000, 46, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(43, 'extermination', 54, 30, 298.099, -3.943, 135.234, 149, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(53, 'the_black_coffin', 54, 30, 0.000, -22.000, 24.000, 64, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(54, 'against_all_odds', 54, 30, -9.000, -22.000, 17.000, 252, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(58, 'path_of_darkness', 72, 30, 500.000, 0.000, -572.000, 192, 143, 143, 143, 143);
INSERT INTO `instance_list` VALUES(59, 'nashmeira\'s_plea', 72, 45, -444.000, -4.000, 420.000, 127, 143, 143, 143, 143);
INSERT INTO `instance_list` VALUES(65, 'arrapago_remnants', 72, 100, 340.000, 0.000, -246.000, 63, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(79, 'shades_of_vengeance', 79, 30, 127.000, -15.000, -303.000, 0, -1, -1, -1, -1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `instance_list`
--
ALTER TABLE `instance_list`
  ADD PRIMARY KEY (`instanceid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

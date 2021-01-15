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
-- Table structure for table `fishing_log`
--

DROP TABLE IF EXISTS `fishing_log`;
CREATE TABLE `fishing_log` (
  `logid` int(11) NOT NULL,
  `zone` smallint(4) NOT NULL DEFAULT 0,
  `area` tinyint(2) NOT NULL DEFAULT 0,
  `charid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `charname` varchar(15) NOT NULL,
  `charlevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `charskill` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `catchtype` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `catchid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `catchname` tinytext NOT NULL,
  `catchskill` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `regen` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `catchtime` datetime NOT NULL DEFAULT current_timestamp(),
  `ip` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_log`
--
ALTER TABLE `fishing_log`
  ADD PRIMARY KEY (`logid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fishing_log`
--
ALTER TABLE `fishing_log`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

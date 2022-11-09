-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:00 PM
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
-- Table structure for table `char_effects`
--

DROP TABLE IF EXISTS `char_effects`;
CREATE TABLE `char_effects` (
  `charid` int(10) UNSIGNED NOT NULL,
  `effectid` smallint(5) UNSIGNED NOT NULL,
  `icon` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `power` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `tick` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `duration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `subid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `subpower` smallint(5) NOT NULL DEFAULT 0,
  `tier` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `flags` int(8) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_effects`
--
ALTER TABLE `char_effects`
  ADD KEY `charid` (`charid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:10 PM
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
-- Table structure for table `char_unlocks`
--

DROP TABLE IF EXISTS `char_unlocks`;
CREATE TABLE `char_unlocks` (
  `charid` int(10) UNSIGNED NOT NULL,
  `outpost_sandy` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `outpost_bastok` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `outpost_windy` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `mog_locker` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `runic_portal` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `maw` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `campaign_sandy` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `campaign_bastok` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `campaign_windy` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `homepoints` blob DEFAULT NULL,
  `survivals` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_unlocks`
--
ALTER TABLE `char_unlocks`
  ADD PRIMARY KEY (`charid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

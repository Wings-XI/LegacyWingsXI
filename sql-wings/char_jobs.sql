-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:03 PM
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
-- Table structure for table `char_jobs`
--

DROP TABLE IF EXISTS `char_jobs`;
CREATE TABLE `char_jobs` (
  `charid` int(10) UNSIGNED NOT NULL,
  `unlocked` int(10) UNSIGNED NOT NULL DEFAULT 126,
  `genkai` tinyint(2) UNSIGNED NOT NULL DEFAULT 50,
  `war` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `mnk` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `whm` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `blm` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `rdm` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `thf` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `pld` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `drk` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `bst` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `brd` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `rng` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `sam` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `nin` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `drg` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `smn` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `blu` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `cor` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `pup` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `dnc` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `sch` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `geo` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `run` tinyint(2) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB AVG_ROW_LENGTH=95 DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_jobs`
--
ALTER TABLE `char_jobs`
  ADD PRIMARY KEY (`charid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

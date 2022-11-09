-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:07 PM
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
-- Table structure for table `char_profile`
--

DROP TABLE IF EXISTS `char_profile`;
CREATE TABLE `char_profile` (
  `charid` int(10) UNSIGNED NOT NULL,
  `rank_points` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `rank_sandoria` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `rank_bastok` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `rank_windurst` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `fame_sandoria` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_bastok` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_windurst` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_norg` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_jeuno` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_konschtat` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_tahrongi` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_latheine` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_misareaux` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_vunkerl` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_attohwa` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_altepa` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_grauberg` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_aby_uleguerand` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fame_adoulin` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_profile`
--
ALTER TABLE `char_profile`
  ADD PRIMARY KEY (`charid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

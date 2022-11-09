-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:05 PM
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
-- Table structure for table `char_pet`
--

DROP TABLE IF EXISTS `char_pet`;
CREATE TABLE `char_pet` (
  `charid` int(10) UNSIGNED NOT NULL,
  `wyvernid` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `automatonid` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `unlocked_attachments` blob DEFAULT NULL,
  `equipped_attachments` blob DEFAULT NULL,
  `adventuringfellowid` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `chocoboid` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_pet`
--
ALTER TABLE `char_pet`
  ADD PRIMARY KEY (`charid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:02 PM
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
-- Table structure for table `char_inventory`
--

DROP TABLE IF EXISTS `char_inventory`;
CREATE TABLE `char_inventory` (
  `charid` int(10) UNSIGNED NOT NULL,
  `location` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `slot` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `itemId` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bazaar` int(8) UNSIGNED NOT NULL DEFAULT 0,
  `signature` varchar(20) NOT NULL DEFAULT '',
  `extra` tinyblob DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=28 DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_inventory`
--
ALTER TABLE `char_inventory`
  ADD PRIMARY KEY (`charid`,`location`,`slot`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

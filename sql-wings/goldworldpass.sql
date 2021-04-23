-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 06, 2021 at 03:49 PM
-- Server version: 10.5.9-MariaDB
-- PHP Version: 5.6.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ffxiwings`
--

-- --------------------------------------------------------

--
-- Table structure for table `goldworldpass`
--

DROP TABLE IF EXISTS `goldworldpass`;
CREATE TABLE IF NOT EXISTS `goldworldpass` (
  `passid` varchar(16) NOT NULL,
  `creator_contentid` int(10) unsigned NOT NULL,
  `creator_charid` int(10) unsigned NOT NULL,
  `creation_time` datetime NOT NULL DEFAULT current_timestamp(),
  `expiry_time` timestamp NULL DEFAULT NULL,
  `user_contentid` int(10) unsigned DEFAULT NULL,
  `user_charid` int(10) unsigned DEFAULT NULL,
  `usage_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `goldworldpass`
--
ALTER TABLE `goldworldpass`
  ADD PRIMARY KEY (`passid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 11:20 AM
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
SET FOREIGN_KEY_CHECKS=0;
-- --------------------------------------------------------

--
-- Table structure for table `accounts_sessions`
--

DROP TABLE IF EXISTS `accounts_sessions`;
CREATE TABLE `accounts_sessions` (
  `accid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `content_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `charid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `targid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `linkshellid1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `linkshellrank1` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `linkshellid2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `linkshellrank2` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `session_key` binary(20) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `server_addr` int(10) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `server_port` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `client_addr` int(10) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `client_port` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `version_mismatch` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `FLsentnotif` tinyint(2) UNSIGNED DEFAULT 0,
  `client_version` varchar(16) DEFAULT NULL,
  `expansions` smallint(6) NOT NULL DEFAULT 0,
  `features` tinyint(4) NOT NULL DEFAULT 0,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`charid`),
  UNIQUE KEY `accid` (`accid`),
  UNIQUE KEY `content_id` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

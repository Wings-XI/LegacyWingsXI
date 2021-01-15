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

-- --------------------------------------------------------

--
-- Table structure for table `accounts_sessions`
--

DROP TABLE IF EXISTS `accounts_sessions`;
CREATE TABLE `accounts_sessions` (
  `accid` int(10) UNSIGNED NOT NULL DEFAULT 0,
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
  `client_version` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `accounts_sessions`
--
DROP TRIGGER IF EXISTS `session_delete`;
DELIMITER $$
CREATE TRIGGER `session_delete` BEFORE DELETE ON `accounts_sessions` FOR EACH ROW BEGIN
    UPDATE `char_stats` SET zoning = 0 WHERE `charid` = OLD.charid;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_sessions`
--
ALTER TABLE `accounts_sessions`
  ADD PRIMARY KEY (`charid`),
  ADD UNIQUE KEY `accid` (`accid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

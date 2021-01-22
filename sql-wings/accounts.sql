-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 11:18 AM
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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `login` varchar(16) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `current_email` varchar(64) NOT NULL DEFAULT '',
  `registration_email` varchar(64) NOT NULL DEFAULT '',
  `timecreate` datetime NOT NULL DEFAULT current_timestamp(),
  `timelastmodify` timestamp NOT NULL DEFAULT current_timestamp(),
  `content_ids` tinyint(2) UNSIGNED NOT NULL DEFAULT 3,
  `expansions` smallint(4) UNSIGNED NOT NULL DEFAULT 30,
  `features` tinyint(2) UNSIGNED NOT NULL DEFAULT 12,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `priv` tinyint(3) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `accounts`
--
DROP TRIGGER IF EXISTS `account_delete`;
DELIMITER $$
CREATE TRIGGER `account_delete` BEFORE DELETE ON `accounts` FOR EACH ROW BEGIN
    DELETE FROM `accounts_banned` WHERE `accid` = OLD.id;
    DELETE FROM `chars` WHERE `accid` = OLD.id;     
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

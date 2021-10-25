-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 19, 2021 at 09:05 PM
-- Server version: 10.5.9-MariaDB
-- PHP Version: 5.6.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wings`
--

-- --------------------------------------------------------

--
-- Table structure for table `disallowed_names`
--

CREATE TABLE IF NOT EXISTS `disallowed_names` (
  `name` varchar(16) NOT NULL,
  `match_type` smallint(5) unsigned NOT NULL,
  `reason` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `disallowed_names`
--

-- Match type:
-- 1 = Only exact match is disallowed
-- 2 = Disallow any name containing the value as a substring
-- Anything else is completely ignored
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('bastard', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('cunt', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('faggot', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('fuck', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('hitler', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('nazi', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('nigger', 2, NULL);
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('suck', 2, 'Prevent __sucks names');
INSERT INTO `disallowed_names` (`name`, `match_type`, `reason`) VALUES('tits', 2, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `disallowed_names`
--
ALTER TABLE `disallowed_names`
  ADD PRIMARY KEY (`name`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

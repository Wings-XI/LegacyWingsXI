-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 25, 2021 at 11:26 AM
-- Server version: 10.3.12-MariaDB
-- PHP Version: 5.6.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `topaz`
--

-- --------------------------------------------------------

--
-- Table structure for table `server_gmcalls`
--

DROP TABLE IF EXISTS `server_gmcalls`;
CREATE TABLE IF NOT EXISTS `server_gmcalls` (
  `callid` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  `charname` varchar(16) NOT NULL,
  `accid` int(11) NOT NULL,
  `timesubmit` datetime NOT NULL DEFAULT current_timestamp(),
  `zoneid` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `version` varchar(128) NOT NULL,
  `message` varchar(1024) NOT NULL,
  `harassment` tinyint(4) NOT NULL,
  `stuck` tinyint(4) NOT NULL,
  `blocked` tinyint(4) NOT NULL,
  `assignee` varchar(16) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `server_gmcalls`
--
ALTER TABLE `server_gmcalls`
  ADD PRIMARY KEY (`callid`), ADD KEY `charid` (`charid`), ADD KEY `charname` (`charname`), ADD KEY `accid` (`accid`), ADD KEY `timesubmit` (`timesubmit`), ADD KEY `status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `server_gmcalls`
--
ALTER TABLE `server_gmcalls`
  MODIFY `callid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

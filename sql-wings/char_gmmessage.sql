-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 25, 2021 at 11:27 AM
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
-- Table structure for table `char_gmmessage`
--

DROP TABLE IF EXISTS `char_gmmessage`;
CREATE TABLE IF NOT EXISTS `char_gmmessage` (
  `messageid` int(11) NOT NULL,
  `callid` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  `accid` int(11) NOT NULL,
  `gmid` int(11) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `message` varchar(1024) NOT NULL,
  `read` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_gmmessage`
--
ALTER TABLE `char_gmmessage`
  ADD PRIMARY KEY (`messageid`), ADD KEY `callid` (`callid`), ADD KEY `charid` (`charid`), ADD KEY `datetime` (`datetime`), ADD KEY `read` (`read`), ADD KEY `accid` (`accid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `char_gmmessage`
--
ALTER TABLE `char_gmmessage`
  MODIFY `messageid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 10, 2021 at 12:35 PM
-- Server version: 10.5.9-MariaDB
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
-- Table structure for table `trade_log`
--

DROP TABLE IF EXISTS `trade_log`;
CREATE TABLE IF NOT EXISTS `trade_log` (
  `id` int(10) unsigned NOT NULL,
  `trade_id` int(10) unsigned NOT NULL,
  `sender_id` int(10) unsigned NOT NULL,
  `sender_name` varchar(16) NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  `receiver_name` varchar(16) NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `stack` tinyint(4) NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `trade_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trade_log`
--
ALTER TABLE `trade_log`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trade_log`
--
ALTER TABLE `trade_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

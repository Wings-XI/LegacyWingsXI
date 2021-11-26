-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 26, 2021 at 02:59 PM
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
-- Table structure for table `audit_list`
--

DROP TABLE IF EXISTS `audit_list`;
CREATE TABLE IF NOT EXISTS `audit_list` (
  `id` int(10) unsigned NOT NULL,
  `entity_type` int(10) unsigned NOT NULL,
  `entity_name` varchar(24) DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL,
  `reason` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_list`
--
ALTER TABLE `audit_list`
  ADD PRIMARY KEY (`id`), ADD KEY `entity_type` (`entity_type`), ADD KEY `entity_name` (`entity_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_list`
--
ALTER TABLE `audit_list`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

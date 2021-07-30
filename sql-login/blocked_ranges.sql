-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2021 at 04:51 AM
-- Server version: 10.5.9-MariaDB
-- PHP Version: 8.0.3

-- IPv4 address ranges which cannot log in or sign
-- up on the website. This is enforced by both the
-- website and the login server.
-- network_address should be a network IP address, i.e.
-- all host bits set to zero, and subnet mask should
-- be in IP notation.
-- For example, to block 192.0.2.0 - 192.0.2.255
-- enter 192.0.2.0 as network_address and 255.255.255.0
-- as subnet mask.

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wings`
--

-- --------------------------------------------------------

--
-- Table structure for table `blocked_ranges`
--

DROP TABLE IF EXISTS `blocked_ranges`;
CREATE TABLE `blocked_ranges` (
  `network_address` varchar(64) NOT NULL,
  `subnet_mask` varchar(64) NOT NULL,
  `reason` varchar(256) NOT NULL DEFAULT 'VPN range'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked_ranges`
--
ALTER TABLE `blocked_ranges`
  ADD KEY `network_address` (`network_address`),
  ADD KEY `subnet_mask` (`subnet_mask`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2021 at 04:54 AM
-- Server version: 10.5.9-MariaDB
-- PHP Version: 8.0.3

-- IPv6 address ranges which sign up on the website.
-- This has no influence on the login server since
-- FFXI has never supported IPv6 and probably never will
-- (send your complaints to SE).
-- network_address should be a network IP address, i.e.
-- all host bits set to zero, and prefix should be
-- an integer from 0 (block the entire world) to 128
-- (block a single IP address).

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
-- Table structure for table `blocked_ranges_v6`
--

DROP TABLE IF EXISTS `blocked_ranges_v6`;
CREATE TABLE `blocked_ranges_v6` (
  `network_address` varchar(64) NOT NULL,
  `prefix` tinyint(3) UNSIGNED NOT NULL,
  `reason` varchar(256) NOT NULL DEFAULT 'VPN range'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked_ranges_v6`
--
ALTER TABLE `blocked_ranges_v6`
  ADD KEY `network_address` (`network_address`),
  ADD KEY `prefix` (`prefix`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

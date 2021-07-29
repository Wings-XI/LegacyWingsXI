-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2021 at 04:48 AM
-- Server version: 10.5.9-MariaDB
-- PHP Version: 8.0.3

-- Any domains on this list cannot be used as an email
-- address for user registrations on the website.
-- This currently affects the Wings website only and
-- has no influence on the login server.

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
-- Table structure for table `blocked_domains`
--

DROP TABLE IF EXISTS `blocked_domains`;
CREATE TABLE `blocked_domains` (
  `domain` varchar(128) NOT NULL,
  `reason` varchar(256) DEFAULT 'Throwaway email accounts'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked_domains`
--
ALTER TABLE `blocked_domains`
  ADD PRIMARY KEY (`domain`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

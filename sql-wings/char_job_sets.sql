-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:03 PM
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
-- Table structure for table `char_job_sets`
--

DROP TABLE IF EXISTS `char_job_sets`;
CREATE TABLE `char_job_sets` (
  `charid` int(11) NOT NULL,
  `job` int(11) NOT NULL,
  `s0` int(11) NOT NULL DEFAULT 0,
  `s1` int(11) NOT NULL DEFAULT 0,
  `s2` int(11) NOT NULL DEFAULT 0,
  `s3` int(11) NOT NULL DEFAULT 0,
  `s4` int(11) NOT NULL DEFAULT 0,
  `s5` int(11) NOT NULL DEFAULT 0,
  `s6` int(11) NOT NULL DEFAULT 0,
  `s7` int(11) NOT NULL DEFAULT 0,
  `s8` int(11) NOT NULL DEFAULT 0,
  `s9` int(11) NOT NULL DEFAULT 0,
  `s10` int(11) NOT NULL DEFAULT 0,
  `s11` int(11) NOT NULL DEFAULT 0,
  `s12` int(11) NOT NULL DEFAULT 0,
  `s13` int(11) NOT NULL DEFAULT 0,
  `s14` int(11) NOT NULL DEFAULT 0,
  `s15` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `char_job_sets`
--
ALTER TABLE `char_job_sets`
  ADD PRIMARY KEY (`charid`,`job`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

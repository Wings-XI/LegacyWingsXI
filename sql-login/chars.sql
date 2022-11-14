-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2021 at 05:15 AM
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
-- Database: `wings`
--

-- --------------------------------------------------------

--
-- Table structure for table `chars`
--

DROP TABLE IF EXISTS `chars`;
CREATE TABLE `chars` (
  `character_id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(16) NOT NULL,
  `world_id` int(10) UNSIGNED NOT NULL,
  `goldworldpass` varchar(16) NOT NULL,
  `main_job` int(10) UNSIGNED NOT NULL,
  `main_job_lv` int(10) UNSIGNED NOT NULL,
  `zone` int(10) UNSIGNED NOT NULL,
  `race` int(10) UNSIGNED NOT NULL,
  `face` int(10) UNSIGNED NOT NULL,
  `hair` int(11) UNSIGNED NOT NULL,
  `head` int(10) UNSIGNED NOT NULL,
  `body` int(10) UNSIGNED NOT NULL,
  `hands` int(10) UNSIGNED NOT NULL,
  `legs` int(10) UNSIGNED NOT NULL,
  `feet` int(10) UNSIGNED NOT NULL,
  `main` int(10) UNSIGNED NOT NULL,
  `sub` int(10) UNSIGNED NOT NULL,
  `size` int(10) UNSIGNED NOT NULL,
  `nation` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chars`
--
ALTER TABLE `chars`
  ADD PRIMARY KEY (`character_id`,`world_id`) USING BTREE,
  ADD UNIQUE KEY `content_id` (`content_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

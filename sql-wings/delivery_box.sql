-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:14 PM
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
-- Table structure for table `delivery_box`
--

DROP TABLE IF EXISTS `delivery_box`;
CREATE TABLE `delivery_box` (
  `charid` int(10) UNSIGNED NOT NULL,
  `charname` varchar(15) NOT NULL,
  `box` tinyint(1) UNSIGNED NOT NULL,
  `slot` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `itemid` smallint(5) UNSIGNED NOT NULL,
  `itemsubid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `quantity` int(10) UNSIGNED NOT NULL,
  `extra` tinyblob DEFAULT NULL,
  `senderid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sender` varchar(15) DEFAULT NULL,
  `received` tinyint(1) NOT NULL DEFAULT 0,
  `sent` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `delivery_box`
--
DROP TRIGGER IF EXISTS `delivery_box_insert`;
DELIMITER $$
CREATE TRIGGER `delivery_box_insert` BEFORE INSERT ON `delivery_box` FOR EACH ROW BEGIN
    SET @slot := 0;
    SELECT MAX(slot) INTO @slot FROM delivery_box WHERE box = NEW.box AND charid = NEW.charid;
    IF NEW.box = 1 THEN
    IF @slot IS NULL OR @slot < 8 THEN SET NEW.slot := 8; ELSE SET NEW.slot := @slot + 1; END IF;
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `delivery_box`
--
ALTER TABLE `delivery_box`
  ADD PRIMARY KEY (`charid`,`box`,`slot`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 11:21 AM
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
-- Table structure for table `auction_house`
--

DROP TABLE IF EXISTS `auction_house`;
CREATE TABLE `auction_house` (
  `id` int(10) UNSIGNED NOT NULL,
  `itemid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `stack` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `seller` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `seller_name` varchar(15) DEFAULT NULL,
  `date` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `buyer_name` varchar(15) DEFAULT NULL,
  `sale` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sell_date` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `auction_house`
--
DROP TRIGGER IF EXISTS `auction_house_buy`;
DELIMITER $$
CREATE TRIGGER `auction_house_buy` BEFORE UPDATE ON `auction_house` FOR EACH ROW BEGIN
    IF OLD.seller != 0 AND NEW.sale != 0 THEN INSERT INTO delivery_box VALUES (NEW.seller, NEW.seller_name, 1, 0, 0xFFFF, NEW.itemid, NEW.sale, NULL, 0, 'AH-Jeuno', 0, 0); END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auction_house`
--
ALTER TABLE `auction_house`
  ADD PRIMARY KEY (`id`),
  ADD KEY `itemid` (`itemid`),
  ADD KEY `charid` (`seller`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auction_house`
--
ALTER TABLE `auction_house`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

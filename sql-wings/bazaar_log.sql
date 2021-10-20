-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 10, 2021 at 12:33 PM
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
-- Table structure for table `bazaar_log`
--

DROP TABLE IF EXISTS `bazaar_log`;
CREATE TABLE IF NOT EXISTS `bazaar_log` (
  `seller_id` int(10) unsigned NOT NULL,
  `seller_name` varchar(16) NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `buyer_name` varchar(16) NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `single_price` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `total_sale` int(10) unsigned NOT NULL,
  `tax` int(10) unsigned NOT NULL,
  `total_paid` int(10) unsigned NOT NULL,
  `purchase_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

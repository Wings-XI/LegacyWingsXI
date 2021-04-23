-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2021 at 06:00 PM
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
-- Table structure for table `worlds`
--

DROP TABLE IF EXISTS `worlds`;
CREATE TABLE `worlds` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(16) NOT NULL,
  `db_server_ip` varchar(40) NOT NULL,
  `db_server_port` int(11) UNSIGNED NOT NULL DEFAULT 3306,
  `db_use_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `db_ssl_verify_cert` tinyint(1) NOT NULL DEFAULT 0,
  `db_ssl_ca_cert` varchar(128) DEFAULT NULL,
  `db_ssl_client_cert` varchar(128) DEFAULT NULL,
  `db_ssl_client_key` varchar(128) DEFAULT NULL,
  `db_username` varchar(128) NOT NULL,
  `db_password` varchar(128) NOT NULL,
  `db_database` varchar(128) NOT NULL,
  `db_prefix` varchar(128) DEFAULT '',
  `mq_server_ip` varchar(40) NOT NULL DEFAULT '127.0.0.1',
  `mq_server_port` int(10) UNSIGNED NOT NULL DEFAULT 5672,
  `mq_use_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `mq_ssl_verify_cert` tinyint(1) NOT NULL DEFAULT 0,
  `mq_ssl_ca_cert` varchar(128) DEFAULT NULL,
  `mq_ssl_client_cert` varchar(128) DEFAULT NULL,
  `mq_ssl_client_key` varchar(128) DEFAULT NULL,
  `mq_username` varchar(128) NOT NULL DEFAULT 'guest',
  `mq_password` varchar(128) NOT NULL DEFAULT 'guest',
  `mq_vhost` varchar(128) NOT NULL DEFAULT '/',
  `search_ip` varchar(40) NOT NULL,
  `search_port` int(6) UNSIGNED NOT NULL,
  `has_flist` tinyint(4) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_test` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `worlds`
--

INSERT INTO `worlds` (`id`, `name`, `db_server_ip`, `db_server_port`, `db_use_ssl`, `db_ssl_verify_cert`, `db_ssl_ca_cert`, `db_ssl_client_cert`, `db_ssl_client_key`, `db_username`, `db_password`, `db_database`, `db_prefix`, `mq_server_ip`, `mq_server_port`, `mq_use_ssl`, `mq_ssl_verify_cert`, `mq_ssl_ca_cert`, `mq_ssl_client_cert`, `mq_ssl_client_key`, `mq_username`, `mq_password`, `mq_vhost`, `search_ip`, `search_port`, `has_flist`, `is_active`, `is_test`) VALUES
(100, 'Wingslocal', '127.0.0.1', 3306, 0, 0, '', '', '', 'wings', 'wings', 'wings', '', '127.0.0.1', 5672, 0, 0, NULL, NULL, NULL, 'wings', 'wings', 'wings', '127.0.0.1', 54002, 1, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `worlds`
--
ALTER TABLE `worlds`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

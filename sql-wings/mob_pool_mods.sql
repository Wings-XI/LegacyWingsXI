-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:26 PM
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
-- Table structure for table `mob_pool_mods`
--

DROP TABLE IF EXISTS `mob_pool_mods`;
CREATE TABLE `mob_pool_mods` (
  `poolid` smallint(5) UNSIGNED NOT NULL,
  `modid` smallint(5) UNSIGNED NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT 0,
  `is_mob_mod` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM AVG_ROW_LENGTH=13 DEFAULT CHARSET=utf8 PACK_KEYS=1;

--
-- Dumping data for table `mob_pool_mods`
--

INSERT INTO `mob_pool_mods` VALUES(21, 29, 0, 0);
INSERT INTO `mob_pool_mods` VALUES(44, 368, 150, 0);
INSERT INTO `mob_pool_mods` VALUES(60, 370, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(70, 48, 434, 1);
INSERT INTO `mob_pool_mods` VALUES(154, 163, -70, 0);
INSERT INTO `mob_pool_mods` VALUES(181, 1, 6000, 1);
INSERT INTO `mob_pool_mods` VALUES(181, 2, 9234, 1);
INSERT INTO `mob_pool_mods` VALUES(236, 30, 732, 1);
INSERT INTO `mob_pool_mods` VALUES(236, 33, 60, 1);
INSERT INTO `mob_pool_mods` VALUES(237, 44, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(242, 40, 30, 1);
INSERT INTO `mob_pool_mods` VALUES(242, 41, 936, 1);
INSERT INTO `mob_pool_mods` VALUES(242, 42, 962, 1);
INSERT INTO `mob_pool_mods` VALUES(242, 43, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(242, 47, 22, 1);
INSERT INTO `mob_pool_mods` VALUES(268, 368, 150, 0);
INSERT INTO `mob_pool_mods` VALUES(268, 370, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(289, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(370, 28, 5, 1);
INSERT INTO `mob_pool_mods` VALUES(410, 236, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(459, 23, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(459, 73, 25, 0);
INSERT INTO `mob_pool_mods` VALUES(459, 430, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(519, 160, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(532, 160, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(592, 68, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(592, 302, 45, 0);
INSERT INTO `mob_pool_mods` VALUES(592, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(639, 63, 25, 0);
INSERT INTO `mob_pool_mods` VALUES(676, 160, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(680, 1, 322, 0);
INSERT INTO `mob_pool_mods` VALUES(680, 31, 200, 0);
INSERT INTO `mob_pool_mods` VALUES(680, 251, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(681, 368, 10, 0);
INSERT INTO `mob_pool_mods` VALUES(723, 3, 500, 1);
INSERT INTO `mob_pool_mods` VALUES(723, 34, 30, 1);
INSERT INTO `mob_pool_mods` VALUES(733, 302, 5, 0);
INSERT INTO `mob_pool_mods` VALUES(763, 62, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(768, 28, 5, 1);
INSERT INTO `mob_pool_mods` VALUES(770, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(820, 368, 10, 0);
INSERT INTO `mob_pool_mods` VALUES(882, 62, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(906, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(930, 370, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(955, 28, -100, 1);
INSERT INTO `mob_pool_mods` VALUES(958, 28, 5, 1);
INSERT INTO `mob_pool_mods` VALUES(978, 28, 23, 1);
INSERT INTO `mob_pool_mods` VALUES(979, 8, 60, 1);
INSERT INTO `mob_pool_mods` VALUES(979, 9, 60, 1);
INSERT INTO `mob_pool_mods` VALUES(1013, 28, -100, 1);
INSERT INTO `mob_pool_mods` VALUES(1178, 163, -100, 0);
INSERT INTO `mob_pool_mods` VALUES(1234, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(1270, 39, -1, 1);
INSERT INTO `mob_pool_mods` VALUES(1280, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(1306, 4, 30, 1);
INSERT INTO `mob_pool_mods` VALUES(1429, 28, 10, 1);
INSERT INTO `mob_pool_mods` VALUES(1456, 368, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(1461, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(1491, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(1648, 224, 5, 0);
INSERT INTO `mob_pool_mods` VALUES(1648, 17, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(1663, 29, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(1719, 29, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(1750, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(1754, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(1792, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(1806, 28, 10, 1);
INSERT INTO `mob_pool_mods` VALUES(1841, 28, 10, 1);
 -- Henchman Moogle BLM
INSERT INTO `mob_pool_mods` VALUES(1931, 368, 100, 0); -- Regain
 -- Henchman Moogle WHM
INSERT INTO `mob_pool_mods` VALUES(6938, 368, 200, 0); -- Regain
INSERT INTO `mob_pool_mods` VALUES(6938, 387, -100, 0); -- UDMGPHYS
INSERT INTO `mob_pool_mods` VALUES(6938, 388, -100, 0); -- UDMGBREATH
INSERT INTO `mob_pool_mods` VALUES(6938, 389, -100, 0); -- UDMGMAGIC
INSERT INTO `mob_pool_mods` VALUES(6938, 390, -100, 0); -- UDMGRANGE

INSERT INTO `mob_pool_mods` VALUES(2032, 244, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(2032, 34, 20, 1);
INSERT INTO `mob_pool_mods` VALUES(2032, 35, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(2047, 163, -100, 0);
INSERT INTO `mob_pool_mods` VALUES(2083, 29, 0, 0);
INSERT INTO `mob_pool_mods` VALUES(2105, 48, 434, 1);
INSERT INTO `mob_pool_mods` VALUES(2156, 370, 25, 0);
INSERT INTO `mob_pool_mods` VALUES(2180, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(2254, 407, 100, 0);
INSERT INTO `mob_pool_mods` VALUES(2255, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(2255, 3, 500, 1);
INSERT INTO `mob_pool_mods` VALUES(2255, 34, 60, 1);
INSERT INTO `mob_pool_mods` VALUES(2262, 370, 125, 0);
INSERT INTO `mob_pool_mods` VALUES(2265, 368, 150, 0);
INSERT INTO `mob_pool_mods` VALUES(2265, 370, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(2271, 64, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(2271, 65, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(2271, 165, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(2314, 28, 23, 1);
INSERT INTO `mob_pool_mods` VALUES(2420, 302, 10, 0);
INSERT INTO `mob_pool_mods` VALUES(2461, 61, 25, 1);
INSERT INTO `mob_pool_mods` VALUES(2462, 61, 25, 1);
INSERT INTO `mob_pool_mods` VALUES(2463, 61, 20, 1);
INSERT INTO `mob_pool_mods` VALUES(2614, 368, 100, 0);
INSERT INTO `mob_pool_mods` VALUES(2643, 160, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(2647, 160, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(2664, 12, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(2675, 4, 25, 1);
INSERT INTO `mob_pool_mods` VALUES(2677, 288, 55, 0);
INSERT INTO `mob_pool_mods` VALUES(2742, 37, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(2745, 28, 23, 1);
INSERT INTO `mob_pool_mods` VALUES(2748, 370, 5, 0);
INSERT INTO `mob_pool_mods` VALUES(2790, 168, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(2790, 240, 7, 0);
INSERT INTO `mob_pool_mods` VALUES(2790, 244, 7, 0);
INSERT INTO `mob_pool_mods` VALUES(2793, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(2804, 302, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(2840, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(2840, 370, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(2922, 370, 35, 0);
INSERT INTO `mob_pool_mods` VALUES(2973, 370, 1, 0);
INSERT INTO `mob_pool_mods` VALUES(3051, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(3124, 48, 434, 1);
INSERT INTO `mob_pool_mods` VALUES(3129, 370, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(3168, 28, 10, 1);
INSERT INTO `mob_pool_mods` VALUES(3208, 370, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(3245, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3252, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3257, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3262, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3264, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3265, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3268, 56, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3301, 29, 0, 0);
INSERT INTO `mob_pool_mods` VALUES(3379, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(3426, 73, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3540, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(3549, 370, 50, 0);
INSERT INTO `mob_pool_mods` VALUES(3598, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(3598, 44, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(3600, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(3601, 368, 70, 0);
INSERT INTO `mob_pool_mods` VALUES(3759, 163, -100, 0);
INSERT INTO `mob_pool_mods` VALUES(3781, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(3784, 2, -1, 1);
INSERT INTO `mob_pool_mods` VALUES(3784, 28, -100, 1);
INSERT INTO `mob_pool_mods` VALUES(3796, 21, 97, 1);
INSERT INTO `mob_pool_mods` VALUES(3816, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(3824, 29, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(3853, 28, 23, 1);
INSERT INTO `mob_pool_mods` VALUES(3916, 29, 0, 0);
INSERT INTO `mob_pool_mods` VALUES(3916, 164, -50, 0);
INSERT INTO `mob_pool_mods` VALUES(3916, 370, 25, 0);
INSERT INTO `mob_pool_mods` VALUES(3941, 163, -100, 0);
INSERT INTO `mob_pool_mods` VALUES(4082, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(4083, 370, 1, 0);
INSERT INTO `mob_pool_mods` VALUES(4186, 244, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(4186, 34, 20, 1);
INSERT INTO `mob_pool_mods` VALUES(4186, 35, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(4187, 244, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(4187, 34, 20, 1);
INSERT INTO `mob_pool_mods` VALUES(4187, 35, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(4188, 244, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(4188, 34, 20, 1);
INSERT INTO `mob_pool_mods` VALUES(4188, 35, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(4189, 244, 15, 0);
INSERT INTO `mob_pool_mods` VALUES(4189, 34, 20, 1);
INSERT INTO `mob_pool_mods` VALUES(4189, 35, 0, 1);
INSERT INTO `mob_pool_mods` VALUES(4204, 28, 10, 1);
INSERT INTO `mob_pool_mods` VALUES(4222, 4, 4, 1);
INSERT INTO `mob_pool_mods` VALUES(4238, 28, 5, 1);
INSERT INTO `mob_pool_mods` VALUES(4261, 29, 0, 0);
INSERT INTO `mob_pool_mods` VALUES(4261, 370, 25, 0);
INSERT INTO `mob_pool_mods` VALUES(4361, 288, 55, 0);
INSERT INTO `mob_pool_mods` VALUES(4361, 5, 16, 1);
INSERT INTO `mob_pool_mods` VALUES(4504, 4, 30, 1);
INSERT INTO `mob_pool_mods` VALUES(4507, 64, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(4670, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(4671, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(4672, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(4673, 3, 100, 1);
INSERT INTO `mob_pool_mods` VALUES(4836, 62, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(4837, 62, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(4932, 30, 1017, 1);
INSERT INTO `mob_pool_mods` VALUES(4932, 33, 50, 1);
INSERT INTO `mob_pool_mods` VALUES(5403, 62, 1, 1);
INSERT INTO `mob_pool_mods` VALUES(5408, 30, 1036, 1);
INSERT INTO `mob_pool_mods` VALUES(5408, 33, 50, 1);
INSERT INTO `mob_pool_mods` VALUES(5408, 58, 40, 1);
INSERT INTO `mob_pool_mods` VALUES(5409, 30, 1036, 1);
INSERT INTO `mob_pool_mods` VALUES(5409, 33, 50, 1);
INSERT INTO `mob_pool_mods` VALUES(5409, 58, 40, 1);
INSERT INTO `mob_pool_mods` VALUES(5536, 34, 60, 1);
INSERT INTO `mob_pool_mods` VALUES(5536, 61, 40, 1);
INSERT INTO `mob_pool_mods` VALUES(3667, 28, -100, 1);
INSERT INTO `mob_pool_mods` VALUES(6187, 1, 2000, 1);
INSERT INTO `mob_pool_mods` VALUES(6187, 2, 13640, 1);
INSERT INTO `mob_pool_mods` VALUES(6188, 1, 10000, 1);
INSERT INTO `mob_pool_mods` VALUES(6188, 2, 30000, 1);
INSERT INTO `mob_pool_mods` VALUES(2401, 10, 20, 0);
INSERT INTO `mob_pool_mods` VALUES(2401, 28, 42, 0);
INSERT INTO `mob_pool_mods` VALUES(2401, 407, 40, 0);
INSERT INTO `mob_pool_mods` VALUES(2401, 11, 16, 1);

-- SELECT * FROM mob_pool_mods WHERE poolid =2401;
--
-- Indexes for dumped tables
--

--
-- Indexes for table `mob_pool_mods`
--
ALTER TABLE `mob_pool_mods`
  ADD PRIMARY KEY (`poolid`,`modid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

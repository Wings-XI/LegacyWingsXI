-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:18 PM
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
-- Table structure for table `item_mods_pet`
--

DROP TABLE IF EXISTS `item_mods_pet`;
CREATE TABLE `item_mods_pet` (
  `itemId` smallint(5) UNSIGNED NOT NULL,
  `modId` smallint(5) UNSIGNED NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT 0,
  `petType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM AVG_ROW_LENGTH=13 DEFAULT CHARSET=utf8 PACK_KEYS=1;

--
-- Dumping data for table `item_mods_pet`
--

INSERT INTO `item_mods_pet` VALUES(10296, 25, 3, 3);
INSERT INTO `item_mods_pet` VALUES(10296, 26, 3, 3);
INSERT INTO `item_mods_pet` VALUES(10296, 30, 3, 3);
INSERT INTO `item_mods_pet` VALUES(10299, 288, 2, 0);
INSERT INTO `item_mods_pet` VALUES(10370, 28, 3, 1);
INSERT INTO `item_mods_pet` VALUES(10370, 30, 3, 1);
INSERT INTO `item_mods_pet` VALUES(10370, 126, 3, 1);
INSERT INTO `item_mods_pet` VALUES(10440, 384, 600, 3);
INSERT INTO `item_mods_pet` VALUES(10530, 28, 5, 1);
INSERT INTO `item_mods_pet` VALUES(10531, 28, 5, 1);
INSERT INTO `item_mods_pet` VALUES(10532, 28, 5, 1);
INSERT INTO `item_mods_pet` VALUES(10537, 23, 9, 1);
INSERT INTO `item_mods_pet` VALUES(10537, 126, 4, 1);
INSERT INTO `item_mods_pet` VALUES(10542, 23, 12, 1);
INSERT INTO `item_mods_pet` VALUES(10542, 126, 5, 1);
INSERT INTO `item_mods_pet` VALUES(10664, 28, 4, 1);
INSERT INTO `item_mods_pet` VALUES(10664, 346, 3, 1);
INSERT INTO `item_mods_pet` VALUES(10684, 165, 6, 1);
INSERT INTO `item_mods_pet` VALUES(10684, 346, 3, 1);
INSERT INTO `item_mods_pet` VALUES(10724, 30, 5, 1);
INSERT INTO `item_mods_pet` VALUES(10744, 562, 5, 1);
INSERT INTO `item_mods_pet` VALUES(10817, 384, 500, 0);
INSERT INTO `item_mods_pet` VALUES(10914, 27, -2, 0);
INSERT INTO `item_mods_pet` VALUES(10915, 27, -3, 0);
INSERT INTO `item_mods_pet` VALUES(10972, 161, -3, 0);
INSERT INTO `item_mods_pet` VALUES(11052, 126, 3, 1);
INSERT INTO `item_mods_pet` VALUES(11098, 126, 10, 1);
INSERT INTO `item_mods_pet` VALUES(11118, 25, 15, 1);
INSERT INTO `item_mods_pet` VALUES(11138, 345, 500, 1);
INSERT INTO `item_mods_pet` VALUES(11158, 30, 5, 1);
INSERT INTO `item_mods_pet` VALUES(11198, 126, 5, 1);
INSERT INTO `item_mods_pet` VALUES(11218, 25, 10, 1);
INSERT INTO `item_mods_pet` VALUES(11238, 345, 250, 1);
INSERT INTO `item_mods_pet` VALUES(11258, 30, 5, 1);
INSERT INTO `item_mods_pet` VALUES(11261, 12, 10, 3);
INSERT INTO `item_mods_pet` VALUES(11261, 13, 10, 3);
INSERT INTO `item_mods_pet` VALUES(11297, 2, 20, 4);
INSERT INTO `item_mods_pet` VALUES(11297, 5, 20, 4);
INSERT INTO `item_mods_pet` VALUES(11297, 2, 24, 5);
INSERT INTO `item_mods_pet` VALUES(11297, 2, 18, 6);
INSERT INTO `item_mods_pet` VALUES(11297, 2, 16, 7);
INSERT INTO `item_mods_pet` VALUES(11297, 5, 24, 7);
INSERT INTO `item_mods_pet` VALUES(11298, 25, 10, 3);
INSERT INTO `item_mods_pet` VALUES(11299, 25, 10, 3);
INSERT INTO `item_mods_pet` VALUES(11338, 25, 3, 0);
INSERT INTO `item_mods_pet` VALUES(11338, 289, 3, 0);
INSERT INTO `item_mods_pet` VALUES(11388, 28, 5, 3);
INSERT INTO `item_mods_pet` VALUES(11389, 28, 5, 3);
INSERT INTO `item_mods_pet` VALUES(11470, 72, 3, 3);
INSERT INTO `item_mods_pet` VALUES(11470, 71, 3, 3);
INSERT INTO `item_mods_pet` VALUES(11471, 370, 1, 3);
INSERT INTO `item_mods_pet` VALUES(11472, 370, 1, 3);
INSERT INTO `item_mods_pet` VALUES(11497, 384, 500, 0);
INSERT INTO `item_mods_pet` VALUES(11531, 73, 3, 0);
INSERT INTO `item_mods_pet` VALUES(11536, 101, 2, 3);
INSERT INTO `item_mods_pet` VALUES(11555, 25, 10, 0);
INSERT INTO `item_mods_pet` VALUES(11564, 28, 1, 1);
INSERT INTO `item_mods_pet` VALUES(11571, 25, 12, 3);
INSERT INTO `item_mods_pet` VALUES(11612, 28, 2, 1);
INSERT INTO `item_mods_pet` VALUES(11617, 288, 2, 0);
INSERT INTO `item_mods_pet` VALUES(11619, 368, 25, 1);
INSERT INTO `item_mods_pet` VALUES(11711, 25, 3, 0);
INSERT INTO `item_mods_pet` VALUES(11720, 23, 2, 3);
INSERT INTO `item_mods_pet` VALUES(11720, 24, 3, 3);
INSERT INTO `item_mods_pet` VALUES(11720, 28, 3, 3);
INSERT INTO `item_mods_pet` VALUES(11739, 27, 2, 1);
INSERT INTO `item_mods_pet` VALUES(11739, 28, 2, 1);
INSERT INTO `item_mods_pet` VALUES(11987, 126, 5, 1);
INSERT INTO `item_mods_pet` VALUES(11987, 370, 1, 1);
INSERT INTO `item_mods_pet` VALUES(12520, 27, -3, 1);
INSERT INTO `item_mods_pet` VALUES(12649, 370, 1, 2);
INSERT INTO `item_mods_pet` VALUES(12650, 27, -2, 1);
INSERT INTO `item_mods_pet` VALUES(13974, 25, 5, 2);
INSERT INTO `item_mods_pet` VALUES(13975, 27, -2, 1);
INSERT INTO `item_mods_pet` VALUES(14103, 27, -2, 1);
INSERT INTO `item_mods_pet` VALUES(14103, 68, 5, 1);
INSERT INTO `item_mods_pet` VALUES(14227, 3, 10, 2);
INSERT INTO `item_mods_pet` VALUES(14228, 25, 10, 1);
INSERT INTO `item_mods_pet` VALUES(14228, 27, -2, 1);
INSERT INTO `item_mods_pet` VALUES(14405, 2, 65, 2);
INSERT INTO `item_mods_pet` VALUES(14405, 72, 65, 2);
INSERT INTO `item_mods_pet` VALUES(14468, 27, 5, 1);
INSERT INTO `item_mods_pet` VALUES(14486, 370, 1, 2);
INSERT INTO `item_mods_pet` VALUES(14514, 165, 4, 1);
INSERT INTO `item_mods_pet` VALUES(14523, 2, 20, 4);
INSERT INTO `item_mods_pet` VALUES(14523, 5, 20, 4);
INSERT INTO `item_mods_pet` VALUES(14523, 2, 24, 5);
INSERT INTO `item_mods_pet` VALUES(14523, 2, 18, 6);
INSERT INTO `item_mods_pet` VALUES(14523, 2, 16, 7);
INSERT INTO `item_mods_pet` VALUES(14523, 5, 24, 7);
INSERT INTO `item_mods_pet` VALUES(14872, 2, 10, 2);
INSERT INTO `item_mods_pet` VALUES(14903, 25, 5, 2);
INSERT INTO `item_mods_pet` VALUES(14904, 27, -2, 1);
INSERT INTO `item_mods_pet` VALUES(14923, 25, 14, 1);
INSERT INTO `item_mods_pet` VALUES(14958, 63, 5, 0);
INSERT INTO `item_mods_pet` VALUES(15031, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(15032, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(15101, 165, 3, 1);
INSERT INTO `item_mods_pet` VALUES(15116, 25, 7, 1);
INSERT INTO `item_mods_pet` VALUES(15146, 23, 7, 1);
INSERT INTO `item_mods_pet` VALUES(15146, 357, -2, 1);
INSERT INTO `item_mods_pet` VALUES(15239, 27, -3, 1);
INSERT INTO `item_mods_pet` VALUES(15267, 72, 3, 3);
INSERT INTO `item_mods_pet` VALUES(15267, 71, 3, 3);
INSERT INTO `item_mods_pet` VALUES(15366, 27, -4, 1);
INSERT INTO `item_mods_pet` VALUES(15366, 68, 5, 1);
INSERT INTO `item_mods_pet` VALUES(15367, 2, 30, 2);
INSERT INTO `item_mods_pet` VALUES(15574, 3, 15, 2);
INSERT INTO `item_mods_pet` VALUES(15575, 25, 14, 1);
INSERT INTO `item_mods_pet` VALUES(15575, 27, -2, 1);
INSERT INTO `item_mods_pet` VALUES(15594, 27, 2, 1);
INSERT INTO `item_mods_pet` VALUES(15602, 374, 5, 3);
INSERT INTO `item_mods_pet` VALUES(15602, 168, 10, 3);
INSERT INTO `item_mods_pet` VALUES(15647, 1, 10, 0);
INSERT INTO `item_mods_pet` VALUES(15649, 1, 10, 0);
INSERT INTO `item_mods_pet` VALUES(15661, 2, 50, 2);
INSERT INTO `item_mods_pet` VALUES(15679, 23, 10, 1);
INSERT INTO `item_mods_pet` VALUES(15679, 27, 2, 1);
INSERT INTO `item_mods_pet` VALUES(15679, 357, -2, 1);
INSERT INTO `item_mods_pet` VALUES(15910, 1, 5, 0);
INSERT INTO `item_mods_pet` VALUES(15910, 27, 3, 0);
INSERT INTO `item_mods_pet` VALUES(15944, 163, -7, 0);
INSERT INTO `item_mods_pet` VALUES(16000, 30, 10, 0);
INSERT INTO `item_mods_pet` VALUES(16173, 1, 10, 0);
INSERT INTO `item_mods_pet` VALUES(16245, 23, 15, 3);
INSERT INTO `item_mods_pet` VALUES(16270, 2, 50, 2);
INSERT INTO `item_mods_pet` VALUES(16297, 161, -2, 0);
INSERT INTO `item_mods_pet` VALUES(16351, 374, 5, 3);
INSERT INTO `item_mods_pet` VALUES(16351, 168, 10, 3);
INSERT INTO `item_mods_pet` VALUES(16352, 30, 5, 3);
INSERT INTO `item_mods_pet` VALUES(16353, 30, 7, 3);
INSERT INTO `item_mods_pet` VALUES(16368, 25, 10, 0);
INSERT INTO `item_mods_pet` VALUES(16654, 368, 10, 0);
INSERT INTO `item_mods_pet` VALUES(16843, 25, 10, 2);
INSERT INTO `item_mods_pet` VALUES(16843, 23, 10, 2);
INSERT INTO `item_mods_pet` VALUES(17579, 2, 50, 2);
INSERT INTO `item_mods_pet` VALUES(17857, 2, 50, 4);
INSERT INTO `item_mods_pet` VALUES(17857, 5, 50, 4);
INSERT INTO `item_mods_pet` VALUES(17857, 2, 60, 5);
INSERT INTO `item_mods_pet` VALUES(17857, 2, 45, 6);
INSERT INTO `item_mods_pet` VALUES(17857, 2, 40, 7);
INSERT INTO `item_mods_pet` VALUES(17857, 5, 60, 7);
INSERT INTO `item_mods_pet` VALUES(17961, 1, 10, 0);
INSERT INTO `item_mods_pet` VALUES(18547, 370, 3, 0);
INSERT INTO `item_mods_pet` VALUES(18584, 1, 10, 1);
INSERT INTO `item_mods_pet` VALUES(18745, 3, 1, 3);
INSERT INTO `item_mods_pet` VALUES(18746, 3, 2, 3);
INSERT INTO `item_mods_pet` VALUES(18778, 369, 1, 3);
INSERT INTO `item_mods_pet` VALUES(18778, 370, 1, 3);
INSERT INTO `item_mods_pet` VALUES(18780, 368, 10, 3);
INSERT INTO `item_mods_pet` VALUES(18791, 2, 30, 3);
INSERT INTO `item_mods_pet` VALUES(18791, 23, 9, 3);
INSERT INTO `item_mods_pet` VALUES(18791, 24, 9, 3);
INSERT INTO `item_mods_pet` VALUES(18792, 2, 40, 3);
INSERT INTO `item_mods_pet` VALUES(18792, 23, 10, 3);
INSERT INTO `item_mods_pet` VALUES(18792, 24, 10, 3);
INSERT INTO `item_mods_pet` VALUES(18999, 23, 40, 0);
INSERT INTO `item_mods_pet` VALUES(19005, 28, 20, 1);
INSERT INTO `item_mods_pet` VALUES(19068, 23, 50, 0);
INSERT INTO `item_mods_pet` VALUES(19074, 28, 25, 1);
INSERT INTO `item_mods_pet` VALUES(19088, 23, 60, 0);
INSERT INTO `item_mods_pet` VALUES(19094, 28, 30, 1);
INSERT INTO `item_mods_pet` VALUES(19620, 23, 70, 0);
INSERT INTO `item_mods_pet` VALUES(19626, 28, 35, 1);
INSERT INTO `item_mods_pet` VALUES(19718, 23, 70, 0);
INSERT INTO `item_mods_pet` VALUES(19724, 28, 35, 1);
INSERT INTO `item_mods_pet` VALUES(19772, 28, 1, 1);
INSERT INTO `item_mods_pet` VALUES(19827, 23, 80, 0);
INSERT INTO `item_mods_pet` VALUES(19833, 28, 40, 1);
INSERT INTO `item_mods_pet` VALUES(19956, 23, 80, 0);
INSERT INTO `item_mods_pet` VALUES(19962, 28, 40, 1);
INSERT INTO `item_mods_pet` VALUES(20792, 23, 80, 0);
INSERT INTO `item_mods_pet` VALUES(20793, 23, 80, 0);
INSERT INTO `item_mods_pet` VALUES(20822, 27, 6, 0);
INSERT INTO `item_mods_pet` VALUES(20822, 68, 40, 0);
INSERT INTO `item_mods_pet` VALUES(20831, 288, 2, 0);
INSERT INTO `item_mods_pet` VALUES(20832, 288, 3, 0);
INSERT INTO `item_mods_pet` VALUES(20944, 370, 2, 2);
INSERT INTO `item_mods_pet` VALUES(20944, 161, 3, 2);
INSERT INTO `item_mods_pet` VALUES(21141, 126, 40, 1);
INSERT INTO `item_mods_pet` VALUES(21142, 126, 40, 1);
INSERT INTO `item_mods_pet` VALUES(21155, 30, 35, 1);
INSERT INTO `item_mods_pet` VALUES(21155, 28, 110, 1);
INSERT INTO `item_mods_pet` VALUES(21155, 126, 3, 1);
INSERT INTO `item_mods_pet` VALUES(21167, 30, 20, 1);
INSERT INTO `item_mods_pet` VALUES(21167, 28, 120, 1);
INSERT INTO `item_mods_pet` VALUES(21167, 27, 10, 1);
INSERT INTO `item_mods_pet` VALUES(21183, 28, 108, 1);
INSERT INTO `item_mods_pet` VALUES(21361, 28, 6, 0);
INSERT INTO `item_mods_pet` VALUES(21526, 25, 50, 3);
INSERT INTO `item_mods_pet` VALUES(21526, 26, 50, 3);
INSERT INTO `item_mods_pet` VALUES(21526, 30, 50, 3);
INSERT INTO `item_mods_pet` VALUES(21715, 25, 30, 0);
INSERT INTO `item_mods_pet` VALUES(21715, 26, 30, 0);
INSERT INTO `item_mods_pet` VALUES(21715, 30, 30, 0);
INSERT INTO `item_mods_pet` VALUES(21716, 25, 40, 0);
INSERT INTO `item_mods_pet` VALUES(21716, 26, 40, 0);
INSERT INTO `item_mods_pet` VALUES(21716, 30, 40, 0);
INSERT INTO `item_mods_pet` VALUES(21717, 25, 50, 0);
INSERT INTO `item_mods_pet` VALUES(21717, 26, 50, 0);
INSERT INTO `item_mods_pet` VALUES(21717, 30, 50, 0);
INSERT INTO `item_mods_pet` VALUES(21751, 23, 80, 0);
INSERT INTO `item_mods_pet` VALUES(21865, 370, 5, 2);
INSERT INTO `item_mods_pet` VALUES(21866, 370, 8, 2);
INSERT INTO `item_mods_pet` VALUES(22015, 30, 10, 1);
INSERT INTO `item_mods_pet` VALUES(22016, 30, 15, 1);
INSERT INTO `item_mods_pet` VALUES(22054, 28, 115, 1);
INSERT INTO `item_mods_pet` VALUES(22054, 30, 35, 1);
INSERT INTO `item_mods_pet` VALUES(22063, 126, 40, 1);
INSERT INTO `item_mods_pet` VALUES(22074, 126, 3, 1);
INSERT INTO `item_mods_pet` VALUES(22075, 126, 5, 1);
INSERT INTO `item_mods_pet` VALUES(22096, 25, 50, 1);
INSERT INTO `item_mods_pet` VALUES(22096, 26, 50, 1);
INSERT INTO `item_mods_pet` VALUES(22096, 30, 50, 1);
INSERT INTO `item_mods_pet` VALUES(22210, 126, 3, 1);
INSERT INTO `item_mods_pet` VALUES(22211, 126, 5, 1);
INSERT INTO `item_mods_pet` VALUES(23057, 25, 31, 3);
INSERT INTO `item_mods_pet` VALUES(23057, 369, 1, 3);
INSERT INTO `item_mods_pet` VALUES(23057, 370, 3, 3);
INSERT INTO `item_mods_pet` VALUES(23057, 384, 600, 3);
INSERT INTO `item_mods_pet` VALUES(23120, 370, 10, 2);
INSERT INTO `item_mods_pet` VALUES(23121, 25, 35, 1);
INSERT INTO `item_mods_pet` VALUES(23121, 30, 35, 1);
INSERT INTO `item_mods_pet` VALUES(23121, 126, 14, 1);
INSERT INTO `item_mods_pet` VALUES(23124, 2, 165, 3);
INSERT INTO `item_mods_pet` VALUES(23124, 5, 165, 3);
INSERT INTO `item_mods_pet` VALUES(23124, 384, 400, 3);
INSERT INTO `item_mods_pet` VALUES(23191, 25, 32, 3);
INSERT INTO `item_mods_pet` VALUES(23191, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(23325, 28, 20, 3);
INSERT INTO `item_mods_pet` VALUES(23325, 30, 40, 3);
INSERT INTO `item_mods_pet` VALUES(23325, 384, 400, 3);
INSERT INTO `item_mods_pet` VALUES(23392, 25, 41, 3);
INSERT INTO `item_mods_pet` VALUES(23392, 369, 2, 3);
INSERT INTO `item_mods_pet` VALUES(23392, 370, 6, 3);
INSERT INTO `item_mods_pet` VALUES(23392, 384, 700, 3);
INSERT INTO `item_mods_pet` VALUES(23455, 370, 15, 2);
INSERT INTO `item_mods_pet` VALUES(23254, 3, 25, 2);
INSERT INTO `item_mods_pet` VALUES(23258, 5, 75, 3);
INSERT INTO `item_mods_pet` VALUES(23258, 160, -3, 3);
INSERT INTO `item_mods_pet` VALUES(23258, 374, 14, 3);
INSERT INTO `item_mods_pet` VALUES(23258, 384, 400, 3);
INSERT INTO `item_mods_pet` VALUES(23456, 25, 45, 1);
INSERT INTO `item_mods_pet` VALUES(23456, 30, 45, 1);
INSERT INTO `item_mods_pet` VALUES(23456, 126, 16, 1);
INSERT INTO `item_mods_pet` VALUES(23459, 2, 220, 3);
INSERT INTO `item_mods_pet` VALUES(23459, 5, 220, 3);
INSERT INTO `item_mods_pet` VALUES(23459, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(23526, 25, 42, 3);
INSERT INTO `item_mods_pet` VALUES(23526, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(23589, 3, 27, 2);
INSERT INTO `item_mods_pet` VALUES(23593, 5, 75, 3);
INSERT INTO `item_mods_pet` VALUES(23593, 160, -6, 3);
INSERT INTO `item_mods_pet` VALUES(23593, 374, 14, 3);
INSERT INTO `item_mods_pet` VALUES(23593, 384, 600, 3);
INSERT INTO `item_mods_pet` VALUES(23660, 28, 25, 3);
INSERT INTO `item_mods_pet` VALUES(23660, 30, 50, 3);
INSERT INTO `item_mods_pet` VALUES(23660, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(23674, 68, 38, 0);
INSERT INTO `item_mods_pet` VALUES(23674, 161, -5, 0);
INSERT INTO `item_mods_pet` VALUES(23679, 2, 290, 2);
INSERT INTO `item_mods_pet` VALUES(23679, 370, 10, 2);
INSERT INTO `item_mods_pet` VALUES(23680, 23, 89, 1);
INSERT INTO `item_mods_pet` VALUES(23680, 25, 36, 1);
INSERT INTO `item_mods_pet` VALUES(23680, 562, 13, 1);
INSERT INTO `item_mods_pet` VALUES(23683, 28, 57, 3);
INSERT INTO `item_mods_pet` VALUES(23683, 30, 43, 3);
INSERT INTO `item_mods_pet` VALUES(25465, 25, 15, 0);
INSERT INTO `item_mods_pet` VALUES(25465, 26, 15, 0);
INSERT INTO `item_mods_pet` VALUES(25465, 30, 15, 0);
INSERT INTO `item_mods_pet` VALUES(25466, 25, 20, 0);
INSERT INTO `item_mods_pet` VALUES(25466, 26, 20, 0);
INSERT INTO `item_mods_pet` VALUES(25466, 30, 20, 0);
INSERT INTO `item_mods_pet` VALUES(25467, 25, 25, 0);
INSERT INTO `item_mods_pet` VALUES(25467, 26, 25, 0);
INSERT INTO `item_mods_pet` VALUES(25467, 30, 25, 0);
INSERT INTO `item_mods_pet` VALUES(25501, 25, 15, 1);
INSERT INTO `item_mods_pet` VALUES(25501, 26, 15, 1);
INSERT INTO `item_mods_pet` VALUES(25501, 30, 15, 1);
INSERT INTO `item_mods_pet` VALUES(25502, 25, 20, 1);
INSERT INTO `item_mods_pet` VALUES(25502, 26, 20, 1);
INSERT INTO `item_mods_pet` VALUES(25502, 30, 20, 1);
INSERT INTO `item_mods_pet` VALUES(25503, 25, 25, 1);
INSERT INTO `item_mods_pet` VALUES(25503, 26, 25, 1);
INSERT INTO `item_mods_pet` VALUES(25503, 30, 25, 1);
INSERT INTO `item_mods_pet` VALUES(25519, 25, 15, 3);
INSERT INTO `item_mods_pet` VALUES(25519, 26, 15, 3);
INSERT INTO `item_mods_pet` VALUES(25519, 30, 15, 3);
INSERT INTO `item_mods_pet` VALUES(25520, 25, 20, 3);
INSERT INTO `item_mods_pet` VALUES(25520, 26, 20, 3);
INSERT INTO `item_mods_pet` VALUES(25520, 30, 20, 3);
INSERT INTO `item_mods_pet` VALUES(25521, 25, 25, 3);
INSERT INTO `item_mods_pet` VALUES(25521, 26, 25, 3);
INSERT INTO `item_mods_pet` VALUES(25521, 30, 25, 3);
INSERT INTO `item_mods_pet` VALUES(25563, 25, 40, 0);
INSERT INTO `item_mods_pet` VALUES(25563, 26, 40, 0);
INSERT INTO `item_mods_pet` VALUES(25563, 27, 8, 0);
INSERT INTO `item_mods_pet` VALUES(25563, 384, 600, 0);
INSERT INTO `item_mods_pet` VALUES(25564, 25, 50, 0);
INSERT INTO `item_mods_pet` VALUES(25564, 26, 50, 0);
INSERT INTO `item_mods_pet` VALUES(25564, 27, 10, 0);
INSERT INTO `item_mods_pet` VALUES(25564, 384, 600, 0);
INSERT INTO `item_mods_pet` VALUES(25565, 368, 3, 1);
INSERT INTO `item_mods_pet` VALUES(25566, 368, 4, 1);
INSERT INTO `item_mods_pet` VALUES(26201, 23, 23, 0);
INSERT INTO `item_mods_pet` VALUES(26201, 24, 23, 0);
INSERT INTO `item_mods_pet` VALUES(26201, 25, 22, 0);
INSERT INTO `item_mods_pet` VALUES(26201, 26, 22, 0);
INSERT INTO `item_mods_pet` VALUES(26201, 384, 400, 0);
INSERT INTO `item_mods_pet` VALUES(26201, 160, -4, 0);
INSERT INTO `item_mods_pet` VALUES(26652, 28, 20, 1);
INSERT INTO `item_mods_pet` VALUES(26653, 28, 23, 1);
INSERT INTO `item_mods_pet` VALUES(26658, 369, 2, 3);
INSERT INTO `item_mods_pet` VALUES(26658, 370, 3, 3);
INSERT INTO `item_mods_pet` VALUES(26659, 369, 3, 3);
INSERT INTO `item_mods_pet` VALUES(26659, 370, 3, 3);
INSERT INTO `item_mods_pet` VALUES(26774, 345, 525, 3);
INSERT INTO `item_mods_pet` VALUES(26775, 345, 550, 3);
INSERT INTO `item_mods_pet` VALUES(26828, 165, 8, 1);
INSERT INTO `item_mods_pet` VALUES(26829, 165, 12, 1);
INSERT INTO `item_mods_pet` VALUES(26834, 25, 18, 3);
INSERT INTO `item_mods_pet` VALUES(26834, 26, 18, 3);
INSERT INTO `item_mods_pet` VALUES(26834, 73, 12, 3);
INSERT INTO `item_mods_pet` VALUES(26835, 25, 21, 3);
INSERT INTO `item_mods_pet` VALUES(26835, 26, 21, 3);
INSERT INTO `item_mods_pet` VALUES(26835, 73, 13, 3);
INSERT INTO `item_mods_pet` VALUES(26888, 27, 14, 1);
INSERT INTO `item_mods_pet` VALUES(26926, 126, 10, 1);
INSERT INTO `item_mods_pet` VALUES(26927, 126, 11, 1);
INSERT INTO `item_mods_pet` VALUES(27004, 25, 20, 1);
INSERT INTO `item_mods_pet` VALUES(27004, 384, 200, 1);
INSERT INTO `item_mods_pet` VALUES(27005, 25, 28, 1);
INSERT INTO `item_mods_pet` VALUES(27005, 384, 300, 1);
INSERT INTO `item_mods_pet` VALUES(27010, 289, 7, 3);
INSERT INTO `item_mods_pet` VALUES(27010, 384, 400, 3);
INSERT INTO `item_mods_pet` VALUES(27011, 289, 9, 3);
INSERT INTO `item_mods_pet` VALUES(27011, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(27044, 2, 50, 2);
INSERT INTO `item_mods_pet` VALUES(27080, 25, 20, 1);
INSERT INTO `item_mods_pet` VALUES(27081, 25, 30, 1);
INSERT INTO `item_mods_pet` VALUES(27086, 8, 13, 3);
INSERT INTO `item_mods_pet` VALUES(27086, 9, 13, 3);
INSERT INTO `item_mods_pet` VALUES(27086, 11, 13, 3);
INSERT INTO `item_mods_pet` VALUES(27087, 8, 16, 3);
INSERT INTO `item_mods_pet` VALUES(27087, 9, 16, 3);
INSERT INTO `item_mods_pet` VALUES(27087, 11, 16, 3);
INSERT INTO `item_mods_pet` VALUES(27180, 30, 10, 1);
INSERT INTO `item_mods_pet` VALUES(27181, 30, 13, 1);
INSERT INTO `item_mods_pet` VALUES(27186, 30, 15, 3);
INSERT INTO `item_mods_pet` VALUES(27186, 170, 7, 3);
INSERT INTO `item_mods_pet` VALUES(27187, 30, 18, 3);
INSERT INTO `item_mods_pet` VALUES(27187, 170, 8, 3);
INSERT INTO `item_mods_pet` VALUES(27221, 27, 4, 1);
INSERT INTO `item_mods_pet` VALUES(27221, 126, 7, 1);
INSERT INTO `item_mods_pet` VALUES(27265, 345, 550, 1);
INSERT INTO `item_mods_pet` VALUES(27266, 345, 600, 1);
INSERT INTO `item_mods_pet` VALUES(27356, 23, 28, 1);
INSERT INTO `item_mods_pet` VALUES(27356, 562, 7, 1);
INSERT INTO `item_mods_pet` VALUES(27357, 23, 28, 1);
INSERT INTO `item_mods_pet` VALUES(27357, 562, 9, 1);
INSERT INTO `item_mods_pet` VALUES(27362, 28, 15, 3);
INSERT INTO `item_mods_pet` VALUES(27362, 30, 12, 3);
INSERT INTO `item_mods_pet` VALUES(27363, 28, 18, 3);
INSERT INTO `item_mods_pet` VALUES(27363, 30, 15, 3);
INSERT INTO `item_mods_pet` VALUES(27439, 30, 17, 1);
INSERT INTO `item_mods_pet` VALUES(27440, 30, 27, 1);
INSERT INTO `item_mods_pet` VALUES(27445, 12, 17, 3);
INSERT INTO `item_mods_pet` VALUES(27445, 13, 17, 3);
INSERT INTO `item_mods_pet` VALUES(27446, 12, 20, 3);
INSERT INTO `item_mods_pet` VALUES(27446, 13, 20, 3);
INSERT INTO `item_mods_pet` VALUES(27677, 27, 4, 1);
INSERT INTO `item_mods_pet` VALUES(27680, 71, 6, 3);
INSERT INTO `item_mods_pet` VALUES(27680, 72, 6, 3);
INSERT INTO `item_mods_pet` VALUES(27680, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(27698, 27, 4, 1);
INSERT INTO `item_mods_pet` VALUES(27701, 71, 8, 3);
INSERT INTO `item_mods_pet` VALUES(27701, 72, 8, 3);
INSERT INTO `item_mods_pet` VALUES(27701, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(27820, 370, 2, 2);
INSERT INTO `item_mods_pet` VALUES(27821, 126, 11, 1);
INSERT INTO `item_mods_pet` VALUES(27824, 2, 85, 3);
INSERT INTO `item_mods_pet` VALUES(27824, 5, 85, 3);
INSERT INTO `item_mods_pet` VALUES(27824, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(27841, 370, 3, 2);
INSERT INTO `item_mods_pet` VALUES(27842, 126, 12, 1);
INSERT INTO `item_mods_pet` VALUES(27845, 2, 110, 3);
INSERT INTO `item_mods_pet` VALUES(27845, 5, 110, 3);
INSERT INTO `item_mods_pet` VALUES(27845, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(27957, 27, 5, 1);
INSERT INTO `item_mods_pet` VALUES(27960, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(27978, 27, 5, 1);
INSERT INTO `item_mods_pet` VALUES(27981, 384, 400, 3);
INSERT INTO `item_mods_pet` VALUES(28025, 25, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28025, 26, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28025, 30, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28025, 384, 600, 0);
INSERT INTO `item_mods_pet` VALUES(28103, 3, 20, 2);
INSERT INTO `item_mods_pet` VALUES(28104, 25, 20, 1);
INSERT INTO `item_mods_pet` VALUES(28104, 27, 4, 1);
INSERT INTO `item_mods_pet` VALUES(28107, 5, 40, 3);
INSERT INTO `item_mods_pet` VALUES(28107, 374, 10, 3);
INSERT INTO `item_mods_pet` VALUES(28107, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(28119, 23, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28124, 3, 23, 2);
INSERT INTO `item_mods_pet` VALUES(28125, 25, 20, 1);
INSERT INTO `item_mods_pet` VALUES(28125, 27, 4, 1);
INSERT INTO `item_mods_pet` VALUES(28128, 5, 50, 3);
INSERT INTO `item_mods_pet` VALUES(28128, 374, 12, 3);
INSERT INTO `item_mods_pet` VALUES(28128, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(28141, 25, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28141, 23, 10, 0);
INSERT INTO `item_mods_pet` VALUES(28141, 26, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28141, 24, 10, 0);
INSERT INTO `item_mods_pet` VALUES(28141, 68, 20, 0);
INSERT INTO `item_mods_pet` VALUES(28141, 384, 300, 0);
INSERT INTO `item_mods_pet` VALUES(28211, 23, 15, 1);
INSERT INTO `item_mods_pet` VALUES(28211, 384, 200, 1);
INSERT INTO `item_mods_pet` VALUES(28213, 23, 13, 2);
INSERT INTO `item_mods_pet` VALUES(28214, 68, 5, 0);
INSERT INTO `item_mods_pet` VALUES(28219, 68, 2, 0);
INSERT INTO `item_mods_pet` VALUES(28231, 23, 10, 0);
INSERT INTO `item_mods_pet` VALUES(28231, 25, 10, 0);
INSERT INTO `item_mods_pet` VALUES(28237, 27, 5, 1);
INSERT INTO `item_mods_pet` VALUES(28237, 68, 20, 1);
INSERT INTO `item_mods_pet` VALUES(28237, 126, 5, 1);
INSERT INTO `item_mods_pet` VALUES(28240, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(28252, 23, 10, 0);
INSERT INTO `item_mods_pet` VALUES(28252, 25, 10, 0);
INSERT INTO `item_mods_pet` VALUES(28258, 27, 5, 1);
INSERT INTO `item_mods_pet` VALUES(28258, 68, 20, 1);
INSERT INTO `item_mods_pet` VALUES(28258, 126, 6, 1);
INSERT INTO `item_mods_pet` VALUES(28261, 384, 300, 3);
INSERT INTO `item_mods_pet` VALUES(28356, 28, 5, 1);
INSERT INTO `item_mods_pet` VALUES(28432, 25, 15, 3);
INSERT INTO `item_mods_pet` VALUES(28432, 26, 15, 3);
INSERT INTO `item_mods_pet` VALUES(28432, 30, 15, 3);
INSERT INTO `item_mods_pet` VALUES(28432, 384, 500, 3);
INSERT INTO `item_mods_pet` VALUES(28432, 170, 5, 3);
INSERT INTO `item_mods_pet` VALUES(28495, 384, 300, 0);
INSERT INTO `item_mods_pet` VALUES(28495, 27, 5, 0);
INSERT INTO `item_mods_pet` VALUES(28495, 160, 1, 0);
INSERT INTO `item_mods_pet` VALUES(28588, 23, 15, 3);
INSERT INTO `item_mods_pet` VALUES(28588, 25, 15, 3);
INSERT INTO `item_mods_pet` VALUES(28588, 68, 10, 3);
INSERT INTO `item_mods_pet` VALUES(28605, 25, 7, 1);
INSERT INTO `item_mods_pet` VALUES(28605, 30, 7, 1);
INSERT INTO `item_mods_pet` VALUES(28643, 12, 8, 3);
INSERT INTO `item_mods_pet` VALUES(28643, 13, 8, 3);
INSERT INTO `item_mods_pet` VALUES(28643, 30, 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item_mods_pet`
--
ALTER TABLE `item_mods_pet`
  ADD PRIMARY KEY (`itemId`,`modId`,`petType`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

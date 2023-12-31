-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:22 PM
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
-- Table structure for table `mob_family_mods`
--

DROP TABLE IF EXISTS `mob_family_mods`;
CREATE TABLE `mob_family_mods` (
  `familyid` smallint(5) UNSIGNED NOT NULL,
  `modid` smallint(5) UNSIGNED NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT 0,
  `is_mob_mod` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM AVG_ROW_LENGTH=13 DEFAULT CHARSET=utf8 PACK_KEYS=1;

--
-- Dumping data for table `mob_family_mods`
--

INSERT INTO `mob_family_mods` VALUES(175, 29, 50, 0);
INSERT INTO `mob_family_mods` VALUES(4, 29, 25, 0);
INSERT INTO `mob_family_mods` VALUES(4, 7, 60, 1);
INSERT INTO `mob_family_mods` VALUES(74, 29, 25, 0);
INSERT INTO `mob_family_mods` VALUES(61, 29, 25, 0);
INSERT INTO `mob_family_mods` VALUES(169, 29, 25, 0);
INSERT INTO `mob_family_mods` VALUES(110, 29, 13, 0);
INSERT INTO `mob_family_mods` VALUES(111, 29, 13, 0);
INSERT INTO `mob_family_mods` VALUES(171, 29, 13, 0);
INSERT INTO `mob_family_mods` VALUES(4, 244, 20, 0);
INSERT INTO `mob_family_mods` VALUES(193, 3, 40, 1);
INSERT INTO `mob_family_mods` VALUES(34, 3, 100, 1);
INSERT INTO `mob_family_mods` VALUES(267, 4, 20, 1);
INSERT INTO `mob_family_mods` VALUES(87, 4, 18, 1);
INSERT INTO `mob_family_mods` VALUES(87, 5, 10, 1);
INSERT INTO `mob_family_mods` VALUES(87, 3, 10, 1);
INSERT INTO `mob_family_mods` VALUES(240, 10, 1, 1);
INSERT INTO `mob_family_mods` VALUES(169, 10, 1, 1);
INSERT INTO `mob_family_mods` VALUES(358, 10, 1, 1);
INSERT INTO `mob_family_mods` VALUES(190, 10, 2, 1);
INSERT INTO `mob_family_mods` VALUES(189, 10, 2, 1);
INSERT INTO `mob_family_mods` VALUES(334, 10, 2, 1);
INSERT INTO `mob_family_mods` VALUES(46, 10, 3, 1);
INSERT INTO `mob_family_mods` VALUES(252, 10, 3, 1);
INSERT INTO `mob_family_mods` VALUES(47, 10, 3, 1);
INSERT INTO `mob_family_mods` VALUES(245, 10, 4, 1);
INSERT INTO `mob_family_mods` VALUES(216, 10, 4, 1);
INSERT INTO `mob_family_mods` VALUES(133, 10, 5, 1);
INSERT INTO `mob_family_mods` VALUES(373, 10, 5, 1);
INSERT INTO `mob_family_mods` VALUES(184, 10, 5, 1);
INSERT INTO `mob_family_mods` VALUES(59, 10, 5, 1);
INSERT INTO `mob_family_mods` VALUES(253, 10, 6, 1);
INSERT INTO `mob_family_mods` VALUES(254, 10, 6, 1);
INSERT INTO `mob_family_mods` VALUES(289, 10, 6, 1);
INSERT INTO `mob_family_mods` VALUES(307, 10, 6, 1);
INSERT INTO `mob_family_mods` VALUES(212, 10, 7, 1);
INSERT INTO `mob_family_mods` VALUES(362, 10, 7, 1);
INSERT INTO `mob_family_mods` VALUES(213, 10, 8, 1);
INSERT INTO `mob_family_mods` VALUES(285, 10, 8, 1);
INSERT INTO `mob_family_mods` VALUES(176, 10, 8, 1);
INSERT INTO `mob_family_mods` VALUES(246, 10, 9, 1);
INSERT INTO `mob_family_mods` VALUES(308, 10, 9, 1);
INSERT INTO `mob_family_mods` VALUES(326, 10, 9, 1);
INSERT INTO `mob_family_mods` VALUES(171, 10, 10, 1);
INSERT INTO `mob_family_mods` VALUES(182, 10, 10, 1);
INSERT INTO `mob_family_mods` VALUES(310, 10, 10, 1);
INSERT INTO `mob_family_mods` VALUES(469, 10, 10, 1);
INSERT INTO `mob_family_mods` VALUES(233, 10, 11, 1);
INSERT INTO `mob_family_mods` VALUES(311, 10, 11, 1);
INSERT INTO `mob_family_mods` VALUES(199, 10, 12, 1);
INSERT INTO `mob_family_mods` VALUES(288, 10, 12, 1);
INSERT INTO `mob_family_mods` VALUES(165, 10, 13, 1);
INSERT INTO `mob_family_mods` VALUES(166, 10, 13, 1);
INSERT INTO `mob_family_mods` VALUES(301, 10, 13, 1);
INSERT INTO `mob_family_mods` VALUES(27, 10, 14, 1);
INSERT INTO `mob_family_mods` VALUES(294, 10, 14, 1);
INSERT INTO `mob_family_mods` VALUES(169, 11, 15, 1);
INSERT INTO `mob_family_mods` VALUES(358, 11, 15, 1);
INSERT INTO `mob_family_mods` VALUES(110, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(121, 242, 20, 0);
INSERT INTO `mob_family_mods` VALUES(52, 242, 20, 0);
INSERT INTO `mob_family_mods` VALUES(258, 34, 25, 1);
INSERT INTO `mob_family_mods` VALUES(217, 23, 256, 1);
INSERT INTO `mob_family_mods` VALUES(274, 23, 256, 1);
INSERT INTO `mob_family_mods` VALUES(273, 23, 256, 1);
INSERT INTO `mob_family_mods` VALUES(234, 37, 1, 1);
INSERT INTO `mob_family_mods` VALUES(72, 29, 10, 0);
INSERT INTO `mob_family_mods` VALUES(139, 68, 10, 0);
INSERT INTO `mob_family_mods` VALUES(57, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(72, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(140, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(141, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(207, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(255, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(253, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(194, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(271, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(135, 4, 4, 1);
INSERT INTO `mob_family_mods` VALUES(394, 41, 988, 1);
INSERT INTO `mob_family_mods` VALUES(394, 42, 989, 1);
INSERT INTO `mob_family_mods` VALUES(394, 43, 2, 1);
INSERT INTO `mob_family_mods` VALUES(150, 4, 30, 1);
INSERT INTO `mob_family_mods` VALUES(394, 4, 30, 1);
INSERT INTO `mob_family_mods` VALUES(236, 4, 30, 1);
INSERT INTO `mob_family_mods` VALUES(481, 41, 988, 1);
INSERT INTO `mob_family_mods` VALUES(481, 42, 989, 1);
INSERT INTO `mob_family_mods` VALUES(4, 389, -25, 0);
INSERT INTO `mob_family_mods` VALUES(112, 389, 25, 0);
INSERT INTO `mob_family_mods` VALUES(61, 389, -25, 0);
INSERT INTO `mob_family_mods` VALUES(74, 389, -25, 0);
INSERT INTO `mob_family_mods` VALUES(358, 389, -25, 0);
INSERT INTO `mob_family_mods` VALUES(169, 389, -25, 0);
INSERT INTO `mob_family_mods` VALUES(110, 389, -13, 0);
INSERT INTO `mob_family_mods` VALUES(122, 389, -13, 0);
INSERT INTO `mob_family_mods` VALUES(123, 389, -13, 0);
INSERT INTO `mob_family_mods` VALUES(124, 389, -13, 0);
INSERT INTO `mob_family_mods` VALUES(175, 389, -50, 0);
INSERT INTO `mob_family_mods` VALUES(171, 389, -13, 0);
INSERT INTO `mob_family_mods` VALUES(358, 254, 25, 0);
INSERT INTO `mob_family_mods` VALUES(169, 254, 25, 0);
INSERT INTO `mob_family_mods` VALUES(115, 254, 25, 0);
INSERT INTO `mob_family_mods` VALUES(359, 254, 25, 0);
INSERT INTO `mob_family_mods` VALUES(47, 240, 50, 0);
INSERT INTO `mob_family_mods` VALUES(48, 240, 50, 0);
INSERT INTO `mob_family_mods` VALUES(52, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(74, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(86, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(88, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(89, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(115, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(121, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(125, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(139, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(142, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(143, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(169, 240, 50, 0);
INSERT INTO `mob_family_mods` VALUES(203, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(204, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(205, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(221, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(222, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(223, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(227, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(358, 240, 50, 0);
INSERT INTO `mob_family_mods` VALUES(359, 240, 100, 0);
INSERT INTO `mob_family_mods` VALUES(92, 23, 2039, 1);
INSERT INTO `mob_family_mods` VALUES(93, 23, 2039, 1);
INSERT INTO `mob_family_mods` VALUES(94, 23, 2039, 1);
INSERT INTO `mob_family_mods` VALUES(95, 23, 2039, 1);
INSERT INTO `mob_family_mods` VALUES(92, 73, 100, 0);
INSERT INTO `mob_family_mods` VALUES(93, 73, 100, 0);
INSERT INTO `mob_family_mods` VALUES(94, 73, 100, 0);
INSERT INTO `mob_family_mods` VALUES(95, 73, 100, 0);
INSERT INTO `mob_family_mods` VALUES(172, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(369, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(206, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(206, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(206, 36, 35, 1);
INSERT INTO `mob_family_mods` VALUES(206, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(404, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(404, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(404, 36, 35, 1);
INSERT INTO `mob_family_mods` VALUES(404, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(226, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(226, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(226, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(226, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(242, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(242, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(242, 36, 45, 1);
INSERT INTO `mob_family_mods` VALUES(97, 51, 4, 1);
INSERT INTO `mob_family_mods` VALUES(97, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(97, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(174, 51, 4, 1);
INSERT INTO `mob_family_mods` VALUES(174, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(174, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(48, 36, 15, 1);
INSERT INTO `mob_family_mods` VALUES(48, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(49, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(49, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(49, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(116, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(116, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(116, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(216, 31, 20, 1);
INSERT INTO `mob_family_mods` VALUES(245, 36, 65, 1);
INSERT INTO `mob_family_mods` VALUES(245, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(372, 36, 15, 1);
INSERT INTO `mob_family_mods` VALUES(75, 36, 15, 1);
INSERT INTO `mob_family_mods` VALUES(76, 36, 15, 1);
INSERT INTO `mob_family_mods` VALUES(77, 36, 15, 1);
INSERT INTO `mob_family_mods` VALUES(47, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(47, 36, 35, 1);
INSERT INTO `mob_family_mods` VALUES(47, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(46, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(46, 36, 35, 1);
INSERT INTO `mob_family_mods` VALUES(46, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(71, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(71, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(71, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(188, 36, 35, 1);
INSERT INTO `mob_family_mods` VALUES(188, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(188, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(139, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(139, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(258, 36, 90, 1);
INSERT INTO `mob_family_mods` VALUES(258, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(227, 36, 65, 1);
INSERT INTO `mob_family_mods` VALUES(227, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(227, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(110, 36, 45, 1);
INSERT INTO `mob_family_mods` VALUES(110, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(110, 52, 30, 1);

-- elementals
INSERT INTO `mob_family_mods` VALUES(99, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(100, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(101, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(102, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(103, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(104, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(105, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(106, 51, 3, 1);



-- SMN Avatars
-- +500% mpp
INSERT INTO `mob_family_mods` VALUES (99,6,500,0);
INSERT INTO `mob_family_mods` VALUES (100,6,500,0);
INSERT INTO `mob_family_mods` VALUES (101,6,500,0);
INSERT INTO `mob_family_mods` VALUES (102,6,500,0);
INSERT INTO `mob_family_mods` VALUES (103,6,500,0);
INSERT INTO `mob_family_mods` VALUES (104,6,500,0);
INSERT INTO `mob_family_mods` VALUES (105,6,500,0);
INSERT INTO `mob_family_mods` VALUES (106,6,500,0);
-- DMGPHYS -50
INSERT INTO `mob_family_mods` VALUES (379,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (381,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (383,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (388,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (384,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (382,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (387,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (386,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (380,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (389,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (385,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (32,161,-50,0);
INSERT INTO `mob_family_mods` VALUES (60,161,-50,0);
-- attp
INSERT INTO `mob_family_mods` VALUES (379,62,5,0);
-- crit dmg +8%
INSERT INTO `mob_family_mods` VALUES (379,421,8,0);
INSERT INTO `mob_family_mods` VALUES (381,421,8,0);
INSERT INTO `mob_family_mods` VALUES (383,421,8,0);
INSERT INTO `mob_family_mods` VALUES (388,421,8,0);
INSERT INTO `mob_family_mods` VALUES (384,421,8,0);
INSERT INTO `mob_family_mods` VALUES (382,421,8,0);
INSERT INTO `mob_family_mods` VALUES (387,421,8,0);
INSERT INTO `mob_family_mods` VALUES (386,421,8,0);
INSERT INTO `mob_family_mods` VALUES (380,421,8,0);
INSERT INTO `mob_family_mods` VALUES (389,421,8,0);
INSERT INTO `mob_family_mods` VALUES (385,421,8,0);
INSERT INTO `mob_family_mods` VALUES (32, 421,8,0);
INSERT INTO `mob_family_mods` VALUES (60, 421,8,0);


INSERT INTO `mob_family_mods` VALUES(155, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(156, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(157, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(158, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(159, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(160, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(161, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(162, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(328, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(328, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(328, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(328, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(126, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(126, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(126, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(126, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(127, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(127, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(127, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(127, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(128, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(128, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(128, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(128, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(129, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(129, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(129, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(129, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(130, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(130, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(130, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(130, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(243, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(243, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(243, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(244, 36, 25, 1);
INSERT INTO `mob_family_mods` VALUES(244, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(244, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(217, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(217, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(479, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(51, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(57, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(57, 51, 4, 1);
INSERT INTO `mob_family_mods` VALUES(57, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(62, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(80, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(80, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(80, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(180, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(180, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(180, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(208, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(208, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(2, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(2, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(58, 36, 45, 1);
INSERT INTO `mob_family_mods` VALUES(58, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(58, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(98, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(98, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(98, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(210, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(210, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(210, 31, 30, 1);
INSERT INTO `mob_family_mods` VALUES(376, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(376, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(376, 31, 30, 1);
INSERT INTO `mob_family_mods` VALUES(377, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(377, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(377, 31, 30, 1);
INSERT INTO `mob_family_mods` VALUES(257, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(257, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(179, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(179, 51, 4, 1);
INSERT INTO `mob_family_mods` VALUES(179, 31, 30, 1);
INSERT INTO `mob_family_mods` VALUES(179, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(26, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(26, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(26, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(79, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(79, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(81, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(81, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(136, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(136, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(136, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(186, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(186, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(212, 36, 10, 1);
INSERT INTO `mob_family_mods` VALUES(212, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(218, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(219, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(251, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(251, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(112, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(112, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(70, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(70, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(70, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(72, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(72, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(140, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(140, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(141, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(141, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(125, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(125, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(125, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(74, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(74, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(74, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(86, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(86, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(115, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(115, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(115, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(359, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(359, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(359, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(121, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(121, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(142, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(142, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(142, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(143, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(143, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(143, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(203, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(203, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(203, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(204, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(204, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(204, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(205, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(205, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(205, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(221, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(221, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(221, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(222, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(222, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(222, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(223, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(223, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(223, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(252, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(252, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(252, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(56, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(56, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(56, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(61, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(61, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(61, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(68, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(68, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(68, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(69, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(69, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(69, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(83, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(83, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(83, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(84, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(84, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(84, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(85, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(85, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(85, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(367, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(367, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(367, 36, 30, 1);
INSERT INTO `mob_family_mods` VALUES(368, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(368, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(368, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(135, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(135, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(135, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(175, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(175, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(175, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(232, 52, 20, 1);
INSERT INTO `mob_family_mods` VALUES(232, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(232, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(163, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(163, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(164, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(164, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(259, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(260, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(261, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(262, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(263, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(264, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(265, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(266, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(267, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(268, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(391, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(391, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(392, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(392, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(393, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(393, 31, 5, 1);
INSERT INTO `mob_family_mods` VALUES(87, 36, 55, 1);
INSERT INTO `mob_family_mods` VALUES(4, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(4, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(169, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(169, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(169, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(358, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(358, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(358, 31, 15, 1);
INSERT INTO `mob_family_mods` VALUES(165, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(165, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(166, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(166, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(233, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(233, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(240, 51, 3, 1);
INSERT INTO `mob_family_mods` VALUES(240, 36, 40, 1);
INSERT INTO `mob_family_mods` VALUES(240, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(190, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(190, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(59, 36, 50, 1);
INSERT INTO `mob_family_mods` VALUES(59, 52, 30, 1);
INSERT INTO `mob_family_mods` VALUES(59, 51, 2, 1);
INSERT INTO `mob_family_mods` VALUES(126, 54, 180, 1);
INSERT INTO `mob_family_mods` VALUES(127, 54, 180, 1);
INSERT INTO `mob_family_mods` VALUES(128, 54, 180, 1);
INSERT INTO `mob_family_mods` VALUES(129, 54, 180, 1);
INSERT INTO `mob_family_mods` VALUES(130, 54, 180, 1);
INSERT INTO `mob_family_mods` VALUES(328, 54, 180, 1);
INSERT INTO `mob_family_mods` VALUES(169, 54, 120, 1);
INSERT INTO `mob_family_mods` VALUES(358, 54, 120, 1);
INSERT INTO `mob_family_mods` VALUES(87, 54, 1000, 1);
INSERT INTO `mob_family_mods` VALUES(115, 54, 100, 1);
INSERT INTO `mob_family_mods` VALUES(359, 54, 100, 1);
INSERT INTO `mob_family_mods` VALUES(7, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(8, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(9, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(11, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(12, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(13, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(14, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(15, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(16, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(17, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(18, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(19, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(20, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(21, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(23, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(24, 3, 50, 1);
INSERT INTO `mob_family_mods` VALUES(58, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(57, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(208, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(2, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(245, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(213, 20, 128, 0);
INSERT INTO `mob_family_mods` VALUES(32, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(33, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(34, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(35, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(36, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(37, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(38, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(39, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(40, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(41, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(42, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(43, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(44, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(45, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(495, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(92, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(93, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(94, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(95, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(99, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(100, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(101, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(102, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(103, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(104, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(105, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(106, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(4, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(139, 56, -1, 1);
INSERT INTO `mob_family_mods` VALUES(57, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(58, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(59, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(79, 59, 110, 1);
INSERT INTO `mob_family_mods` VALUES(80, 59, 110, 1);
INSERT INTO `mob_family_mods` VALUES(81, 59, 115, 1);
INSERT INTO `mob_family_mods` VALUES(265, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(266, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(267, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(268, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(87, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(136, 59, 145, 1);
INSERT INTO `mob_family_mods` VALUES(179, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(217, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(208, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(210, 59, 110, 1);
INSERT INTO `mob_family_mods` VALUES(242, 59, 110, 1);
INSERT INTO `mob_family_mods` VALUES(240, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(259, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(260, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(261, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(262, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(263, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(264, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(169, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(358, 59, 120, 1);
INSERT INTO `mob_family_mods` VALUES(371, 59, 125, 1);
INSERT INTO `mob_family_mods` VALUES(165, 29, 24, 0);
INSERT INTO `mob_family_mods` VALUES(115, 85, 1, 1);
INSERT INTO `mob_family_mods` VALUES(195, 86, 1, 1);
INSERT INTO `mob_family_mods` VALUES(195, 31, 5000, 1);
INSERT INTO `mob_family_mods` VALUES(195, 51, 5, 1);
INSERT INTO `mob_family_mods` VALUES(195, 36, 60, 1);
INSERT INTO `mob_family_mods` VALUES(63, 1240, 1000, 0);
INSERT INTO `mob_family_mods` VALUES(72, 68, 20, 0);
INSERT INTO `mob_family_mods` VALUES(208, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(242, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(179, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(217, 62, 20, 0);
INSERT INTO `mob_family_mods` VALUES(240, 63, -20, 0);
INSERT INTO `mob_family_mods` VALUES(240, 68, -10, 0);
INSERT INTO `mob_family_mods` VALUES(57, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(58, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(26, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(26, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(357, 62, 10, 0);
INSERT INTO `mob_family_mods` VALUES(357, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(188, 68, 22, 0);
INSERT INTO `mob_family_mods` VALUES(253, 63, 12, 0);
INSERT INTO `mob_family_mods` VALUES(176, 68, 10, 0);
INSERT INTO `mob_family_mods` VALUES(177, 68, 10, 0);
INSERT INTO `mob_family_mods` VALUES(285, 68, 10, 0);
INSERT INTO `mob_family_mods` VALUES(233, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(74, 63, 20, 0);
INSERT INTO `mob_family_mods` VALUES(64, 62, -50, 0);
INSERT INTO `mob_family_mods` VALUES(64, 63, -20, 0);
INSERT INTO `mob_family_mods` VALUES(64, 68, 10, 0);
INSERT INTO `mob_family_mods` VALUES(180, 68, -10, 0);
INSERT INTO `mob_family_mods` VALUES(371, 68, -10, 0);
INSERT INTO `mob_family_mods` VALUES(59, 68, -10, 0);
INSERT INTO `mob_family_mods` VALUES(200, 10, 15, 1);
INSERT INTO `mob_family_mods` VALUES(201, 10, 15, 1);
INSERT INTO `mob_family_mods` VALUES(202, 10, 15, 1);

-- Pandemonium Warden aoe buffs shared with Lamps
INSERT INTO `mob_family_mods` VALUES(316, 10, 316, 0);
INSERT INTO `mob_family_mods` VALUES(91, 10, 316, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mob_family_mods`
--
ALTER TABLE `mob_family_mods`
  ADD PRIMARY KEY (`familyid`,`modid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

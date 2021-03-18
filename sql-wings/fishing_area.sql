-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:16 PM
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
-- Table structure for table `fishing_area`
--

DROP TABLE IF EXISTS `fishing_area`;
CREATE TABLE `fishing_area` (
  `zoneid` smallint(5) UNSIGNED NOT NULL,
  `areaid` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `bound_type` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `bound_height` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `bound_radius` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `bounds` blob DEFAULT NULL,
  `center_x` float(7,3) NOT NULL DEFAULT 0.000,
  `center_y` float(7,3) NOT NULL DEFAULT 0.000,
  `center_z` float(7,3) NOT NULL DEFAULT 0.000
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fishing_area`
--

INSERT INTO `fishing_area` VALUES(2, 1, 'South Landing', 1, 20, 150, '', 172.250, -2.000, -475.286);
INSERT INTO `fishing_area` VALUES(2, 2, 'Other Waterside South', 1, 20, 60, '', -101.576, 0.000, -484.401);
INSERT INTO `fishing_area` VALUES(2, 3, 'Other Waterside Center', 1, 20, 60, '', -221.249, 0.000, -283.157);
INSERT INTO `fishing_area` VALUES(2, 4, 'Other Waterside North', 1, 20, 20, '', -179.219, 1.000, -131.611);
INSERT INTO `fishing_area` VALUES(2, 5, 'Central Landing', 1, 20, 80, '', -164.099, 0.000, 59.123);
INSERT INTO `fishing_area` VALUES(2, 6, 'North Landing', 1, 20, 150, '', -332.920, -2.000, 564.747);
INSERT INTO `fishing_area` VALUES(3, 1, 'Dhalmel Rock', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(3, 2, 'Maliyakaleya Reef', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(3, 3, 'Purgonorgo Isle', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(4, 1, 'PI - South Beach', 2, 20, 0, 0x0000dcc300000000000057c4000082c300000000000057c4000082c300000000000075c40000e1c300000000000075c4, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(4, 2, 'PI - North Beach', 1, 20, 150, '', -360.000, 0.000, -390.000);
INSERT INTO `fishing_area` VALUES(4, 3, 'PI - West Beach', 1, 20, 150, '', -660.000, 0.000, -680.000);
INSERT INTO `fishing_area` VALUES(4, 4, 'PI - East Beach', 1, 20, 150, '', -110.000, 0.000, -640.000);
INSERT INTO `fishing_area` VALUES(4, 5, 'BB - South Seaside', 1, 50, 40, '', 309.000, -10.000, 186.000);
INSERT INTO `fishing_area` VALUES(4, 6, 'BB - Other Seaside', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(11, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(24, 1, 'Leremieu Lagoon', 1, 20, 50, '', 96.000, -5.000, 28.000);
INSERT INTO `fishing_area` VALUES(24, 2, 'Seaside', 1, 20, 60, '', 0.000, 0.000, -320.000);
INSERT INTO `fishing_area` VALUES(24, 3, 'Rafeloux River', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(25, 1, 'Cascade Edellaine', 1, 20, 62, '', -192.000, -15.000, 640.000);
INSERT INTO `fishing_area` VALUES(25, 2, 'Seaside', 1, 20, 100, '', 700.000, 0.000, -535.000);
INSERT INTO `fishing_area` VALUES(25, 3, 'Rafeloux River', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(26, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(27, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(46, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(47, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(48, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(50, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(51, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(52, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(53, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(54, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(57, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(58, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(59, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(61, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(65, 1, 'Pond', 1, 20, 60, '', -103.000, 11.000, -65.000);
INSERT INTO `fishing_area` VALUES(65, 2, 'Other Waterside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(68, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(79, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(100, 1, 'Knightwell', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(101, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(102, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(103, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(104, 1, 'Crystalwater Spring', 1, 20, 20, '', 300.000, 1.000, -179.833);
INSERT INTO `fishing_area` VALUES(104, 2, 'Lake Mechieume - Mouth', 1, 20, 31, '', 19.458, 3.000, 334.528);
INSERT INTO `fishing_area` VALUES(104, 3, 'Lake Mechieume - Main', 2, 20, 0, 0xc1ca2bc30000000010981544df4f0b430000000064d3114477de0d4300000000ec41a143235b30c3000000006871a343, 0.000, 5.000, 0.000);
INSERT INTO `fishing_area` VALUES(104, 4, 'Maidens Spring', 1, 20, 22, '', -496.682, 9.000, 298.057);
INSERT INTO `fishing_area` VALUES(104, 5, 'River', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(105, 1, 'North Seaside', 1, 20, 200, '', 291.891, 7.000, 198.639);
INSERT INTO `fishing_area` VALUES(105, 2, 'South Seaside', 1, 20, 150, '', 102.172, 8.000, -489.808);
INSERT INTO `fishing_area` VALUES(106, 1, 'Basin of Waterfall', 1, 20, 27, '', -230.433, 96.000, 462.000);
INSERT INTO `fishing_area` VALUES(106, 2, 'River', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(107, 1, 'Hot Springs', 1, 20, 150, '', -485.042, 44.000, -415.916);
INSERT INTO `fishing_area` VALUES(107, 2, 'Seaside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(109, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(110, 1, 'Small Fountain 1', 1, 20, 20, '', -538.750, -14.000, -179.103);
INSERT INTO `fishing_area` VALUES(110, 2, 'Fountain of Promises', 1, 20, 70, '', -670.355, -21.000, -175.250);
INSERT INTO `fishing_area` VALUES(110, 3, 'Fountain of Partings', 1, 20, 60, '', -721.715, -26.000, -423.003);
INSERT INTO `fishing_area` VALUES(110, 4, 'Small Fountain 2', 1, 20, 20, '', 257.238, -30.000, -258.576);
INSERT INTO `fishing_area` VALUES(111, 1, 'Seaside', 1, 20, 150, '', 435.000, -1.000, -92.000);
INSERT INTO `fishing_area` VALUES(111, 2, 'Ponds', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(113, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(114, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(115, 1, 'Pond', 1, 20, 25, '', 110.000, -1.000, -200.000);
INSERT INTO `fishing_area` VALUES(115, 2, 'Seaside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(116, 1, 'Seaside', 2, 20, 0, 0x6666e2c1000000000a372ac49a9941c1000000005c3f32c43333bec200000000d79333c4004006c300000000f6f825c4291c03c3000000009aa920c4, 0.000, 9.000, 0.000);
INSERT INTO `fishing_area` VALUES(116, 2, 'Other Waterside (south)', 1, 20, 25, '', -144.690, -5.000, -360.580);
INSERT INTO `fishing_area` VALUES(116, 3, 'Other Waterside (west)', 1, 20, 25, '', -237.236, -1.000, -224.762);
INSERT INTO `fishing_area` VALUES(116, 4, 'Other Waterside (rivers)', 2, 50, 0, 0x7b146dc2000000007b1477c2d763a7c300000000cdcc78c2c355a3c300000000cd6c3644b89e054400000000f638364400800644000000009a597bc348e158c200000000ae074cc3, 0.000, -12.000, 0.000);
INSERT INTO `fishing_area` VALUES(116, 5, 'Lake Tepokalipuka', 2, 20, 0, 0x0000b4c30000000000004cc30000b4c300000000000096c2a4707fc300000000000096c233f36bc300000000ec51e6c2523894c200000000f628e7c266e6a2c2000000003d8a2ac37bd478c3000000007b1429c3cd8c83c3000000005ccf46c3, 0.000, -1.000, 0.000);
INSERT INTO `fishing_area` VALUES(118, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(120, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(121, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(122, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(123, 1, 'Northeast Pond', 1, 20, 15, '', 380.000, 21.000, 296.000);
INSERT INTO `fishing_area` VALUES(123, 2, 'Gremini Falls', 1, 20, 32, '', 428.000, 20.000, 278.000);
INSERT INTO `fishing_area` VALUES(123, 3, 'Southwest Pond', 1, 20, 15, '', -340.000, 16.000, -456.000);
INSERT INTO `fishing_area` VALUES(123, 4, 'Southwest Waterfall - South', 1, 20, 28, '', -458.000, 17.000, -446.000);
INSERT INTO `fishing_area` VALUES(123, 5, 'Southwest Waterfall - North', 1, 20, 45, '', -446.000, 17.000, -379.000);
INSERT INTO `fishing_area` VALUES(123, 6, 'Other Waterside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(124, 1, 'Front of Temple - East Side', 1, 20, 33, '', 332.000, 3.500, -514.000);
INSERT INTO `fishing_area` VALUES(124, 2, 'Front of Temple - West Side', 1, 20, 32, '', 275.000, 3.500, -514.000);
INSERT INTO `fishing_area` VALUES(124, 3, 'Teardrop Spring', 1, 20, 20, '', 539.000, 0.000, -420.000);
INSERT INTO `fishing_area` VALUES(124, 4, 'Underground Pool 1', 1, 10, 10, '', 106.000, 9.000, -577.000);
INSERT INTO `fishing_area` VALUES(124, 5, 'Bloodlet Spring', 1, 20, 20, '', 219.000, -1.000, 60.000);
INSERT INTO `fishing_area` VALUES(124, 6, 'Underground Pool 3', 1, 10, 10, '', -496.000, 9.000, -186.000);
INSERT INTO `fishing_area` VALUES(124, 7, 'Underground Pool 2', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(125, 1, 'Oasis of Hubol', 1, 20, 50, '', -640.000, 2.000, -313.000);
INSERT INTO `fishing_area` VALUES(125, 2, 'Central Spring', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(126, 1, 'Northwest Seaside', 1, 20, 80, '', -100.000, -21.000, 390.000);
INSERT INTO `fishing_area` VALUES(126, 2, 'Southwest Seaside', 1, 20, 90, '', 15.000, -19.000, -83.000);
INSERT INTO `fishing_area` VALUES(126, 3, 'Other Seaside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(130, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(140, 1, 'Pond North', 1, 20, 12, '', -174.165, -21.000, 414.486);
INSERT INTO `fishing_area` VALUES(140, 2, 'Pond South', 1, 20, 15, '', -215.293, -10.000, 25.168);
INSERT INTO `fishing_area` VALUES(140, 3, 'River', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(142, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(143, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(145, 1, 'Giddeus Spring', 1, 20, 15, '', 224.758, -2.000, -296.078);
INSERT INTO `fishing_area` VALUES(145, 2, 'Pond - West', 1, 20, 15, '', -254.810, -2.000, -255.620);
INSERT INTO `fishing_area` VALUES(145, 3, 'Pond - North', 1, 20, 20, '', -100.000, 1.500, -140.000);
INSERT INTO `fishing_area` VALUES(145, 4, 'Misc Puddles', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(149, 1, 'Basin of a Waterfall', 1, 20, 10, '', 180.240, 3.000, -384.460);
INSERT INTO `fishing_area` VALUES(149, 2, 'Wailing Pond', 1, 20, 20, '', 382.240, 0.000, -180.410);
INSERT INTO `fishing_area` VALUES(149, 3, 'Pond', 1, 20, 50, '', 198.750, 2.000, -107.220);
INSERT INTO `fishing_area` VALUES(149, 4, 'Other Waterside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(151, 1, 'PLD AF Fishing Spot', 1, 10, 15, '', -80.000, 24.000, -40.000);
INSERT INTO `fishing_area` VALUES(151, 2, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(153, 1, 'Waterfall Basin', 1, 20, 27, '', 45.000, -18.000, -173.000);
INSERT INTO `fishing_area` VALUES(153, 2, 'Waterfall Basin - Hidden', 1, 20, 20, '', -244.000, 10.000, -278.000);
INSERT INTO `fishing_area` VALUES(153, 3, 'Other Waterside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(154, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(157, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(158, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(159, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(160, 1, 'Pool E-8', 1, 20, 20, '', 175.000, 17.000, 176.000);
INSERT INTO `fishing_area` VALUES(160, 2, 'Pool F-11', 1, 20, 20, '', -24.000, 17.000, -216.000);
INSERT INTO `fishing_area` VALUES(160, 3, 'Misc Water', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(166, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(167, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(172, 1, 'River', 1, 20, 20, '', -100.310, -1.000, 20.168);
INSERT INTO `fishing_area` VALUES(172, 2, 'Pool', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(173, 1, 'Salt Water', 2, 20, 0, 0x000090c20000000000001643000034c20000000000001643000034c200000000000050c2000090c200000000000050c2, 0.000, -2.000, 0.000);
INSERT INTO `fishing_area` VALUES(173, 2, 'Fresh Water', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(174, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(176, 1, 'Other Seaside', 1, 20, 20, '', 26.600, 10.000, 182.000);
INSERT INTO `fishing_area` VALUES(176, 2, 'Pond Under a Bridge', 1, 20, 22, '', 100.000, 10.000, -19.000);
INSERT INTO `fishing_area` VALUES(176, 3, 'Interior of Hidden Door - Mythril', 1, 20, 20, '', -306.000, 21.000, -62.000);
INSERT INTO `fishing_area` VALUES(176, 4, 'Interior of Hidden Door - Gold', 1, 20, 20, '', -256.000, 51.000, -345.000);
INSERT INTO `fishing_area` VALUES(176, 5, 'Misc Puddles', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(178, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(184, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(191, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(193, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(196, 1, 'Pool Upper West', 1, 20, 12, '', -136.705, -59.000, -99.459);
INSERT INTO `fishing_area` VALUES(196, 2, 'Pool Upper East', 1, 20, 12, '', 216.119, -59.000, -100.126);
INSERT INTO `fishing_area` VALUES(196, 3, 'Pool Lower East', 1, 20, 12, '', 176.517, -39.000, -19.909);
INSERT INTO `fishing_area` VALUES(196, 4, 'Interior Pool West', 1, 20, 25, '', -80.224, -27.000, 446.559);
INSERT INTO `fishing_area` VALUES(196, 5, 'Interior Pool Center', 1, 20, 25, '', 39.236, -11.000, 446.130);
INSERT INTO `fishing_area` VALUES(196, 6, 'Interior Pool East', 1, 20, 25, '', 120.311, -19.000, 446.192);
INSERT INTO `fishing_area` VALUES(204, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(208, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(212, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(213, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(220, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(221, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(227, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(228, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(231, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(232, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(234, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(235, 1, 'North Side', 2, 20, 0, 0xe32e85c3000000008262f4c11ceb1cc1000000007446d4c1098af1c000000000d22fedc2dda404c300000000d676efc2219039c3000000001eb6bcc221d058c3000000007328c1c254a363c300000000ffb2e9c2dc5778c3000000001846efc2dc8f86c3000000008fd3dbc2, 0.000, -6.000, 0.000);
INSERT INTO `fishing_area` VALUES(235, 2, 'South Side', 0, 0, 0, '', 0.000, -6.000, 0.000);
INSERT INTO `fishing_area` VALUES(236, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(237, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(238, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(239, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(240, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(241, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(242, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(245, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(246, 1, 'Whole Zone', 0, 0, 0, '', 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(247, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(248, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(249, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(250, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(252, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);

-- UPDATE by XENTIS - 28/02/21
-- //START
--
-- Vunkerl Inlet [S] - 4 spots
INSERT INTO `fishing_area` VALUES(83, 1, 'Bridge', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(83, 2, 'Lake Joroia', 1, 20, 200, NULL, -212.553, -37.738, -307.338);
INSERT INTO `fishing_area` VALUES(83, 3, 'Memjar Spring', 1, 20, 130, NULL, -284.279, -38.375, -656.134);
INSERT INTO `fishing_area` VALUES(83, 4, 'Ludiwa Spring', 1, 20, 130, NULL, -423.925, -30.592, 574.216);
-- Rolanberry Fields [S] - 4 spots
INSERT INTO `fishing_area` VALUES(91, 1, 'Small Fountain 1', 1, 20, 20, '', -538.750, -14.000, -179.103);
INSERT INTO `fishing_area` VALUES(91, 2, 'Fountain of Promises', 1, 20, 70, '', -670.355, -21.000, -175.250);
INSERT INTO `fishing_area` VALUES(91, 3, 'Fountain of Partings', 1, 20, 60, '', -721.715, -26.000, -423.003);
INSERT INTO `fishing_area` VALUES(91, 4, 'Small Fountain 2', 1, 20, 20, '', 257.238, -30.000, -258.576);
-- Pashhow Marshlands [S] - 1 spot
INSERT INTO `fishing_area` VALUES(90, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
-- West Sarutabaruta [S] - 2 spots
INSERT INTO `fishing_area` VALUES(95, 1, 'Pond', 1, 20, 25, '', 110.000, -1.000, -200.000);
INSERT INTO `fishing_area` VALUES(95, 2, 'Seaside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
-- North Gustaberg [S] - 1 spot
/*INSERT INTO `fishing_area` VALUES(88, 1, 'Basin of Waterfall', 1, 20, 27, '', -230.433, 96.000, 462.000);*/
INSERT INTO `fishing_area` VALUES(88, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
-- Grauberg [S] - 2 spots
INSERT INTO `fishing_area` VALUES(89, 2, 'All Waterside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
INSERT INTO `fishing_area` VALUES(89, 1, 'Waterfall', 1, 30, 200, '', -102.265, -6.774, 581.573);
-- La Vaule [S] - 2 spots
INSERT INTO `fishing_area` VALUES(85, 1, 'Pond', 1, 20, 50, '', 198.750, 2.000, -107.220);
INSERT INTO `fishing_area` VALUES(85, 2, 'Other Waterside', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
-- Jugner Forest [S] - 3 spots
INSERT INTO `fishing_area` VALUES(82, 1, 'Lake Mechieume - Mouth', 1, 20, 31, '', 19.458, 3.000, 334.528);
INSERT INTO `fishing_area` VALUES(82, 2, 'Lake Mechieume - Main', 2, 20, 0, 0xc1ca2bc30000000010981544df4f0b430000000064d3114477de0d4300000000ec41a143235b30c3000000006871a343, 0.000, 5.000, 0.000);
INSERT INTO `fishing_area` VALUES(82, 3, 'River', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
/*INSERT INTO `fishing_area` VALUES(82, 4, 'Crystalwater Spring', 1, 20, 20, '', 300.000, 1.000, -179.833);
INSERT INTO `fishing_area` VALUES(82, 5, 'Maidens Spring', 1, 20, 22, '', -496.682, 9.000, 298.057);*/
-- Batallia Downs [S] - 1 spot
INSERT INTO `fishing_area` VALUES(84, 1, 'South Seaside', 1, 20, 150, '', 102.172, 8.000, -489.808);
-- East Ronfaure [S] - 1 spot
INSERT INTO `fishing_area` VALUES(81, 1, 'Whole Zone', 0, 0, 0, NULL, 0.000, 0.000, 0.000);
-- //END

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_area`
--
ALTER TABLE `fishing_area`
  ADD PRIMARY KEY (`zoneid`,`areaid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

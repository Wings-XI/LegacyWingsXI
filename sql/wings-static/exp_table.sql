-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:15 PM
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
-- Table structure for table `exp_table`
--

DROP TABLE IF EXISTS `exp_table`;
CREATE TABLE `exp_table` (
  `level` tinyint(2) NOT NULL,
  `r1` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r2` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r3` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r4` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r5` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r6` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r7` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r8` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r9` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r10` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r11` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r12` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r13` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r14` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r15` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r16` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r17` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r18` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r19` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `r20` smallint(4) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM AVG_ROW_LENGTH=65 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exp_table`
--

INSERT INTO `exp_table` VALUES(15, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 1500);
INSERT INTO `exp_table` VALUES(14, 800, 800, 800, 800, 800, 800, 720, 720, 720, 720, 720, 720, 720, 720, 720, 720, 720, 720, 720, 1500);
INSERT INTO `exp_table` VALUES(13, 800, 800, 800, 750, 680, 660, 640, 640, 630, 630, 630, 630, 630, 630, 630, 630, 630, 630, 630, 1500);
INSERT INTO `exp_table` VALUES(12, 800, 800, 750, 700, 640, 640, 640, 640, 600, 580, 580, 580, 580, 580, 580, 580, 580, 580, 580, 1400);
INSERT INTO `exp_table` VALUES(11, 750, 700, 700, 640, 640, 640, 640, 640, 600, 580, 530, 530, 530, 530, 530, 530, 530, 530, 530, 1300);
INSERT INTO `exp_table` VALUES(10, 700, 660, 620, 620, 620, 620, 620, 620, 570, 530, 480, 480, 480, 480, 480, 480, 480, 480, 480, 1200);
INSERT INTO `exp_table` VALUES(9, 600, 600, 600, 600, 600, 600, 600, 560, 530, 480, 440, 440, 440, 440, 440, 400, 400, 400, 400, 1100);
INSERT INTO `exp_table` VALUES(8, 600, 600, 600, 600, 550, 550, 550, 530, 480, 430, 400, 400, 400, 400, 400, 380, 380, 380, 380, 1000);
INSERT INTO `exp_table` VALUES(7, 550, 550, 550, 550, 500, 500, 500, 470, 430, 380, 360, 360, 360, 360, 360, 340, 340, 340, 340, 900);
INSERT INTO `exp_table` VALUES(6, 450, 450, 450, 450, 450, 450, 450, 450, 400, 370, 330, 320, 320, 320, 320, 300, 300, 300, 300, 800);
INSERT INTO `exp_table` VALUES(5, 350, 350, 350, 350, 400, 400, 400, 400, 340, 310, 280, 280, 280, 280, 280, 260, 260, 260, 260, 700);
INSERT INTO `exp_table` VALUES(4, 200, 200, 200, 200, 300, 300, 300, 270, 250, 240, 240, 240, 240, 240, 240, 260, 240, 240, 240, 600);
INSERT INTO `exp_table` VALUES(3, 160, 160, 160, 160, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 320, 320, 320, 320, 500);
INSERT INTO `exp_table` VALUES(2, 140, 140, 140, 140, 150, 150, 150, 150, 150, 160, 160, 160, 160, 160, 160, 280, 280, 280, 280, 400);
INSERT INTO `exp_table` VALUES(1, 120, 120, 120, 120, 125, 125, 125, 125, 125, 130, 130, 130, 130, 130, 130, 240, 240, 240, 240, 300);
INSERT INTO `exp_table` VALUES(0, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 200, 200, 200, 200, 200);
INSERT INTO `exp_table` VALUES(-1, 90, 90, 90, 90, 93, 96, 95, 95, 96, 96, 96, 96, 97, 97, 97, 195, 195, 195, 195, 195);
INSERT INTO `exp_table` VALUES(-2, 80, 80, 80, 80, 86, 86, 90, 90, 93, 93, 93, 93, 95, 95, 95, 190, 190, 190, 190, 190);
INSERT INTO `exp_table` VALUES(-3, 70, 70, 75, 75, 80, 80, 85, 85, 90, 90, 90, 90, 92, 92, 92, 184, 184, 184, 184, 185);
INSERT INTO `exp_table` VALUES(-4, 65, 65, 70, 70, 75, 76, 80, 80, 85, 85, 86, 86, 90, 90, 90, 180, 180, 180, 180, 180);
INSERT INTO `exp_table` VALUES(-5, 60, 60, 65, 65, 70, 73, 76, 76, 80, 80, 83, 83, 86, 86, 86, 172, 172, 172, 172, 172);
INSERT INTO `exp_table` VALUES(-6, 50, 50, 60, 60, 65, 70, 73, 73, 76, 76, 80, 80, 83, 83, 83, 166, 166, 166, 166, 166);
INSERT INTO `exp_table` VALUES(-7, 0, 40, 50, 55, 60, 65, 70, 70, 73, 73, 76, 77, 80, 80, 80, 160, 160, 160, 160, 160);
INSERT INTO `exp_table` VALUES(-8, 0, 30, 40, 50, 55, 60, 65, 66, 70, 70, 73, 75, 77, 77, 77, 155, 155, 155, 155, 155);
INSERT INTO `exp_table` VALUES(-9, 0, 0, 30, 40, 50, 55, 60, 63, 66, 66, 70, 72, 75, 75, 75, 150, 150, 150, 150, 150);
INSERT INTO `exp_table` VALUES(-10, 0, 0, 0, 30, 40, 50, 55, 60, 63, 63, 66, 70, 72, 72, 72, 145, 145, 145, 145, 145);
INSERT INTO `exp_table` VALUES(-11, 0, 0, 0, 0, 30, 40, 50, 55, 60, 60, 63, 66, 70, 70, 70, 140, 140, 140, 140, 140);
INSERT INTO `exp_table` VALUES(-12, 0, 0, 0, 0, 0, 30, 40, 50, 55, 56, 60, 63, 66, 66, 66, 132, 132, 132, 132, 132);
INSERT INTO `exp_table` VALUES(-13, 0, 0, 0, 0, 0, 0, 30, 40, 50, 53, 56, 60, 63, 63, 63, 126, 126, 126, 126, 126);
INSERT INTO `exp_table` VALUES(-14, 0, 0, 0, 0, 0, 0, 0, 30, 40, 50, 53, 56, 60, 60, 60, 120, 120, 120, 120, 120);
INSERT INTO `exp_table` VALUES(-15, 0, 0, 0, 0, 0, 0, 0, 0, 30, 40, 50, 53, 56, 56, 56, 112, 112, 112, 112, 112);
INSERT INTO `exp_table` VALUES(-16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 40, 50, 53, 53, 53, 106, 106, 106, 106, 106);
INSERT INTO `exp_table` VALUES(-17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 40, 50, 50, 50, 100, 100, 100, 100, 100);
INSERT INTO `exp_table` VALUES(-18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 40, 40, 40, 90, 90, 90, 90, 90);
INSERT INTO `exp_table` VALUES(-19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 30, 80, 80, 80, 80, 80);
INSERT INTO `exp_table` VALUES(-20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 70, 70, 70, 70);
INSERT INTO `exp_table` VALUES(-21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 60);
INSERT INTO `exp_table` VALUES(-22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 55, 55, 55, 55);
INSERT INTO `exp_table` VALUES(-23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 50, 50, 50, 50);
INSERT INTO `exp_table` VALUES(-24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 48, 48, 48, 48);
INSERT INTO `exp_table` VALUES(-25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 45, 45, 45, 45);
INSERT INTO `exp_table` VALUES(-26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 42, 42, 42, 42);
INSERT INTO `exp_table` VALUES(-27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 40, 40, 40, 40);
INSERT INTO `exp_table` VALUES(-28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 38, 38, 38, 38);
INSERT INTO `exp_table` VALUES(-29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 36, 36, 36, 36);
INSERT INTO `exp_table` VALUES(-30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 34, 34, 34, 34);
INSERT INTO `exp_table` VALUES(-31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 32, 32, 32, 32);
INSERT INTO `exp_table` VALUES(-32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 30, 30, 30);
INSERT INTO `exp_table` VALUES(-33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 28, 28, 28, 28);
INSERT INTO `exp_table` VALUES(-34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 26, 26, 26, 26);
INSERT INTO `exp_table` VALUES(-35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24, 24, 24, 24, 24);
INSERT INTO `exp_table` VALUES(-36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 22, 22, 22, 22);
INSERT INTO `exp_table` VALUES(-37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20);
INSERT INTO `exp_table` VALUES(-38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 19, 19, 19, 19);
INSERT INTO `exp_table` VALUES(-39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 18, 18);
INSERT INTO `exp_table` VALUES(-40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17, 17, 17, 17);
INSERT INTO `exp_table` VALUES(-41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 16, 16, 16, 16);
INSERT INTO `exp_table` VALUES(-42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15);
INSERT INTO `exp_table` VALUES(-43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 14);
INSERT INTO `exp_table` VALUES(-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exp_table`
--
ALTER TABLE `exp_table`
  ADD PRIMARY KEY (`level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

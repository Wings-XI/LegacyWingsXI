-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:00 PM
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
-- Table structure for table `chars`
--

DROP TABLE IF EXISTS `chars`;
CREATE TABLE `chars` (
  `charid` int(10) UNSIGNED NOT NULL,
  `accid` int(10) UNSIGNED NOT NULL,
  `charname` varchar(15) NOT NULL,
  `nation` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `pos_zone` smallint(3) UNSIGNED NOT NULL,
  `pos_prevzone` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `pos_rot` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `pos_x` float(7,3) NOT NULL DEFAULT 0.000,
  `pos_y` float(7,3) NOT NULL DEFAULT 0.000,
  `pos_z` float(7,3) NOT NULL DEFAULT 0.000,
  `moghouse` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `boundary` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `home_zone` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `home_rot` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `home_x` float(7,3) NOT NULL DEFAULT 0.000,
  `home_y` float(7,3) NOT NULL DEFAULT 0.000,
  `home_z` float(7,3) NOT NULL DEFAULT 0.000,
  `missions` blob DEFAULT NULL,
  `assault` blob DEFAULT NULL,
  `campaign` blob DEFAULT NULL,
  `quests` blob DEFAULT NULL,
  `keyitems` blob DEFAULT NULL,
  `set_blue_spells` blob DEFAULT NULL,
  `abilities` blob DEFAULT NULL,
  `weaponskills` blob DEFAULT NULL,
  `titles` blob DEFAULT NULL,
  `zones` blob DEFAULT NULL,
  `playtime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `unlocked_weapons` blob DEFAULT NULL,
  `gmlevel` smallint(3) UNSIGNED NOT NULL DEFAULT 0,
  `mentor` smallint(3) NOT NULL DEFAULT 0,
  `campaign_allegiance` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `isstylelocked` tinyint(1) NOT NULL DEFAULT 0,
  `nnameflags` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `moghancement` smallint(4) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `chars`
--
DROP TRIGGER IF EXISTS `char_delete`;
DELIMITER $$
CREATE TRIGGER `char_delete` BEFORE DELETE ON `chars` FOR EACH ROW BEGIN
    DELETE FROM `char_blacklist` WHERE `charid_owner` = OLD.charid;
    DELETE FROM `char_effects`   WHERE `charid` = OLD.charid;
    DELETE FROM `char_equip`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_exp`       WHERE `charid` = OLD.charid;
    DELETE FROM `char_inventory` WHERE `charid` = OLD.charid;
    DELETE FROM `char_jobs`      WHERE `charid` = OLD.charid;
    DELETE FROM `char_look`      WHERE `charid` = OLD.charid;
    DELETE FROM `char_merit`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_pet`       WHERE `charid` = OLD.charid;
    DELETE FROM `char_points`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_unlocks`   WHERE `charid` = OLD.charid;
    DELETE FROM `char_profile`   WHERE `charid` = OLD.charid;
    DELETE FROM `char_recast`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_skills`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_spells`    WHERE `charid` = OLD.charid;
    DELETE FROM `char_stats`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_storage`   WHERE `charid` = OLD.charid;
    DELETE FROM `char_style`     WHERE `charid` = OLD.charid;
    DELETE FROM `char_vars`      WHERE `charid` = OLD.charid;
    DELETE FROM `auction_house`  WHERE `seller` = OLD.charid;
    DELETE FROM `delivery_box`   WHERE `charid` = OLD.charid;
    UPDATE `account_ip_record` SET `charid`  = 0 where `charid` = OLD.charid;
    UPDATE `delivery_box` SET sent = 0 WHERE box = 2 AND received = 0 AND sent = 1 AND senderid = OLD.charid;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `char_insert`;
DELIMITER $$
CREATE TRIGGER `char_insert` BEFORE INSERT ON `chars` FOR EACH ROW BEGIN
    INSERT INTO `char_equip`     SET `charid` = NEW.charid;
    INSERT INTO `char_exp`       SET `charid` = NEW.charid;
    INSERT INTO `char_jobs`      SET `charid` = NEW.charid;
    INSERT INTO `char_pet`       SET `charid` = NEW.charid;
    INSERT INTO `char_points`    SET `charid` = NEW.charid;
    INSERT INTO `char_unlocks`   SET `charid` = NEW.charid;
    INSERT INTO `char_profile`   SET `charid` = NEW.charid;
    INSERT INTO `char_storage`   SET `charid` = NEW.charid;
    INSERT INTO `char_inventory` SET `charid` = NEW.charid;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chars`
--
ALTER TABLE `chars`
  ADD PRIMARY KEY (`charid`);
ALTER TABLE `chars` ADD FULLTEXT KEY `charname` (`charname`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

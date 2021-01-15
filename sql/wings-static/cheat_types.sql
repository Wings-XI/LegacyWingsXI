-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 31, 2020 at 07:12 PM
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
-- Table structure for table `cheat_types`
--

DROP TABLE IF EXISTS `cheat_types`;
CREATE TABLE `cheat_types` (
  `cheatid` int(10) UNSIGNED NOT NULL,
  `name` varchar(15) NOT NULL,
  `description` varchar(128) NOT NULL,
  `argument` int(10) UNSIGNED NOT NULL,
  `action_bitmask` int(10) UNSIGNED NOT NULL,
  `warning_message` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cheat_types`
--

INSERT INTO `cheat_types` (`cheatid`, `name`, `description`, `argument`, `action_bitmask`, `warning_message`) VALUES(1, 'FASTSYNTH', 'Player injects a synth done (0x59) packet to perform synth and craft skillups faster than the game allows.', 0, 7, 'A fast craft cheating attempt has been attempted. Successful craft has been blocked and the incident will be reported.');
INSERT INTO `cheat_types` (`cheatid`, `name`, `description`, `argument`, `action_bitmask`, `warning_message`) VALUES(2, 'POSHACK', 'The player used an addon to teleport into a different position in the zone.', 0, 9, 'You have been caught speed / position hacking. Your account will be banned.');
INSERT INTO `cheat_types` (`cheatid`, `name`, `description`, `argument`, `action_bitmask`, `warning_message`) VALUES(3, 'FISHBOT', 'Player is using an automated fishing tool', 0, 3, 'Fishing bot detected. You have been banned from fishing.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cheat_types`
--
ALTER TABLE `cheat_types`
  ADD PRIMARY KEY (`cheatid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

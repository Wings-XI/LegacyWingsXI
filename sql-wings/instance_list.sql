-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01,  2021 at 07:15 PM
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
-- Table structure for table `instance_list`
--

DROP TABLE IF EXISTS `instance_list`;
CREATE TABLE `instance_list` (
  `instanceid` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `instance_name` varchar(35) NOT NULL DEFAULT '',
  `entrance_zone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time_limit` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `start_x` float(7,3) NOT NULL DEFAULT 0.000,
  `start_y` float(7,3) NOT NULL DEFAULT 0.000,
  `start_z` float(7,3) NOT NULL DEFAULT 0.000,
  `start_rot` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `music_day` smallint(3) NOT NULL DEFAULT -1,
  `music_night` smallint(3) NOT NULL DEFAULT -1,
  `battlesolo` smallint(3) NOT NULL DEFAULT -1,
  `battlemulti` smallint(3) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `instance_list`
--

INSERT INTO `instance_list` VALUES (0, 'TEST', 0, 0, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (1, 'leujaoam_cleansing', 79, 30, 280.000, -7.500, 35.000, 195, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (2, 'orichalcum_survey', 69, 79, 30, -432.000, -27.627, 169.000, 131, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (3, 'escort_professor_chanoix', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (4, 'shanarha_grass_conservation', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (5, 'counting_sheep', 69, 79, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (6, 'supplies_recovery', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (7, 'azure_experiments', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (8, 'imperial_code', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (9, 'red_versus_blue', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (10, 'bloody_rondo', 69, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (11, 'imperial_agent_rescue', 52, 30, -20.000, 2.276, -405.000, 63, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (12, 'preemptive_strike', 66, 52, 30, -60.35, -5.0, 27.67, 46, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (13, 'sagelord_elimination', 66, 52, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (14, 'breaking_morale', 66, 52, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (15, 'the_double_agent', 66, 52, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (16, 'imperial_treasure_retrieval', 66, 52, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (17, 'blitzkrieg', 66, 52, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (18, 'marids_in_the_mist', 66, 52, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (19, 'azure_ailments', 66, 52, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (20, 'the_susanoo_shuffle', 66, 52, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (21, 'excavation_duty', 61, 30, 124.999, -39.309, 19.999, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (22, 'lebros_supplies', 63, 61, 30, -333.000, -9.921, -259.999, 270, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (23, 'troll_fugitives', 63, 61, 30, -459.912, -9.860, 342.319, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (24, 'evade_and_escape', 63, 61, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (25, 'siegemaster_assassination', 63, 61, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (26, 'apkallu_breeding', 63, 61, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (27, 'wamoura_farm_raid', 63, 61, 30, 540.977, -39.976, 220.919, 128, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (28, 'egg_conservation', 63, 61, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (29, 'operation:black_pearl', 63, 61, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (30, 'better_than_one', 63, 61, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (31, 'seagull_grounded', 79, 30, -350.000, -15.245, 380.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (32, 'requiem', 56, 79, 30, -470.000, -9.964, -325.000, 190, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (33, 'saving_private_ryaaf', 56, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (34, 'shooting_down_the_baron', 56, 79, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (35, 'building_bridges', 56, 79, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (36, 'stop_the_bloodshed', 56, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (37, 'defuse_the_threat', 56, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (38, 'operation:snake_eyes', 56, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (39, 'wake_the_puppet', 56, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (40, 'the_price_is_right', 56, 79, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (41, 'golden_salvage', 54, 30, 386.000, -12.000, 17.000, 46, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (42, 'lamia_no_13', 55, 54, 30, 155.000, -7.000, -175.000, 47, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (43, 'extermination', 55, 54, 30, 298.099, -3.943, 135.234, 149, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (44, 'demolition_duty', 55, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (45, 'searat_salvation', 55, 54, 15, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (46, 'apkallu_seizure', 55, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (47, 'lost_and_found', 55, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (48, 'deserter', 55, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (49, 'desperately_seeking_cephalopods', 55, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (50, 'bellerophons_bliss', 55, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (51, 'nyzul_isle_investigation', 72, 30, -20.000, -4.000, -20.000, 196, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (52, 'nyzul_isle_uncharted_survey', 72, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (53, 'the_black_coffin', 54, 30, 0, -22, 24, 64, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (54, 'against_all_odds', 54, 30, -9.000, -22.000, 17.000, 252, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (55, 'scouting_the_ashu_talif', 60, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (56, 'royal_painter_escort', 60, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (57, 'targeting_the_captain', 60, 54, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (58, 'path_of_darkness', 72, 30, 500, 0, -572, 192, 143, 143, 143, 143);
INSERT INTO `instance_list` VALUES (59, 'nashmeiras_plea', 72, 45, -444, -4, 420, 127, 143, 143, 143, 143);
-- INSERT INTO `instance_list` VALUES (60, 'forging_a_new_myth', 77, 72, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (61, 'waking_the_colossus', 77, 72, 30, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (62, 'zhayolm_remnants', 73, 72, 100, 340.000, 0.000, -592.000, 192, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (64, 'zhayolm_remnants_ii', 73, 72, 100, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (65, 'arrapago_remnants', 74, 72, 100, 340.000, 0.000, -246.000, 63, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (67, 'arrapago_remnants_ii', 74, 72, 100, 340.000, 0.000, -246.000, 63, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (68, 'bhaflau_remnants', 75, 72, 100, 340.000, 19.000, -552.000, 191, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (70, 'bhaflau_remnants_ii', 75, 72, 100, 0.000, 0.000, 0.000, 0, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (71, 'silver_sea_remnants', 76, 72, 100, 340.000, 12.000, -165.500, 63, -1, -1, -1, -1);
-- INSERT INTO `instance_list` VALUES (73, 'silver_sea_remnants_ii', 76, 72, 100, 340.000, 12.000, -165.500, 63, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (79, 'shades_of_vengeance', 79, 30, 127, -15, -303, 0, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES (89, 'seeing_blood_red', 89, 30, -323.568, -23.825, -19.749, 128, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(90, 'light_in_the_darkness', 90, 30, -22.500, 1.6823, 40.00, 192, -1, -1, -1, -1);
INSERT INTO `instance_list` VALUES(96, 'a_manifest_problem', 96, 30, -220.89, 30.198, 258.137, 254, -1, -1, -1, -1);
--
-- Indexes for dumped tables
--

--
-- Indexes for table `instance_list`
--
ALTER TABLE `instance_list`
  ADD PRIMARY KEY (`instanceid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:11 PM
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
-- Table structure for table `fishing_zone`
--

DROP TABLE IF EXISTS `fishing_zone`;
CREATE TABLE `fishing_zone` (
  `zoneid` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `difficulty` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fishing_zone`
--

INSERT INTO `fishing_zone` VALUES(0, 'unknown', 0);
INSERT INTO `fishing_zone` VALUES(1, 'Phanauet_Channel', 0);
INSERT INTO `fishing_zone` VALUES(2, 'Carpenters_Landing', 0);
INSERT INTO `fishing_zone` VALUES(3, 'Manaclipper', 0);
INSERT INTO `fishing_zone` VALUES(4, 'Bibiki_Bay', 0);
INSERT INTO `fishing_zone` VALUES(5, 'Uleguerand_Range', 0);
INSERT INTO `fishing_zone` VALUES(6, 'Bearclaw_Pinnacle', 0);
INSERT INTO `fishing_zone` VALUES(7, 'Attohwa_Chasm', 0);
INSERT INTO `fishing_zone` VALUES(8, 'Boneyard_Gully', 0);
INSERT INTO `fishing_zone` VALUES(9, 'PsoXja', 0);
INSERT INTO `fishing_zone` VALUES(10, 'The_Shrouded_Maw', 0);
INSERT INTO `fishing_zone` VALUES(11, 'Oldton_Movalpolos', 0);
INSERT INTO `fishing_zone` VALUES(12, 'Newton_Movalpolos', 0);
INSERT INTO `fishing_zone` VALUES(13, 'Mine_Shaft_2716', 0);
INSERT INTO `fishing_zone` VALUES(14, 'Hall_of_Transference', 0);
INSERT INTO `fishing_zone` VALUES(15, 'Abyssea-Konschtat', 0);
INSERT INTO `fishing_zone` VALUES(16, 'Promyvion-Holla', 0);
INSERT INTO `fishing_zone` VALUES(17, 'Spire_of_Holla', 0);
INSERT INTO `fishing_zone` VALUES(18, 'Promyvion-Dem', 0);
INSERT INTO `fishing_zone` VALUES(19, 'Spire_of_Dem', 0);
INSERT INTO `fishing_zone` VALUES(20, 'Promyvion-Mea', 0);
INSERT INTO `fishing_zone` VALUES(21, 'Spire_of_Mea', 0);
INSERT INTO `fishing_zone` VALUES(22, 'Promyvion-Vahzl', 0);
INSERT INTO `fishing_zone` VALUES(23, 'Spire_of_Vahzl', 0);
INSERT INTO `fishing_zone` VALUES(24, 'Lufaise_Meadows', 0);
INSERT INTO `fishing_zone` VALUES(25, 'Misareaux_Coast', 0);
INSERT INTO `fishing_zone` VALUES(26, 'Tavnazian_Safehold', 0);
INSERT INTO `fishing_zone` VALUES(27, 'Phomiuna_Aqueducts', 0);
INSERT INTO `fishing_zone` VALUES(28, 'Sacrarium', 0);
INSERT INTO `fishing_zone` VALUES(29, 'Riverne-Site_B01', 0);
INSERT INTO `fishing_zone` VALUES(30, 'Riverne-Site_A01', 0);
INSERT INTO `fishing_zone` VALUES(31, 'Monarch_Linn', 0);
INSERT INTO `fishing_zone` VALUES(32, 'Sealions_Den', 0);
INSERT INTO `fishing_zone` VALUES(33, 'AlTaieu', 0);
INSERT INTO `fishing_zone` VALUES(34, 'Grand_Palace_of_HuXzoi', 0);
INSERT INTO `fishing_zone` VALUES(35, 'The_Garden_of_RuHmet', 0);
INSERT INTO `fishing_zone` VALUES(36, 'Empyreal_Paradox', 0);
INSERT INTO `fishing_zone` VALUES(37, 'Temenos', 0);
INSERT INTO `fishing_zone` VALUES(38, 'Apollyon', 0);
INSERT INTO `fishing_zone` VALUES(39, 'Dynamis-Valkurm', 0);
INSERT INTO `fishing_zone` VALUES(40, 'Dynamis-Buburimu', 0);
INSERT INTO `fishing_zone` VALUES(41, 'Dynamis-Qufim', 0);
INSERT INTO `fishing_zone` VALUES(42, 'Dynamis-Tavnazia', 0);
INSERT INTO `fishing_zone` VALUES(43, 'Diorama_Abdhaljs-Ghelsba', 0);
INSERT INTO `fishing_zone` VALUES(44, 'Abdhaljs_Isle-Purgonorgo', 0);
INSERT INTO `fishing_zone` VALUES(45, 'Abyssea-Tahrongi', 0);
INSERT INTO `fishing_zone` VALUES(46, 'Open_sea_route_to_Al_Zahbi', 0);
INSERT INTO `fishing_zone` VALUES(47, 'Open_sea_route_to_Mhaura', 0);
INSERT INTO `fishing_zone` VALUES(48, 'Al_Zahbi', 0);
INSERT INTO `fishing_zone` VALUES(49, '49', 0);
INSERT INTO `fishing_zone` VALUES(50, 'Aht_Urhgan_Whitegate', 0);
INSERT INTO `fishing_zone` VALUES(51, 'Wajaom_Woodlands', 0);
INSERT INTO `fishing_zone` VALUES(52, 'Bhaflau_Thickets', 0);
INSERT INTO `fishing_zone` VALUES(53, 'Nashmau', 0);
INSERT INTO `fishing_zone` VALUES(54, 'Arrapago_Reef', 0);
INSERT INTO `fishing_zone` VALUES(55, 'Ilrusi_Atoll', 0);
INSERT INTO `fishing_zone` VALUES(56, 'Periqia', 0);
INSERT INTO `fishing_zone` VALUES(57, 'Talacca_Cove', 0);
INSERT INTO `fishing_zone` VALUES(58, 'Silver_Sea_route_to_Nashmau', 0);
INSERT INTO `fishing_zone` VALUES(59, 'Silver_Sea_route_to_Al_Zahbi', 0);
INSERT INTO `fishing_zone` VALUES(60, 'The_Ashu_Talif', 0);
INSERT INTO `fishing_zone` VALUES(61, 'Mount_Zhayolm', 0);
INSERT INTO `fishing_zone` VALUES(62, 'Halvung', 0);
INSERT INTO `fishing_zone` VALUES(63, 'Lebros_Cavern', 0);
INSERT INTO `fishing_zone` VALUES(64, 'Navukgo_Execution_Chamber', 0);
INSERT INTO `fishing_zone` VALUES(65, 'Mamook', 0);
INSERT INTO `fishing_zone` VALUES(66, 'Mamool_Ja_Training_Grounds', 0);
INSERT INTO `fishing_zone` VALUES(67, 'Jade_Sepulcher', 0);
INSERT INTO `fishing_zone` VALUES(68, 'Aydeewa_Subterrane', 0);
INSERT INTO `fishing_zone` VALUES(69, 'Leujaoam_Sanctum', 0);
INSERT INTO `fishing_zone` VALUES(70, 'Chocobo_Circuit', 0);
INSERT INTO `fishing_zone` VALUES(71, 'The_Colosseum', 0);
INSERT INTO `fishing_zone` VALUES(72, 'Alzadaal_Undersea_Ruins', 0);
INSERT INTO `fishing_zone` VALUES(73, 'Zhayolm_Remnants', 0);
INSERT INTO `fishing_zone` VALUES(74, 'Arrapago_Remnants', 0);
INSERT INTO `fishing_zone` VALUES(75, 'Bhaflau_Remnants', 0);
INSERT INTO `fishing_zone` VALUES(76, 'Silver_Sea_Remnants', 0);
INSERT INTO `fishing_zone` VALUES(77, 'Nyzul_Isle', 0);
INSERT INTO `fishing_zone` VALUES(78, 'Hazhalm_Testing_Grounds', 0);
INSERT INTO `fishing_zone` VALUES(79, 'Caedarva_Mire', 0);
INSERT INTO `fishing_zone` VALUES(80, 'Southern_San_dOria_[S]', 0);
INSERT INTO `fishing_zone` VALUES(81, 'East_Ronfaure_[S]', 0);
INSERT INTO `fishing_zone` VALUES(82, 'Jugner_Forest_[S]', 0);
INSERT INTO `fishing_zone` VALUES(83, 'Vunkerl_Inlet_[S]', 0);
INSERT INTO `fishing_zone` VALUES(84, 'Batallia_Downs_[S]', 0);
INSERT INTO `fishing_zone` VALUES(85, 'La_Vaule_[S]', 0);
INSERT INTO `fishing_zone` VALUES(86, 'Everbloom_Hollow', 0);
INSERT INTO `fishing_zone` VALUES(87, 'Bastok_Markets_[S]', 0);
INSERT INTO `fishing_zone` VALUES(88, 'North_Gustaberg_[S]', 0);
INSERT INTO `fishing_zone` VALUES(89, 'Grauberg_[S]', 0);
INSERT INTO `fishing_zone` VALUES(90, 'Pashhow_Marshlands_[S]', 0);
INSERT INTO `fishing_zone` VALUES(91, 'Rolanberry_Fields_[S]', 0);
INSERT INTO `fishing_zone` VALUES(92, 'Beadeaux_[S]', 0);
INSERT INTO `fishing_zone` VALUES(93, 'Ruhotz_Silvermines', 0);
INSERT INTO `fishing_zone` VALUES(94, 'Windurst_Waters_[S]', 0);
INSERT INTO `fishing_zone` VALUES(95, 'West_Sarutabaruta_[S]', 0);
INSERT INTO `fishing_zone` VALUES(96, 'Fort_Karugo-Narugo_[S]', 0);
INSERT INTO `fishing_zone` VALUES(97, 'Meriphataud_Mountains_[S]', 0);
INSERT INTO `fishing_zone` VALUES(98, 'Sauromugue_Champaign_[S]', 0);
INSERT INTO `fishing_zone` VALUES(99, 'Castle_Oztroja_[S]', 0);
INSERT INTO `fishing_zone` VALUES(100, 'West_Ronfaure', 0);
INSERT INTO `fishing_zone` VALUES(101, 'East_Ronfaure', 0);
INSERT INTO `fishing_zone` VALUES(102, 'La_Theine_Plateau', 0);
INSERT INTO `fishing_zone` VALUES(103, 'Valkurm_Dunes', 0);
INSERT INTO `fishing_zone` VALUES(104, 'Jugner_Forest', 0);
INSERT INTO `fishing_zone` VALUES(105, 'Batallia_Downs', 0);
INSERT INTO `fishing_zone` VALUES(106, 'North_Gustaberg', 0);
INSERT INTO `fishing_zone` VALUES(107, 'South_Gustaberg', 0);
INSERT INTO `fishing_zone` VALUES(108, 'Konschtat_Highlands', 0);
INSERT INTO `fishing_zone` VALUES(109, 'Pashhow_Marshlands', 0);
INSERT INTO `fishing_zone` VALUES(110, 'Rolanberry_Fields', 0);
INSERT INTO `fishing_zone` VALUES(111, 'Beaucedine_Glacier', 0);
INSERT INTO `fishing_zone` VALUES(112, 'Xarcabard', 0);
INSERT INTO `fishing_zone` VALUES(113, 'Cape_Teriggan', 0);
INSERT INTO `fishing_zone` VALUES(114, 'Eastern_Altepa_Desert', 0);
INSERT INTO `fishing_zone` VALUES(115, 'West_Sarutabaruta', 0);
INSERT INTO `fishing_zone` VALUES(116, 'East_Sarutabaruta', 0);
INSERT INTO `fishing_zone` VALUES(117, 'Tahrongi_Canyon', 0);
INSERT INTO `fishing_zone` VALUES(118, 'Buburimu_Peninsula', 0);
INSERT INTO `fishing_zone` VALUES(119, 'Meriphataud_Mountains', 0);
INSERT INTO `fishing_zone` VALUES(120, 'Sauromugue_Champaign', 0);
INSERT INTO `fishing_zone` VALUES(121, 'The_Sanctuary_of_ZiTah', 0);
INSERT INTO `fishing_zone` VALUES(122, 'RoMaeve', 0);
INSERT INTO `fishing_zone` VALUES(123, 'Yuhtunga_Jungle', 0);
INSERT INTO `fishing_zone` VALUES(124, 'Yhoator_Jungle', 0);
INSERT INTO `fishing_zone` VALUES(125, 'Western_Altepa_Desert', 0);
INSERT INTO `fishing_zone` VALUES(126, 'Qufim_Island', 0);
INSERT INTO `fishing_zone` VALUES(127, 'Behemoths_Dominion', 0);
INSERT INTO `fishing_zone` VALUES(128, 'Valley_of_Sorrows', 0);
INSERT INTO `fishing_zone` VALUES(129, 'Ghoyus_Reverie', 0);
INSERT INTO `fishing_zone` VALUES(130, 'RuAun_Gardens', 0);
INSERT INTO `fishing_zone` VALUES(131, 'Mordion_Gaol', 0);
INSERT INTO `fishing_zone` VALUES(132, 'Abyssea-La_Theine', 0);
INSERT INTO `fishing_zone` VALUES(133, '133', 0);
INSERT INTO `fishing_zone` VALUES(134, 'Dynamis-Beaucedine', 0);
INSERT INTO `fishing_zone` VALUES(135, 'Dynamis-Xarcabard', 0);
INSERT INTO `fishing_zone` VALUES(136, 'Beaucedine_Glacier_[S]', 0);
INSERT INTO `fishing_zone` VALUES(137, 'Xarcabard_[S]', 0);
INSERT INTO `fishing_zone` VALUES(138, 'Castle_Zvahl_Baileys_[S]', 0);
INSERT INTO `fishing_zone` VALUES(139, 'Horlais_Peak', 0);
INSERT INTO `fishing_zone` VALUES(140, 'Ghelsba_Outpost', 0);
INSERT INTO `fishing_zone` VALUES(141, 'Fort_Ghelsba', 0);
INSERT INTO `fishing_zone` VALUES(142, 'Yughott_Grotto', 0);
INSERT INTO `fishing_zone` VALUES(143, 'Palborough_Mines', 0);
INSERT INTO `fishing_zone` VALUES(144, 'Waughroon_Shrine', 0);
INSERT INTO `fishing_zone` VALUES(145, 'Giddeus', 0);
INSERT INTO `fishing_zone` VALUES(146, 'Balgas_Dais', 0);
INSERT INTO `fishing_zone` VALUES(147, 'Beadeaux', 0);
INSERT INTO `fishing_zone` VALUES(148, 'Qulun_Dome', 0);
INSERT INTO `fishing_zone` VALUES(149, 'Davoi', 0);
INSERT INTO `fishing_zone` VALUES(150, 'Monastic_Cavern', 0);
INSERT INTO `fishing_zone` VALUES(151, 'Castle_Oztroja', 0);
INSERT INTO `fishing_zone` VALUES(152, 'Altar_Room', 0);
INSERT INTO `fishing_zone` VALUES(153, 'The_Boyahda_Tree', 0);
INSERT INTO `fishing_zone` VALUES(154, 'Dragons_Aery', 2);
INSERT INTO `fishing_zone` VALUES(155, 'Castle_Zvahl_Keep_[S]', 0);
INSERT INTO `fishing_zone` VALUES(156, 'Throne_Room_[S]', 0);
INSERT INTO `fishing_zone` VALUES(157, 'Middle_Delkfutts_Tower', 0);
INSERT INTO `fishing_zone` VALUES(158, 'Upper_Delkfutts_Tower', 0);
INSERT INTO `fishing_zone` VALUES(159, 'Temple_of_Uggalepih', 0);
INSERT INTO `fishing_zone` VALUES(160, 'Den_of_Rancor', 0);
INSERT INTO `fishing_zone` VALUES(161, 'Castle_Zvahl_Baileys', 0);
INSERT INTO `fishing_zone` VALUES(162, 'Castle_Zvahl_Keep', 0);
INSERT INTO `fishing_zone` VALUES(163, 'Sacrificial_Chamber', 0);
INSERT INTO `fishing_zone` VALUES(164, 'Garlaige_Citadel_[S]', 0);
INSERT INTO `fishing_zone` VALUES(165, 'Throne_Room', 0);
INSERT INTO `fishing_zone` VALUES(166, 'Ranguemont_Pass', 0);
INSERT INTO `fishing_zone` VALUES(167, 'Bostaunieux_Oubliette', 0);
INSERT INTO `fishing_zone` VALUES(168, 'Chamber_of_Oracles', 0);
INSERT INTO `fishing_zone` VALUES(169, 'Toraimarai_Canal', 0);
INSERT INTO `fishing_zone` VALUES(170, 'Full_Moon_Fountain', 0);
INSERT INTO `fishing_zone` VALUES(171, 'Crawlers_Nest_[S]', 0);
INSERT INTO `fishing_zone` VALUES(172, 'Zeruhn_Mines', 0);
INSERT INTO `fishing_zone` VALUES(173, 'Korroloka_Tunnel', 0);
INSERT INTO `fishing_zone` VALUES(174, 'Kuftal_Tunnel', 5);
INSERT INTO `fishing_zone` VALUES(175, 'The_Eldieme_Necropolis_[S]', 0);
INSERT INTO `fishing_zone` VALUES(176, 'Sea_Serpent_Grotto', 0);
INSERT INTO `fishing_zone` VALUES(177, 'VeLugannon_Palace', 0);
INSERT INTO `fishing_zone` VALUES(178, 'The_Shrine_of_RuAvitau', 0);
INSERT INTO `fishing_zone` VALUES(179, 'Stellar_Fulcrum', 0);
INSERT INTO `fishing_zone` VALUES(180, 'LaLoff_Amphitheater', 0);
INSERT INTO `fishing_zone` VALUES(181, 'The_Celestial_Nexus', 0);
INSERT INTO `fishing_zone` VALUES(182, 'Walk_of_Echoes', 0);
INSERT INTO `fishing_zone` VALUES(183, 'Maquette_Abdhaljs-Legion', 0);
INSERT INTO `fishing_zone` VALUES(184, 'Lower_Delkfutts_Tower', 0);
INSERT INTO `fishing_zone` VALUES(185, 'Dynamis-San_dOria', 0);
INSERT INTO `fishing_zone` VALUES(186, 'Dynamis-Bastok', 0);
INSERT INTO `fishing_zone` VALUES(187, 'Dynamis-Windurst', 0);
INSERT INTO `fishing_zone` VALUES(188, 'Dynamis-Jeuno', 0);
INSERT INTO `fishing_zone` VALUES(189, 'Residential_Area', 0);
INSERT INTO `fishing_zone` VALUES(190, 'King_Ranperres_Tomb', 0);
INSERT INTO `fishing_zone` VALUES(191, 'Dangruf_Wadi', 0);
INSERT INTO `fishing_zone` VALUES(192, 'Inner_Horutoto_Ruins', 0);
INSERT INTO `fishing_zone` VALUES(193, 'Ordelles_Caves', 0);
INSERT INTO `fishing_zone` VALUES(194, 'Outer_Horutoto_Ruins', 0);
INSERT INTO `fishing_zone` VALUES(195, 'The_Eldieme_Necropolis', 0);
INSERT INTO `fishing_zone` VALUES(196, 'Gusgen_Mines', 0);
INSERT INTO `fishing_zone` VALUES(197, 'Crawlers_Nest', 0);
INSERT INTO `fishing_zone` VALUES(198, 'Maze_of_Shakhrami', 0);
INSERT INTO `fishing_zone` VALUES(199, 'Residential_Area', 0);
INSERT INTO `fishing_zone` VALUES(200, 'Garlaige_Citadel', 0);
INSERT INTO `fishing_zone` VALUES(201, 'Cloister_of_Gales', 0);
INSERT INTO `fishing_zone` VALUES(202, 'Cloister_of_Storms', 0);
INSERT INTO `fishing_zone` VALUES(203, 'Cloister_of_Frost', 0);
INSERT INTO `fishing_zone` VALUES(204, 'FeiYin', 0);
INSERT INTO `fishing_zone` VALUES(205, 'Ifrits_Cauldron', 0);
INSERT INTO `fishing_zone` VALUES(206, 'QuBia_Arena', 0);
INSERT INTO `fishing_zone` VALUES(207, 'Cloister_of_Flames', 0);
INSERT INTO `fishing_zone` VALUES(208, 'Quicksand_Caves', 0);
INSERT INTO `fishing_zone` VALUES(209, 'Cloister_of_Tremors', 0);
INSERT INTO `fishing_zone` VALUES(210, 'GM_Home', 0);
INSERT INTO `fishing_zone` VALUES(211, 'Cloister_of_Tides', 0);
INSERT INTO `fishing_zone` VALUES(212, 'Gustav_Tunnel', 0);
INSERT INTO `fishing_zone` VALUES(213, 'Labyrinth_of_Onzozo', 0);
INSERT INTO `fishing_zone` VALUES(214, 'Residential_Area', 0);
INSERT INTO `fishing_zone` VALUES(215, 'Abyssea-Attohwa', 0);
INSERT INTO `fishing_zone` VALUES(216, 'Abyssea-Misareaux', 0);
INSERT INTO `fishing_zone` VALUES(217, 'Abyssea-Vunkerl', 0);
INSERT INTO `fishing_zone` VALUES(218, 'Abyssea-Altepa', 0);
INSERT INTO `fishing_zone` VALUES(219, 'Residential_Area', 0);
INSERT INTO `fishing_zone` VALUES(220, 'Ship_bound_for_Selbina', 0);
INSERT INTO `fishing_zone` VALUES(221, 'Ship_bound_for_Mhaura', 0);
INSERT INTO `fishing_zone` VALUES(222, 'Provenance', 0);
INSERT INTO `fishing_zone` VALUES(223, 'San_dOria-Jeuno_Airship', 0);
INSERT INTO `fishing_zone` VALUES(224, 'Bastok-Jeuno_Airship', 0);
INSERT INTO `fishing_zone` VALUES(225, 'Windurst-Jeuno_Airship', 0);
INSERT INTO `fishing_zone` VALUES(226, 'Kazham-Jeuno_Airship', 0);
INSERT INTO `fishing_zone` VALUES(227, 'Ship_bound_for_Selbina_Pirates', 0);
INSERT INTO `fishing_zone` VALUES(228, 'Ship_bound_for_Mhaura_Pirates', 0);
INSERT INTO `fishing_zone` VALUES(229, '229', 0);
INSERT INTO `fishing_zone` VALUES(230, 'Southern_San_dOria', 0);
INSERT INTO `fishing_zone` VALUES(231, 'Northern_San_dOria', 0);
INSERT INTO `fishing_zone` VALUES(232, 'Port_San_dOria', 0);
INSERT INTO `fishing_zone` VALUES(233, 'Chateau_dOraguille', 0);
INSERT INTO `fishing_zone` VALUES(234, 'Bastok_Mines', 0);
INSERT INTO `fishing_zone` VALUES(235, 'Bastok_Markets', 0);
INSERT INTO `fishing_zone` VALUES(236, 'Port_Bastok', 0);
INSERT INTO `fishing_zone` VALUES(237, 'Metalworks', 0);
INSERT INTO `fishing_zone` VALUES(238, 'Windurst_Waters', 0);
INSERT INTO `fishing_zone` VALUES(239, 'Windurst_Walls', 0);
INSERT INTO `fishing_zone` VALUES(240, 'Port_Windurst', 0);
INSERT INTO `fishing_zone` VALUES(241, 'Windurst_Woods', 0);
INSERT INTO `fishing_zone` VALUES(242, 'Heavens_Tower', 0);
INSERT INTO `fishing_zone` VALUES(243, 'RuLude_Gardens', 0);
INSERT INTO `fishing_zone` VALUES(244, 'Upper_Jeuno', 0);
INSERT INTO `fishing_zone` VALUES(245, 'Lower_Jeuno', 0);
INSERT INTO `fishing_zone` VALUES(246, 'Port_Jeuno', 0);
INSERT INTO `fishing_zone` VALUES(247, 'Rabao', 0);
INSERT INTO `fishing_zone` VALUES(248, 'Selbina', 0);
INSERT INTO `fishing_zone` VALUES(249, 'Mhaura', 0);
INSERT INTO `fishing_zone` VALUES(250, 'Kazham', 0);
INSERT INTO `fishing_zone` VALUES(251, 'Hall_of_the_Gods', 0);
INSERT INTO `fishing_zone` VALUES(252, 'Norg', 0);
INSERT INTO `fishing_zone` VALUES(253, 'Abyssea-Uleguerand', 0);
INSERT INTO `fishing_zone` VALUES(254, 'Abyssea-Grauberg', 0);
INSERT INTO `fishing_zone` VALUES(255, 'Abyssea-Empyreal_Paradox', 0);
INSERT INTO `fishing_zone` VALUES(256, 'Western_Adoulin', 0);
INSERT INTO `fishing_zone` VALUES(257, 'Eastern_Adoulin', 0);
INSERT INTO `fishing_zone` VALUES(258, 'Rala_Waterways', 0);
INSERT INTO `fishing_zone` VALUES(259, 'Rala_Waterways_U', 0);
INSERT INTO `fishing_zone` VALUES(260, 'Yahse_Hunting_Grounds', 0);
INSERT INTO `fishing_zone` VALUES(261, 'Ceizak_Battlegrounds', 0);
INSERT INTO `fishing_zone` VALUES(262, 'Foret_de_Hennetiel', 0);
INSERT INTO `fishing_zone` VALUES(263, 'Yorcia_Weald', 0);
INSERT INTO `fishing_zone` VALUES(264, 'Yorcia_Weald_U', 0);
INSERT INTO `fishing_zone` VALUES(265, 'Morimar_Basalt_Fields', 0);
INSERT INTO `fishing_zone` VALUES(266, 'Marjami_Ravine', 0);
INSERT INTO `fishing_zone` VALUES(267, 'Kamihr_Drifts', 0);
INSERT INTO `fishing_zone` VALUES(268, 'Sih_Gates', 0);
INSERT INTO `fishing_zone` VALUES(269, 'Moh_Gates', 0);
INSERT INTO `fishing_zone` VALUES(270, 'Cirdas_Caverns', 0);
INSERT INTO `fishing_zone` VALUES(271, 'Cirdas_Caverns_U', 0);
INSERT INTO `fishing_zone` VALUES(272, 'Dho_Gates', 0);
INSERT INTO `fishing_zone` VALUES(273, 'Woh_Gates', 0);
INSERT INTO `fishing_zone` VALUES(274, 'Outer_RaKaznar', 0);
INSERT INTO `fishing_zone` VALUES(275, 'Outer_RaKaznar_U', 0);
INSERT INTO `fishing_zone` VALUES(276, 'RaKaznar_Inner_Court', 0);
INSERT INTO `fishing_zone` VALUES(277, 'RaKaznar_Turris', 0);
INSERT INTO `fishing_zone` VALUES(278, '278', 0);
INSERT INTO `fishing_zone` VALUES(279, '279', 0);
INSERT INTO `fishing_zone` VALUES(280, 'Mog_Garden', 0);
INSERT INTO `fishing_zone` VALUES(281, 'Leafallia', 0);
INSERT INTO `fishing_zone` VALUES(282, 'Mount_Kamihr', 0);
INSERT INTO `fishing_zone` VALUES(283, 'Silver_Knife', 0);
INSERT INTO `fishing_zone` VALUES(284, 'Celennia_Memorial_Library', 0);
INSERT INTO `fishing_zone` VALUES(285, 'Feretory', 0);
INSERT INTO `fishing_zone` VALUES(286, '286', 0);
INSERT INTO `fishing_zone` VALUES(287, '287', 0);
INSERT INTO `fishing_zone` VALUES(288, 'Escha_ZiTah', 0);
INSERT INTO `fishing_zone` VALUES(289, 'Escha_RuAun', 0);
INSERT INTO `fishing_zone` VALUES(290, 'Desuetia_Empyreal_Paradox', 0);
INSERT INTO `fishing_zone` VALUES(291, 'Reisenjima', 0);
INSERT INTO `fishing_zone` VALUES(292, 'Reisenjima_Henge', 0);
INSERT INTO `fishing_zone` VALUES(293, 'Reisenjima_Sanctorium', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishing_zone`
--
ALTER TABLE `fishing_zone`
  ADD PRIMARY KEY (`zoneid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

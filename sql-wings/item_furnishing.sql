-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 03 Janvier 2012 à 19:42
-- Version du serveur: 6.0.0
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `tpzdb`
--

-- --------------------------------------------------------

--
-- Structure de la table `item_furnishing`
--

DROP TABLE IF EXISTS `item_furnishing`;
CREATE TABLE IF NOT EXISTS `item_furnishing` (
  `itemid` smallint(5) unsigned NOT NULL,
  `name` text NOT NULL,
  `storage` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `moghancement` smallint(4) unsigned NOT NULL DEFAULT '0',
  `element` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `aura` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=25 PACK_KEYS=1 CHECKSUM=1;

--
-- Contenu de la table `item_furnishing`
--

INSERT INTO `item_furnishing` VALUES (1, 'pile_of_chocobo_bedding', 1, 520, 8, 2);
INSERT INTO `item_furnishing` VALUES (2, 'simple_bed', 1, 520, 6, 3);
INSERT INTO `item_furnishing` VALUES (3, 'oak_bed', 1, 520, 3, 5);
INSERT INTO `item_furnishing` VALUES (4, 'mahogany_bed', 1, 520, 7, 10);
INSERT INTO `item_furnishing` VALUES (5, 'bronze_bed', 1, 520, 2, 6);
INSERT INTO `item_furnishing` VALUES (6, 'nobles_bed', 1, 520, 5, 12);
INSERT INTO `item_furnishing` VALUES (7, 'gold_bed', 1, 520, 1, 18);
INSERT INTO `item_furnishing` VALUES (8, 'royal_bed', 2, 520, 8, 24);
INSERT INTO `item_furnishing` VALUES (21, 'desk', 1, 533, 3, 5);
INSERT INTO `item_furnishing` VALUES (22, 'workbench', 1, 521, 4, 6);
INSERT INTO `item_furnishing` VALUES (23, 'maple_table', 1, 521, 4, 8);
INSERT INTO `item_furnishing` VALUES (24, 'oak_table', 1, 521, 4, 9);
INSERT INTO `item_furnishing` VALUES (26, 'tarutaru_desk', 2, 521, 4, 4);
INSERT INTO `item_furnishing` VALUES (28, 'drawing_desk', 1, 524, 4, 9);
INSERT INTO `item_furnishing` VALUES (29, 'secretaire', 1, 533, 4, 2);
INSERT INTO `item_furnishing` VALUES (30, 'bureau', 2, 515, 4, 3);
INSERT INTO `item_furnishing` VALUES (32, 'dresser', 15, 518, 7, 4);
INSERT INTO `item_furnishing` VALUES (33, 'millionaire_desk', 1, 532, 8, 2);
INSERT INTO `item_furnishing` VALUES (43, 'wicker_box', 4, 514, 3, 2);
INSERT INTO `item_furnishing` VALUES (46, 'armor_box', 5, 517, 6, 2);
INSERT INTO `item_furnishing` VALUES (49, 'coffer', 5, 517, 6, 4);
INSERT INTO `item_furnishing` VALUES (51, 'chest', 3, 517, 6, 4);
INSERT INTO `item_furnishing` VALUES (54, 'chocobo_commode', 6, 0, 6, 0);
INSERT INTO `item_furnishing` VALUES (55, 'cabinet', 7, 517, 6, 9);
INSERT INTO `item_furnishing` VALUES (56, 'commode', 6, 517, 6, 9);
INSERT INTO `item_furnishing` VALUES (57, 'cupboard', 6, 512, 1, 6);
INSERT INTO `item_furnishing` VALUES (59, 'chiffonier', 6, 517, 6, 8);
INSERT INTO `item_furnishing` VALUES (61, 'armoire', 14, 517, 6, 9);
INSERT INTO `item_furnishing` VALUES (76, 'royal_bookshelf', 10, 514, 3, 4);
INSERT INTO `item_furnishing` VALUES (77, 'bookshelf', 20, 512, 1, 8);
INSERT INTO `item_furnishing` VALUES (86, 'san_dorian_holiday_tree', 1, 521, 2, 1);
INSERT INTO `item_furnishing` VALUES (87, 'kadomatsu', 1, 521, 4, 1);
INSERT INTO `item_furnishing` VALUES (88, 'timepiece', 1, 519, 8, 5);
INSERT INTO `item_furnishing` VALUES (89, 'wastebasket', 2, 522, 5, 2);
INSERT INTO `item_furnishing` VALUES (90, 'rusty_bucket', 1, 534, 6, 11);
INSERT INTO `item_furnishing` VALUES (91, 'blue_pitcher', 4, 517, 6, 2);
INSERT INTO `item_furnishing` VALUES (92, 'tarutaru_stool', 1, 522, 5, 2);
INSERT INTO `item_furnishing` VALUES (93, 'water_cask', 1, 521, 6, 2);
INSERT INTO `item_furnishing` VALUES (95, 'water_barrel', 6, 517, 6, 4);
INSERT INTO `item_furnishing` VALUES (96, 'beverage_barrel', 1, 521, 6, 4);
INSERT INTO `item_furnishing` VALUES (97, 'bookholder', 1, 522, 7, 1);
INSERT INTO `item_furnishing` VALUES (98, 'scimitar_cactus', 1, 521, 7, 6);
INSERT INTO `item_furnishing` VALUES (99, 'elshimo_palm', 1, 521, 1, 2);
INSERT INTO `item_furnishing` VALUES (100, 'okadomatsu', 2, 521, 4, 2);
INSERT INTO `item_furnishing` VALUES (102, 'flower_stand', 1, 516, 5, 2);
INSERT INTO `item_furnishing` VALUES (103, 'goldfish_bowl', 1, 517, 6, 2);
INSERT INTO `item_furnishing` VALUES (104, 'tarutaru_folding_screen', 1, 513, 2, 3);
INSERT INTO `item_furnishing` VALUES (105, 'sky_pot', 7, 513, 2, 5);
INSERT INTO `item_furnishing` VALUES (106, 'red_jar', 7, 512, 1, 5);
INSERT INTO `item_furnishing` VALUES (107, 'water_jug', 2, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (109, 'urn', 1, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (110, 'white_jar', 6, 518, 7, 5);
INSERT INTO `item_furnishing` VALUES (112, 'yellow_jar', 4, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (113, 'cleaning_tool_set', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (114, 'my_first_magic_kit', 1, 516, 5, 2);
INSERT INTO `item_furnishing` VALUES (115, 'bastokan_holiday_tree', 1, 521, 2, 1);
INSERT INTO `item_furnishing` VALUES (116, 'windurstian_holiday_tree', 1, 521, 2, 1);
INSERT INTO `item_furnishing` VALUES (117, 'wing_egg', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (118, 'lamp_egg', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (119, 'flower_egg', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (120, 'freshwater_aquarium', 1, 521, 6, 5);
INSERT INTO `item_furnishing` VALUES (121, 'saltwater_aquarium', 1, 517, 6, 5);
INSERT INTO `item_furnishing` VALUES (122, 'amir_bed', 1, 520, 1, 4);	-- Not present in era?
INSERT INTO `item_furnishing` VALUES (123, 'athenienne', 1, 521, 6, 2);
INSERT INTO `item_furnishing` VALUES (124, 'wardrobe', 10, 515, 4, 6);
INSERT INTO `item_furnishing` VALUES (125, 'reliquary', 8, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (126, 'falsiam_vase', 6, 516, 5, 4);
INSERT INTO `item_furnishing` VALUES (127, 'coffee_table', 1, 533, 4, 7);
INSERT INTO `item_furnishing` VALUES (128, 'console', 6, 516, 5, 6);
INSERT INTO `item_furnishing` VALUES (129, 'imperial_standard', 1, 532, 1, 9);
INSERT INTO `item_furnishing` VALUES (130, 'marble_bed', 1, 520, 1, 16);
INSERT INTO `item_furnishing` VALUES (131, 'stationery_set', 1, 513, 2, 3);
INSERT INTO `item_furnishing` VALUES (132, 'tableware_set', 1, 516, 5, 3);
INSERT INTO `item_furnishing` VALUES (133, 'tea_set', 1, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (134, 'copy_of_emeralda', 1, 530, 5, 9);
INSERT INTO `item_furnishing` VALUES (135, 'magic_tome_set', 1, 513, 2, 2);
INSERT INTO `item_furnishing` VALUES (136, 'set_of_kaiserin_cosmetics', 1, 513, 2, 1);
INSERT INTO `item_furnishing` VALUES (137, 'cordon_bleu_cooking_set', 1, 531, 3, 9);
INSERT INTO `item_furnishing` VALUES (138, 'jeunoan_tree', 4, 532, 2, 3);  -- Not present in era?
INSERT INTO `item_furnishing` VALUES (139, 'star_globe', 1, 533, 8, 9);
INSERT INTO `item_furnishing` VALUES (140, 'dream_platter', 2, 522, 5, 3);
INSERT INTO `item_furnishing` VALUES (141, 'dream_coffer', 2, 522, 5, 3);
INSERT INTO `item_furnishing` VALUES (142, 'drogarogas_fang', 1, 529, 8, 9);
INSERT INTO `item_furnishing` VALUES (143, 'ngoma', 2, 514, 3, 4);
INSERT INTO `item_furnishing` VALUES (144, 'caisson', 5, 521, 4, 3);
INSERT INTO `item_furnishing` VALUES (145, 'thurible', 1, 522, 5, 8);
INSERT INTO `item_furnishing` VALUES (146, 'walahra_burner', 3, 522, 8, 4);
INSERT INTO `item_furnishing` VALUES (147, 'imperial_tapestry', 2, 533, 1, 3);
INSERT INTO `item_furnishing` VALUES (148, 'cartonnier', 20, 521, 1, 11);  
INSERT INTO `item_furnishing` VALUES (149, 'set_of_alchemists_tools', 1, 522, 1, 4);
INSERT INTO `item_furnishing` VALUES (150, 'leather_pot', 4, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (151, 'stack_of_fools_gold', 1, 526, 7, 9);
INSERT INTO `item_furnishing` VALUES (152, 'flowerpot', 1, 521, 7, 1);
INSERT INTO `item_furnishing` VALUES (153, 'mastersmith_anvil', 1, 525, 1, 9);
INSERT INTO `item_furnishing` VALUES (154, 'miniature_airship', 1, 520, 7, 9);
INSERT INTO `item_furnishing` VALUES (155, 'dream_stocking', 2, 522, 5, 3);
INSERT INTO `item_furnishing` VALUES (176, 'snowman_knight', 4, 521, 2, 4);
INSERT INTO `item_furnishing` VALUES (177, 'snowman_miner', 4, 521, 2, 4);
INSERT INTO `item_furnishing` VALUES (178, 'snowman_mage', 4, 521, 2, 4);
INSERT INTO `item_furnishing` VALUES (179, 'jeweled_egg', 1, 513, 2, 2);
INSERT INTO `item_furnishing` VALUES (180, 'bonbori', 2, 521, 2, 2);
INSERT INTO `item_furnishing` VALUES (181, 'san_dorian_flag', 1, 535, 1, 9);
INSERT INTO `item_furnishing` VALUES (182, 'bastokan_flag', 1, 536, 5, 9);
INSERT INTO `item_furnishing` VALUES (183, 'windurstian_flag', 1, 537, 3, 9);
INSERT INTO `item_furnishing` VALUES (184, 'jeunoan_flag', 1, 539, 7, 9);
INSERT INTO `item_furnishing` VALUES (185, 'rook_banner', 1, 532, 1, 7);
INSERT INTO `item_furnishing` VALUES (186, 'shield_plaque', 1, 533, 4, 3);
INSERT INTO `item_furnishing` VALUES (187, 'buckler_plaque', 1, 533, 2, 4);
INSERT INTO `item_furnishing` VALUES (188, 'copy_of_acolytes_grief', 1, 522, 8, 4);
INSERT INTO `item_furnishing` VALUES (189, 'copy_of_autumns_end_in_gustaberg', 1, 519, 8, 5);
INSERT INTO `item_furnishing` VALUES (190, 'copy_of_lines_and_space', 1, 522, 8, 5);
INSERT INTO `item_furnishing` VALUES (191, 'fishing_hole_map', 1, 523, 6, 9);
INSERT INTO `item_furnishing` VALUES (192, 'copy_of_hoary_spire', 1, 538, 4, 3);
INSERT INTO `item_furnishing` VALUES (193, 'adventuring_certificate', 1, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (194, 'blacksmiths_plaque', 1, 525, 2, 3);
INSERT INTO `item_furnishing` VALUES (195, 'stuffed_big_one', 1, 523, 6, 5);
INSERT INTO `item_furnishing` VALUES (196, 'melodious_egg', 1, 522, 5, 4);
INSERT INTO `item_furnishing` VALUES (197, 'clockwork_egg', 1, 522, 2, 4);
INSERT INTO `item_furnishing` VALUES (198, 'gilt_tapestry', 1, 527, 4, 9);
INSERT INTO `item_furnishing` VALUES (199, 'hatchling_egg', 1, 522, 8, 4);
INSERT INTO `item_furnishing` VALUES (200, 'tsahyan_mask', 1, 522, 5, 3);
INSERT INTO `item_furnishing` VALUES (201, 'totem_pole', 1, 512, 1, 8);
INSERT INTO `item_furnishing` VALUES (202, 'golden_fleece', 1, 528, 2, 9);
INSERT INTO `item_furnishing` VALUES (203, 'bomb_lantern', 1, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (204, 'pumpkin_lantern', 1, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (205, 'mandragora_lantern', 1, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (206, 'copy_of_ancient_blood', 1, 522, 8, 3);
INSERT INTO `item_furnishing` VALUES (207, 'fire_lamp', 1, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (208, 'ice_lamp', 1, 513, 2, 2);
INSERT INTO `item_furnishing` VALUES (209, 'wind_lamp', 1, 514, 3, 2);
INSERT INTO `item_furnishing` VALUES (210, 'earth_lamp', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (211, 'lightning_lamp', 1, 516, 5, 2);
INSERT INTO `item_furnishing` VALUES (212, 'water_lamp', 1, 517, 6, 2);
INSERT INTO `item_furnishing` VALUES (213, 'light_lamp', 1, 518, 7, 2);
INSERT INTO `item_furnishing` VALUES (214, 'dark_lamp', 1, 519, 8, 2);
INSERT INTO `item_furnishing` VALUES (215, 'set_of_festival_dolls', 3, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (216, 'porcelain_flowerpot', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (217, 'brass_flowerpot', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (218, 'earthen_flowerpot', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (219, 'ceramic_flowerpot', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (220, 'wooden_flowerpot', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (221, 'arcane_flowerpot', 1, 515, 4, 4);
INSERT INTO `item_furnishing` VALUES (222, 'fighting_fish_tank', 1, 517, 6, 2);
INSERT INTO `item_furnishing` VALUES (223, 'river_aquarium', 1, 521, 6, 5);
INSERT INTO `item_furnishing` VALUES (224, 'bay_aquarium', 1, 517, 6, 5);
INSERT INTO `item_furnishing` VALUES (225, 'reef_aquarium', 1, 517, 6, 5);
INSERT INTO `item_furnishing` VALUES (246, 'blackhorn', 1, 523, 1, 4);
INSERT INTO `item_furnishing` VALUES (247, 'stripehorn', 1, 523, 1, 4);
INSERT INTO `item_furnishing` VALUES (248, 'whitehorn', 1, 523, 1, 4);
INSERT INTO `item_furnishing` VALUES (256, 'hume_?_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (257, 'hume_?_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (258, 'elvaan_?_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (259, 'elvaan_?_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (260, 'tarutaru_?_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (261, 'tarutaru_?_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (262, 'mithra_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (263, 'galka_mannequin', 28, 518, 7, 6);
INSERT INTO `item_furnishing` VALUES (264, 'stuffed_chocobo', 4, 538, 1, 4);
INSERT INTO `item_furnishing` VALUES (265, 'adamantoise_statue', 4, 515, 4, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (266, 'behemoth_statue', 4, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (267, 'fafnir_statue', 4, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (268, 'nomad_moogle_statue', 4, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (269, 'shadow_lord_statue', 4, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (270, 'odin_statue', 4, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (271, 'alexander_statue', 4, 518, 7, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (272, 'ark_angel_hm_statue', 1, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (273, 'ark_angel_ev_statue', 1, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (274, 'ark_angel_tt_statue', 1, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (275, 'ark_angel_mr_statue', 1, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (276, 'ark_angel_gk_statue', 1, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (277, 'prishe_statue', 1, 538, 1, 3);
INSERT INTO `item_furnishing` VALUES (278, 'cardian_statue', 1, 514, 3, 3);
INSERT INTO `item_furnishing` VALUES (279, 'shadow_lord_statue_ii', 4, 519, 3, 3);
INSERT INTO `item_furnishing` VALUES (280, 'shadow_lord_statue_iii', 4, 519, 3, 3);
INSERT INTO `item_furnishing` VALUES (281, 'atomos_statue', 4, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (282, 'yovra_replica', 4, 523, 3, 3);
INSERT INTO `item_furnishing` VALUES (284, 'goobbue_statue', 4, 515, 4, 3);
INSERT INTO `item_furnishing` VALUES (286, 'nanaa_mihgo_statue', 4, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (287, 'nanaa_mihgo_statue_ii', 4, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (294, 'campfire', 1, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (295, 'bonfire', 1, 2850, 1, 6);
INSERT INTO `item_furnishing` VALUES (303, 'crystal_stakes_gold_cup', 1, 520, 3, 4);
INSERT INTO `item_furnishing` VALUES (304, 'crystal_stakes_mythril_cup', 1, 520, 3, 3);
INSERT INTO `item_furnishing` VALUES (305, 'crystal_stakes_bronze_cup', 1, 520, 3, 2);
INSERT INTO `item_furnishing` VALUES (307, 'mythril_trophy', 1, 514, 3, 2);
INSERT INTO `item_furnishing` VALUES (308, 'bronze_trophy', 1, 514, 3, 2);
INSERT INTO `item_furnishing` VALUES (309, 'yellow_vcs_plaque', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (310, 'black_vcs_plaque', 1, 519, 8, 1);
INSERT INTO `item_furnishing` VALUES (311, 'red_vcs_plaque', 1, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (312, 'blue_vcs_plaque', 1, 513, 2, 1);
INSERT INTO `item_furnishing` VALUES (313, 'green_vcs_plaque', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (314, '9-drawer_almirah', 16, 517, 6, 9);
INSERT INTO `item_furnishing` VALUES (315, '6-drawer_almirah', 15, 517, 6, 8);
INSERT INTO `item_furnishing` VALUES (316, '3-drawer_almirah', 14, 517, 6, 7);
INSERT INTO `item_furnishing` VALUES (317, 'bronze_rose', 1, 516, 5, 10);
INSERT INTO `item_furnishing` VALUES (318, 'crystal_rose', 1, 518, 7, 9);
INSERT INTO `item_furnishing` VALUES (319, 'shell_lamp', 1, 519, 8, 10);
INSERT INTO `item_furnishing` VALUES (320, 'harpsichord', 4, 538, 7, 3);
INSERT INTO `item_furnishing` VALUES (321, 'mythril_bell', 1, 520, 5, 20);
INSERT INTO `item_furnishing` VALUES (322, 'horn_trophy', 2, 532, 2, 4);
INSERT INTO `item_furnishing` VALUES (323, 'sprig_of_red_bamboo_grass', 2, 538, 8, 3);
INSERT INTO `item_furnishing` VALUES (324, 'sprig_of_blue_bamboo_grass', 2, 538, 8, 3);
INSERT INTO `item_furnishing` VALUES (325, 'sprig_of_green_bamboo_grass', 2, 538, 8, 3);
INSERT INTO `item_furnishing` VALUES (326, 'yellow_hobby_bo', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (327, 'red_hobby_bo', 1, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (328, 'black_hobby_bo', 1, 519, 8, 1);
INSERT INTO `item_furnishing` VALUES (329, 'blue_hobby_bo', 1, 513, 2, 1);
INSERT INTO `item_furnishing` VALUES (330, 'green_hobby_bo', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (331, 'winged_altar', 2, 533, 7, 2);
INSERT INTO `item_furnishing` VALUES (332, 'winged_plaque', 2, 533, 7, 2);
INSERT INTO `item_furnishing` VALUES (333, 'winged_balance', 2, 533, 7, 2);
INSERT INTO `item_furnishing` VALUES (334, 'blacksmiths_signboard', 1, 525, 1, 10);
INSERT INTO `item_furnishing` VALUES (335, 'goldsmiths_signboard', 1, 526, 7, 10);
INSERT INTO `item_furnishing` VALUES (336, 'boneworkers_signboard', 1, 529, 8, 10);
INSERT INTO `item_furnishing` VALUES (337, 'weavers_signboard', 1, 527, 4, 10);
INSERT INTO `item_furnishing` VALUES (338, 'culinarians_signboard', 1, 531, 3, 10);
INSERT INTO `item_furnishing` VALUES (339, 'tanners_signboard', 1, 528, 2, 10);
INSERT INTO `item_furnishing` VALUES (340, 'fishermans_signboard', 1, 523, 6, 10);
INSERT INTO `item_furnishing` VALUES (341, 'carpenters_signboard', 1, 524, 4, 10);
INSERT INTO `item_furnishing` VALUES (342, 'alchemists_signboard', 1, 530, 5, 10);
INSERT INTO `item_furnishing` VALUES (343, 'harp_stool', 2, 515, 4, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (345, 'san_dorian_marriage_certificate', 1, 538, 7, 2);
INSERT INTO `item_furnishing` VALUES (346, 'bastokan_marriage_certificate', 1, 538, 7, 2);
INSERT INTO `item_furnishing` VALUES (347, 'windurstian_marriage_certificate', 1, 538, 7, 2);
INSERT INTO `item_furnishing` VALUES (348, 'marble_plaque', 1, 539, 7, 9);
INSERT INTO `item_furnishing` VALUES (349, 'royal_squires_bunk', 3, 520, 4, 4);
INSERT INTO `item_furnishing` VALUES (350, 'republican_legionnaires_bedding', 4, 520, 8, 3);
INSERT INTO `item_furnishing` VALUES (351, 'federal_mercenarys_hammock', 2, 520, 3, 6);
INSERT INTO `item_furnishing` VALUES (352, 'half_partition', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (353, 'spence', 16, 516, 5, 6);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (354, 'bookstack', 16, 532, 4, 8);
INSERT INTO `item_furnishing` VALUES (355, 'bread_crock', 9, 519, 8, 6);
INSERT INTO `item_furnishing` VALUES (356, 'set_of_guild_flyers', 1, 536, 5, 5);
INSERT INTO `item_furnishing` VALUES (357, 'partition', 1, 521, 2, 4);
INSERT INTO `item_furnishing` VALUES (358, 'credenza', 7, 515, 4, 7);
INSERT INTO `item_furnishing` VALUES (359, 'bahut', 8, 521, 4, 10);
INSERT INTO `item_furnishing` VALUES (360, 'matka', 2, 515, 4, 7);
INSERT INTO `item_furnishing` VALUES (361, 'gallipot', 8, 515, 4, 6);
INSERT INTO `item_furnishing` VALUES (362, 'fluoro-flora', 1, 522, 7, 5);
INSERT INTO `item_furnishing` VALUES (363, 'amigo_cactus', 2, 533, 1, 4);
INSERT INTO `item_furnishing` VALUES (364, 'amiga_cactus', 2, 532, 6, 4);
INSERT INTO `item_furnishing` VALUES (365, 'poele_classique', 3, 512, 1, 6);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (366, 'kanonenofen', 3, 512, 1, 6);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (367, 'pot_topper', 3, 512, 1, 6);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (368, 'san_dorian_tea_set', 1, 538, 1, 6);
INSERT INTO `item_furnishing` VALUES (369, 'bastokan_tea_set', 1, 538, 6, 6);
INSERT INTO `item_furnishing` VALUES (370, 'windurstian_tea_set', 1, 538, 3, 6);
INSERT INTO `item_furnishing` VALUES (371, 'butterfly_cage', 3, 514, 3, 4);
INSERT INTO `item_furnishing` VALUES (372, 'cricket_cage', 3, 516, 5, 4);
INSERT INTO `item_furnishing` VALUES (373, 'glowfly_cage', 3, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (374, 'parclose', 1, 515, 4, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (375, 'cs_gold_stand', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (376, 'cs_mythril_stand', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (377, 'cs_bronze_stand', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (378, 'blue_9-drawer_almirah', 16, 513, 2, 9);
INSERT INTO `item_furnishing` VALUES (379, 'blue_6-drawer_almirah', 15, 513, 2, 8);
INSERT INTO `item_furnishing` VALUES (380, 'blue_3-drawer_almirah', 14, 513, 2, 7);
INSERT INTO `item_furnishing` VALUES (381, 'green_9-drawer_almirah', 16, 514, 3, 9);
INSERT INTO `item_furnishing` VALUES (382, 'green_6-drawer_almirah', 15, 514, 3, 8);
INSERT INTO `item_furnishing` VALUES (383, 'green_3-drawer_almirah', 14, 514, 3, 7);
INSERT INTO `item_furnishing` VALUES (384, 'yellow_9-drawer_almirah', 16, 515, 4, 9);
INSERT INTO `item_furnishing` VALUES (385, 'yellow_6-drawer_almirah', 15, 515, 4, 8);
INSERT INTO `item_furnishing` VALUES (386, 'yellow_3-drawer_almirah', 14, 515, 4, 7);
INSERT INTO `item_furnishing` VALUES (387, 'white_9-drawer_almirah', 16, 518, 7, 9);
INSERT INTO `item_furnishing` VALUES (388, 'white_6-drawer_almirah', 15, 518, 7, 8);
INSERT INTO `item_furnishing` VALUES (389, 'white_3-drawer_almirah', 14, 518, 7, 7);
INSERT INTO `item_furnishing` VALUES (390, 'carmine_desk', 1, 533, 1, 5);
INSERT INTO `item_furnishing` VALUES (391, 'cerulean_desk', 1, 533, 2, 5);
INSERT INTO `item_furnishing` VALUES (392, 'myrtle_desk', 1, 533, 5, 5);
INSERT INTO `item_furnishing` VALUES (393, 'ecru_desk', 1, 533, 2, 5);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (394, 'blue_tarutaru_desk', 2, 513, 2, 4);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (395, 'green_tarutaru_desk', 2, 514, 3, 4);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (396, 'yellow_tarutaru_desk', 1, 515, 4, 4);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (397, 'white_tarutaru_desk', 2, 518, 7, 4);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (398, 'red_mahogany_bed', 1, 520, 1, 10);
INSERT INTO `item_furnishing` VALUES (399, 'blue_mahogany_bed', 1, 520, 6, 10);
INSERT INTO `item_furnishing` VALUES (400, 'green_mahogany_bed', 1, 520, 3, 10);
INSERT INTO `item_furnishing` VALUES (401, 'yellow_mahogany_bed', 1, 520, 4, 10);
INSERT INTO `item_furnishing` VALUES (402, 'blue_nobles_bed', 1, 520, 6, 12);
INSERT INTO `item_furnishing` VALUES (403, 'green_nobles_bed', 1, 520, 3, 12);
INSERT INTO `item_furnishing` VALUES (404, 'yellow_nobles_bed', 1, 520, 4, 12);
INSERT INTO `item_furnishing` VALUES (405, 'white_nobles_bed', 1, 520, 7, 15);
INSERT INTO `item_furnishing` VALUES (406, 'blue_tarutaru_standing_screen', 1, 513, 2, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (407, 'green_tarutaru_standing_screen', 1, 514, 3, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (408, 'yellow_tarutaru_standing_screen', 1, 515, 4, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (409, 'white_tarutaru_standing_screen', 1, 518, 7, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (410, 'red_round_table', 5, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (411, 'blue_round_table', 5, 513, 2, 3);
INSERT INTO `item_furnishing` VALUES (412, 'green_round_table', 5, 514, 3, 3);
INSERT INTO `item_furnishing` VALUES (413, 'yellow_round_table', 5, 515, 4, 3);
INSERT INTO `item_furnishing` VALUES (414, 'white_round_table', 5, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (415, 'aldebaran_horn', 3, 538, 4, 6);
INSERT INTO `item_furnishing` VALUES (416, 'tomeshelf', 10, 519, 8, 1);
INSERT INTO `item_furnishing` VALUES (417, 'storage_hutch', 12, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (418, 'tidings_board', 4, 515, 2, 4);
INSERT INTO `item_furnishing` VALUES (419, 'leisure_table', 2, 515, 2, 2);
INSERT INTO `item_furnishing` VALUES (420, 'pot_of_meadsweet', 1, 514, 4, 4);
INSERT INTO `item_furnishing` VALUES (421, 'vase_of_rulude_orchids', 1, 517, 6, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (422, 'elshimo_pachira', 2, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (423, 'tavern_bench', 4, 515, 4, 6);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (424, 'feasting_table', 7, 515, 4, 7);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (425, 'girandola', 3, 512, 1, 4);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (426, 'orchestrion', 2, 516, 5, 6);
INSERT INTO `item_furnishing` VALUES (427, 'rococo_table', 10, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (428, 'semainier', 35, 516, 8, 3);
INSERT INTO `item_furnishing` VALUES (429, 'red_storm_lantern', 1, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (430, 'blue_storm_lantern', 1, 517, 6, 1);
INSERT INTO `item_furnishing` VALUES (431, 'green_storm_lantern', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (432, 'yellow_storm_lantern', 1, 515, 4, 2);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (433, 'white_storm_lantern', 1, 518, 7, 1);
INSERT INTO `item_furnishing` VALUES (434, 'isula_sideboard', 10, 520, 5, 6);
INSERT INTO `item_furnishing` VALUES (435, 'jeunoan_dresser', 55, 520, 5, 20);
INSERT INTO `item_furnishing` VALUES (436, 'jeunoan_armoire', 30, 520, 5, 10);
INSERT INTO `item_furnishing` VALUES (437, 'floral_nightstand', 1, 521, 7, 1);
INSERT INTO `item_furnishing` VALUES (438, 'orblight', 1, 512, 1, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (439, 'planus_table', 5, 521, 7, 3);
INSERT INTO `item_furnishing` VALUES (440, 'squat_desk', 4, 514, 4, 2);
INSERT INTO `item_furnishing` VALUES (441, 'taru_tot_toyset', 2, 514, 3, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (442, 'gilded_chest', 20, 519, 8, 5);
INSERT INTO `item_furnishing` VALUES (443, 'aureous_chest', 8, 519, 8, 2);
INSERT INTO `item_furnishing` VALUES (444, 'luxurious_chest', 8, 519, 8, 2);
INSERT INTO `item_furnishing` VALUES (445, 'vaisselier_royale', 8, 515, 2, 3);
INSERT INTO `item_furnishing` VALUES (446, 'gilded_shelf', 40, 512, 1, 5);
INSERT INTO `item_furnishing` VALUES (447, 'mensa_lunata', 11, 514, 3, 4);
INSERT INTO `item_furnishing` VALUES (448, 'gueridon', 5, 514, 3, 3);
INSERT INTO `item_furnishing` VALUES (449, 'personal_table', 7, 514, 3, 2);
INSERT INTO `item_furnishing` VALUES (450, 'candelabrum', 1, 512, 1, 4);
INSERT INTO `item_furnishing` VALUES (451, 'egg_stool', 2, 538, 4, 7);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (452, 'egg_table', 3, 538, 3, 6);
INSERT INTO `item_furnishing` VALUES (453, 'egg_locker', 4, 538, 2, 6);
INSERT INTO `item_furnishing` VALUES (454, 'egg_lantern', 1, 538, 1, 3);
INSERT INTO `item_furnishing` VALUES (455, 'egg_buffet', 10, 538, 5, 8);
INSERT INTO `item_furnishing` VALUES (456, 'pepo_lantern', 10, 519, 8, 6);
INSERT INTO `item_furnishing` VALUES (457, 'cushaw_lantern', 6, 519, 8, 6);
INSERT INTO `item_furnishing` VALUES (458, 'calabazilla_lantern', 2, 519, 8, 6);
INSERT INTO `item_furnishing` VALUES (459, 'candle_holder', 1, 512, 1, 4);
INSERT INTO `item_furnishing` VALUES (460, 'bakery_platter', 1, 532, 5, 3);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (461, 'buffalo_milk_case', 4, 533, 7, 1);
INSERT INTO `item_furnishing` VALUES (3584, 'panetiere', 65, 519, 8, 6);
INSERT INTO `item_furnishing` VALUES (3585, 'galley_kitchen', 17, 534, 5, 6);
INSERT INTO `item_furnishing` VALUES (3586, 'pot_of_red_viola', 4, 521, 1, 1);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (3587, 'pot_of_blue_viola', 4, 521, 2, 3);
INSERT INTO `item_furnishing` VALUES (3588, 'pot_of_yellow_viola', 4, 521, 4, 3);
INSERT INTO `item_furnishing` VALUES (3589, 'pot_of_white_viola', 4, 521, 7, 3);
INSERT INTO `item_furnishing` VALUES (3590, 'puce_chest', 10, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (3591, 'chest_of_marbled_drawers', 45, 514, 3, 5);
INSERT INTO `item_furnishing` VALUES (3592, 'jewelry_case', 6, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (3593, 'keepsake_case', 6, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (3594, 'gemstone_case', 6, 515, 4, 3);
INSERT INTO `item_furnishing` VALUES (3595, 'gemscope', 1, 526, 7, 5);
INSERT INTO `item_furnishing` VALUES (3596, 'ornament_case', 1, 518, 7, 4);
INSERT INTO `item_furnishing` VALUES (3598, 'opus_shelf', 14, 512, 1, 4);
INSERT INTO `item_furnishing` VALUES (3600, 'bongo_drum', 1, 2852, 4, 15);
INSERT INTO `item_furnishing` VALUES (3608, 'fictile_pot', 5, 519, 8, 5);
INSERT INTO `item_furnishing` VALUES (3609, 'stepping_stool', 1, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (3610, 'red_mariners_bed', 2, 520, 1, 8);
INSERT INTO `item_furnishing` VALUES (3611, 'blue_mariners_bed', 2, 520, 2, 8);
INSERT INTO `item_furnishing` VALUES (3612, 'green_mariners_bed', 2, 520, 3, 8);
INSERT INTO `item_furnishing` VALUES (3613, 'yellow_mariners_bed', 2, 520, 4, 8);
INSERT INTO `item_furnishing` VALUES (3614, 'white_mariners_bed', 2, 520, 7, 8);
INSERT INTO `item_furnishing` VALUES (3619, 'couronne_des_etoiles', 4, 520, 2, 4);
INSERT INTO `item_furnishing` VALUES (3620, 'silberkranz', 4, 520, 2, 4);
INSERT INTO `item_furnishing` VALUES (3621, 'leafberry_wreath', 4, 520, 2, 4);
INSERT INTO `item_furnishing` VALUES (3622, 'jack-o-pricket', 1, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (3623, 'djinn_pricket', 1, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (3624, 'korrigan_pricket', 1, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (3625, 'blacksmiths_stall', 20, 555, 1, 11);
INSERT INTO `item_furnishing` VALUES (3626, 'goldsmiths_stall', 20, 556, 7, 11);
INSERT INTO `item_furnishing` VALUES (3627, 'boneworkers_stall', 20, 559, 8, 11);
INSERT INTO `item_furnishing` VALUES (3628, 'weavers_stall', 20, 557, 4, 11);
INSERT INTO `item_furnishing` VALUES (3629, 'culinarians_stall', 20, 561, 3, 11);
INSERT INTO `item_furnishing` VALUES (3630, 'tanners_stall', 20, 558, 2, 11);
INSERT INTO `item_furnishing` VALUES (3631, 'fishermens_stall', 20, 553, 6, 11);
INSERT INTO `item_furnishing` VALUES (3632, 'carpenters_stall', 20, 554, 4, 11);
INSERT INTO `item_furnishing` VALUES (3633, 'alchemists_stall', 20, 551, 5, 11);
INSERT INTO `item_furnishing` VALUES (3634, 'starlight_cake', 1, 514, 3, 4);
INSERT INTO `item_furnishing` VALUES (3635, 'buche_des_etoiles', 1, 561, 3, 2);
INSERT INTO `item_furnishing` VALUES (3636, 'serving_of_bavarois_potiron', 1, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (3637, 'banquet_set', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (3638, 'plate_of_mock_hare', 1, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (3639, 'purifying_ewer', 1, 517, 6, 1);
INSERT INTO `item_furnishing` VALUES (3640, 'rolanberry_delightaru', 1, 513, 2, 1);
INSERT INTO `item_furnishing` VALUES (3641, 'kabuto-kazari', 2, 520, 8, 4);
INSERT INTO `item_furnishing` VALUES (3642, 'katana-kazari', 1, 522, 5, 4);
INSERT INTO `item_furnishing` VALUES (3643, 'carillon_vermeil', 1, 535, 3, 3);
INSERT INTO `item_furnishing` VALUES (3644, 'aeolsglocke', 1, 536, 3, 3);
INSERT INTO `item_furnishing` VALUES (3645, 'leafbell', 1, 537, 3, 3);
INSERT INTO `item_furnishing` VALUES (3646, 'mandragora_pricket', 1, 518, 7, 4);
INSERT INTO `item_furnishing` VALUES (3647, 'spook-a-swirl', 1, 534, 8, 4);
INSERT INTO `item_furnishing` VALUES (3648, 'chocolate_grumpkin', 1, 534, 8, 4);
INSERT INTO `item_furnishing` VALUES (3649, 'harvest_horror', 1, 534, 8, 4);
INSERT INTO `item_furnishing` VALUES (3650, 'prinseggstarta', 1, 518, 7, 2);
INSERT INTO `item_furnishing` VALUES (3651, 'harvest_pastry', 1, 2855, 7, 15);
INSERT INTO `item_furnishing` VALUES (3652, 'memorial_cake', 3, 516, 5, 5);
INSERT INTO `item_furnishing` VALUES (3653, 'banquet_table', 5, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (3654, 'tender_bouquet', 1, 538, 7, 2);
INSERT INTO `item_furnishing` VALUES (3655, 'treasury_table', 10, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (3656, 'treasury_stand', 10, 512, 1, 2);
INSERT INTO `item_furnishing` VALUES (3657, 'sundries_table', 10, 516, 5, 2);
INSERT INTO `item_furnishing` VALUES (3658, 'sundries_stand', 10, 516, 5, 2);
INSERT INTO `item_furnishing` VALUES (3659, 'supply_table', 10, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (3660, 'supply_stand', 10, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (3661, 'stone_hearth', 4, 525, 1, 5);
INSERT INTO `item_furnishing` VALUES (3662, 'case_of_display_blades', 2, 512, 1, 4);
INSERT INTO `item_furnishing` VALUES (3663, 'set_of_bonecrafting_tools', 4, 529, 8, 5);
INSERT INTO `item_furnishing` VALUES (3664, 'shell_assortment', 2, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (3665, 'spinning_wheel', 4, 527, 4, 5);
INSERT INTO `item_furnishing` VALUES (3666, 'set_of_fine_raiments', 2, 515, 4, 4);
INSERT INTO `item_furnishing` VALUES (3667, 'brass_crock', 4, 531, 3, 5);
INSERT INTO `item_furnishing` VALUES (3668, 'hide_stretcher', 4, 528, 2, 5);
INSERT INTO `item_furnishing` VALUES (3669, 'set_of_courier_bags', 2, 513, 2, 4);
INSERT INTO `item_furnishing` VALUES (3670, 'net_and_lure', 4, 523, 6, 5);
INSERT INTO `item_furnishing` VALUES (3671, 'set_of_stockfish', 2, 517, 6, 4);
INSERT INTO `item_furnishing` VALUES (3672, 'carpenters_kit', 4, 524, 4, 5);
INSERT INTO `item_furnishing` VALUES (3673, 'set_of_chocobo_carvings', 2, 515, 4, 4);
INSERT INTO `item_furnishing` VALUES (3674, 'alembic', 4, 530, 5, 5);
INSERT INTO `item_furnishing` VALUES (3675, 'flask_set', 2, 516, 5, 4);
INSERT INTO `item_furnishing` VALUES (3676, 'celestial_globe', 5, 519, 8, 4);
INSERT INTO `item_furnishing` VALUES (3677, 'spinet', 1, 518, 7, 1);
INSERT INTO `item_furnishing` VALUES (3678, 'recital_bench', 1, 518, 7, 1);
INSERT INTO `item_furnishing` VALUES (3679, 'beastman_gonfalon', 5, 519, 8, 9);
INSERT INTO `item_furnishing` VALUES (3680, 'copy_of_judgment_day', 7, 516, 5, 7);
INSERT INTO `item_furnishing` VALUES (3681, 'alzadaal_table', 12, 518, 7, 5);
INSERT INTO `item_furnishing` VALUES (3682, 'sproutling_board', 1, 521, 7, 1);
INSERT INTO `item_furnishing` VALUES (3683, 'forestdweller_board', 1, 521, 4, 1);
INSERT INTO `item_furnishing` VALUES (3684, 'princess_board', 1, 515, 4, 1);
INSERT INTO `item_furnishing` VALUES (3685, 'empress_board', 1, 516, 5, 1);
INSERT INTO `item_furnishing` VALUES (3686, 'duelist_board', 1, 512, 1, 1);
INSERT INTO `item_furnishing` VALUES (3687, 'crystal_board', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3688, 'dancer_board', 1, 518, 7, 1);
INSERT INTO `item_furnishing` VALUES (3689, 'wizardess_board', 1, 519, 8, 1);
INSERT INTO `item_furnishing` VALUES (3690, 'fighter_board', 1, 517, 6, 1);
INSERT INTO `item_furnishing` VALUES (3691, 'guardian_board', 1, 513, 2, 1);
INSERT INTO `item_furnishing` VALUES (3692, 'stoic_board', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3693, 'lamb_carving', 1, 515, 4, 3);
INSERT INTO `item_furnishing` VALUES (3694, 'polished_lamb_carving', 1, 515, 4, 5);
INSERT INTO `item_furnishing` VALUES (3695, 'cait_sith_carving', 1, 540, 7, 7);
INSERT INTO `item_furnishing` VALUES (3696, 'kotatsu_table', 1, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (3697, 'mandarin', 1, 2854, 6, 6);
INSERT INTO `item_furnishing` VALUES (3698, 'cherry_tree', 1, 515, 4, 5);
INSERT INTO `item_furnishing` VALUES (3699, 'bathtub', 1, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (3700, 'shower_stand', 1, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (3701, 'awning', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3702, 'triangular_jalousie', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3703, 'square_jalousie', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3704, 'transom', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3705, 'far_east_hearth', 1, 541, 1, 15);  -- Not in era?
INSERT INTO `item_furnishing` VALUES (3706, 'vanaclock', 1, 542, 7, 16);
INSERT INTO `item_furnishing` VALUES (3707, 'murrey_grisaille', 1, 562, 7, 18);
INSERT INTO `item_furnishing` VALUES (3708, 'moss_green_grisaille', 1, 563, 7, 18);
INSERT INTO `item_furnishing` VALUES (3709, 'valance', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3710, 'windurstian_sill', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3711, 'san_dorian_sill', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3712, 'bastokan_sill', 1, 514, 3, 1);
INSERT INTO `item_furnishing` VALUES (3713, 'pot_of_wards', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (3714, 'pot_of_white_clematis', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (3715, 'pot_of_pink_clematis', 1, 515, 4, 2);
INSERT INTO `item_furnishing` VALUES (3717, 'birch_tree', 1, 2854, 4, 5);
INSERT INTO `item_furnishing` VALUES (3718, 'handful_of_adoulinian_tomatoes', 1, 2849, 6, 6);
INSERT INTO `item_furnishing` VALUES (3719, 'prishe_statue_ii', 4, 512, 1, 3);
INSERT INTO `item_furnishing` VALUES (3720, 'arciela_statue', 4, 513, 2, 3);
INSERT INTO `item_furnishing` VALUES (3721, 'iroha_statue', 4, 514, 3, 3);
INSERT INTO `item_furnishing` VALUES (3722, 'lion_statue', 4, 515, 4, 3);
INSERT INTO `item_furnishing` VALUES (3723, 'lilisette_statue', 4, 516, 5, 3);
INSERT INTO `item_furnishing` VALUES (3724, 'uka_statue', 4, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (3725, 'cornelia_statue', 4, 514, 3, 3);
INSERT INTO `item_furnishing` VALUES (3726, 'aphmau_statue', 4, 517, 6, 3);
INSERT INTO `item_furnishing` VALUES (3727, 'mumor_statue', 4, 518, 7, 3);
INSERT INTO `item_furnishing` VALUES (3728, 'ullegore_statue', 4, 519, 8, 3);
INSERT INTO `item_furnishing` VALUES (3729, 'light_chest', 1, 517, 6, 1);
INSERT INTO `item_furnishing` VALUES (3730, 'bulky_coffer', 1, 517, 6, 1);
INSERT INTO `item_furnishing` VALUES (3731, 'azure_chest', 1, 517, 6, 1);
INSERT INTO `item_furnishing` VALUES (3735, 'aurum_coffer', 5, 540, 7, 7);
INSERT INTO `item_furnishing` VALUES (3736, 'well', 80, 517, 6, 8);
INSERT INTO `item_furnishing` VALUES (3737, 'doll_stand', 2, 2855, 7, 15);
INSERT INTO `item_furnishing` VALUES (3738, 'eastern_umbrella', 1, 521, 6, 2); -- Moghancement: Gardening - From https://ffxiclopedia.fandom.com/wiki/Eastern_Umbrella (BG doesn't show Moghancement)
INSERT INTO `item_furnishing` VALUES (3739, 'autumn_tree', 1, 515, 4, 5);
-- INSERT INTO `item_furnishing` VALUES (3740, 'model_synergy_furnace', 8, 0, 8, 11); -- Moghancement: Synergy Skill Gains does not yet exist, so commenting this row out for now
-- INSERT INTO `item_furnishing` VALUES (3742, 'painting_of_a_mercenary', 1, 515, 4, 1); -- Moghancement: Mandragora Mania does not yet exist
INSERT INTO `item_furnishing` VALUES (3743, 'moogle_bed', 1, 520, 7, 8);

/*
  `itemid` smallint(5) unsigned NOT NULL,
  `name` text NOT NULL,
  `storage` tinyint(3) unsigned NOT NULL DEFAULT '0', -- look on bgwiki for storage value
  `moghancement` smallint(4) unsigned NOT NULL DEFAULT '0', -- moghancements are listed in src/map/item_furnishing.h
  `element` tinyint(3) unsigned NOT NULL DEFAULT '0', -- 0:none, 1:fire, 2:ice, 3:wind, 4:earth, 5:thunder, 6:water, 7:light, 8:dark
  `aura` tinyint(3) unsigned NOT NULL DEFAULT '0', -- look on bgwiki for aura strength
*/

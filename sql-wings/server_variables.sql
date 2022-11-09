-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2021 at 07:31 PM
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
-- Table structure for table `server_variables`
--

DROP TABLE IF EXISTS `server_variables`;
CREATE TABLE `server_variables` (
  `name` varchar(50) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `server_variables`
--

INSERT INTO `server_variables` VALUES('[BF]Save_The_Children_record', 600);
INSERT INTO `server_variables` VALUES('[BF]The_Holy_Crest_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Mission_2-3_Horlais_Peak_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Mission_2-3_Balgas_Dais_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Mission_2-3_Waughroon_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job1_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job2_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job3_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job4_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job5_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job6_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job7_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job8_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job9_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job10_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job11_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job12_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job13_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job14_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Shattering_Stars_job15_record', 600);
INSERT INTO `server_variables` VALUES('[BF]Zilart_Mission_4_record', 600);
INSERT INTO `server_variables` VALUES('[TEMP]Respawn_qm1_for_curtana', 0);
INSERT INTO `server_variables` VALUES('[TEMP]Respawn_qm1_for_rattle', 0);
INSERT INTO `server_variables` VALUES('[TEMP]Respawn_qm2_for_offering', 0);
INSERT INTO `server_variables` VALUES('[TEMP]Respawn_qm3_for_whistle', 0);
INSERT INTO `server_variables` VALUES('[POP]Beryl-footed_Molberry', 0);
INSERT INTO `server_variables` VALUES('[POP]Crimson-toothed_Pawberry', 0);
INSERT INTO `server_variables` VALUES('[LANTERN]_rancor_nw_last_lit', 0);
INSERT INTO `server_variables` VALUES('[LANTERN]_rancor_ne_last_lit', 0);
INSERT INTO `server_variables` VALUES('[LANTERN]_rancor_sw_last_lit', 0);
INSERT INTO `server_variables` VALUES('[LANTERN]_rancor_se_last_lit', 0);
INSERT INTO `server_variables` VALUES('[ZM4]Fire_Headstone_Active', 0);
INSERT INTO `server_variables` VALUES('[ZM4]Wind_Headstone_Active', 0);
INSERT INTO `server_variables` VALUES('[ZM4]Lightning_Headstone_Active', 0);
INSERT INTO `server_variables` VALUES('[ZM4]Light_Headstone_Active', 0);
INSERT INTO `server_variables` VALUES('[BF]Mission_5-1_Enter', 0);
INSERT INTO `server_variables` VALUES('[BF]Mission_5-1_QuBia_Arena_record', 600);
INSERT INTO `server_variables` VALUES('[GUILD]pattern_update', 0);
INSERT INTO `server_variables` VALUES('[GUILD]pattern', 7);
INSERT INTO `server_variables` VALUES('realPadfoot', 3);
INSERT INTO `server_variables` VALUES('[CHOCOBO][48]price', 400);
INSERT INTO `server_variables` VALUES('[CHOCOBO][48]time', 1609528254);
INSERT INTO `server_variables` VALUES('[CHOCOBO][80]price', 150);
INSERT INTO `server_variables` VALUES('[CHOCOBO][80]time', 1609421631);
INSERT INTO `server_variables` VALUES('[CHOCOBO][97]price', 200);
INSERT INTO `server_variables` VALUES('[CHOCOBO][97]time', 1609421644);
INSERT INTO `server_variables` VALUES('[CHOCOBO][241]price', 120);
INSERT INTO `server_variables` VALUES('[CHOCOBO][241]time', 1609522465);
INSERT INTO `server_variables` VALUES('[CHOCOBO][82]price', 200);
INSERT INTO `server_variables` VALUES('[CHOCOBO][82]time', 1609421643);
INSERT INTO `server_variables` VALUES('[CHOCOBO][90]price', 200);
INSERT INTO `server_variables` VALUES('[CHOCOBO][90]time', 1609421643);
INSERT INTO `server_variables` VALUES('[CHOCOBO][114]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][114]time', 1609528835);
INSERT INTO `server_variables` VALUES('[CHOCOBO][234]price', 120);
INSERT INTO `server_variables` VALUES('[CHOCOBO][234]time', 1609529380);
INSERT INTO `server_variables` VALUES('[CHOCOBO][250]price', 100);
INSERT INTO `server_variables` VALUES('[CHOCOBO][250]time', 1609523886);
INSERT INTO `server_variables` VALUES('[SEA]IxAernDRG_PH', 16920779);
INSERT INTO `server_variables` VALUES('[CHOCOBO][51]price', 220);
INSERT INTO `server_variables` VALUES('[CHOCOBO][51]time', 1609487478);
INSERT INTO `server_variables` VALUES('Old_Prof_Spawn_Location', 2);
INSERT INTO `server_variables` VALUES('[CHOCOBO][108]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][108]time', 1609529393);
INSERT INTO `server_variables` VALUES('[CHOCOBO][124]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][124]time', 1609528580);
INSERT INTO `server_variables` VALUES('[CHOCOBO][244]price', 235);
INSERT INTO `server_variables` VALUES('[CHOCOBO][244]time', 1609529411);
INSERT INTO `server_variables` VALUES('[CHOCOBO][252]price', 100);
INSERT INTO `server_variables` VALUES('[CHOCOBO][252]time', 1609525757);
INSERT INTO `server_variables` VALUES('[CHOCOBO][117]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][117]time', 1609529336);
INSERT INTO `server_variables` VALUES('[CHOCOBO][245]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][245]time', 1609528439);
INSERT INTO `server_variables` VALUES('Heliodromos_ToD', 1609473120);
INSERT INTO `server_variables` VALUES('[CHOCOBO][94]price', 150);
INSERT INTO `server_variables` VALUES('[CHOCOBO][94]time', 1609421631);
INSERT INTO `server_variables` VALUES('[CHOCOBO][102]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][102]time', 1609527259);
INSERT INTO `server_variables` VALUES('[CHOCOBO][230]price', 120);
INSERT INTO `server_variables` VALUES('[CHOCOBO][230]time', 1609529423);
INSERT INTO `server_variables` VALUES('[CHOCOBO][246]price', 225);
INSERT INTO `server_variables` VALUES('[CHOCOBO][246]time', 1609528628);
INSERT INTO `server_variables` VALUES('[CHOCOBO][87]price', 150);
INSERT INTO `server_variables` VALUES('[CHOCOBO][87]time', 1609421631);
INSERT INTO `server_variables` VALUES('[CHOCOBO][247]price', 100);
INSERT INTO `server_variables` VALUES('[CHOCOBO][247]time', 1609529007);
INSERT INTO `server_variables` VALUES('Mhaura_Destination', 1);
INSERT INTO `server_variables` VALUES('Selbina_Destination', 1);
INSERT INTO `server_variables` VALUES('[POP]Rampaging_Ram 17219886', 1);
INSERT INTO `server_variables` VALUES('[POP]Ashmaker_Gotblut 17358932', 1609531626);
INSERT INTO `server_variables` VALUES('[POP]Leaping_Lizzy 17215868', 1609528401);
INSERT INTO `server_variables` VALUES('[POP]Leaping_Lizzy 17215888', 1609516947);
INSERT INTO `server_variables` VALUES('[POP]Tom_Tit_Tat 17248468', 1609520482);
INSERT INTO `server_variables` VALUES('[POP]Nunyenunc 17248517', 1609533565);
INSERT INTO `server_variables` VALUES('[POP]Spiny_Spipi 17252657', 1609478144);
INSERT INTO `server_variables` VALUES('[POP]Stinging_Sophie 17211561', 1609524392);
INSERT INTO `server_variables` VALUES('[POP]Maighdean_Uaine 17211702', 1609528535);
INSERT INTO `server_variables` VALUES('[POP]Jaggedy-Eared_Jack 17187111', 1609519556);
INSERT INTO `server_variables` VALUES('[POP]Fungus_Beetle 17187047', 1609537308);
INSERT INTO `server_variables` VALUES('[POP]Sharp-Eared_Ropipi 17252489', 1609521247);
INSERT INTO `server_variables` VALUES('[POP]Carnero 17215626', 1);
INSERT INTO `server_variables` VALUES('[POP]ZiGhi_Boneeater 17363208', 1609502749);
INSERT INTO `server_variables` VALUES('[POP]Stray_Mary 17219795', 1609473445);
INSERT INTO `server_variables` VALUES('[POP]Valkurm_Emperor 17199438', 1609522990);
INSERT INTO `server_variables` VALUES('[POP]Swamfisk 17191189', 1);
INSERT INTO `server_variables` VALUES('[POP]Teporingo 17559584', 1609500832);
INSERT INTO `server_variables` VALUES('[POP]Herbage_Hunter 17256836', 1609369292);
INSERT INTO `server_variables` VALUES('[POP]Thousandarm_Deshglesh 17350826', 1);
INSERT INTO `server_variables` VALUES('[POP]Hundredscar_Hajwaj 17354828', 1);
INSERT INTO `server_variables` VALUES('[POP]Panzer_Percival 17203642', 1609522424);
INSERT INTO `server_variables` VALUES('[POP]Panzer_Percival 17203585', 1609336208);
INSERT INTO `server_variables` VALUES('[POP]Hoo_Mjuu_the_Torrent 17371515', 1609518899);
INSERT INTO `server_variables` VALUES('[POP]Vuu_Puqu_the_Beguiler 17371578', 1609420138);
INSERT INTO `server_variables` VALUES('[POP]Juu_Duzu_the_Whirlwind 17371300', 1609471039);
INSERT INTO `server_variables` VALUES('[POP]Steelfleece_Baldarich 17219887', 1609595877);
INSERT INTO `server_variables` VALUES('ArgusRespawn', 1609535913);
INSERT INTO `server_variables` VALUES('[POP]Mee_Deggi_the_Punisher 17395800', 1609530886);
INSERT INTO `server_variables` VALUES('[POP]BuGhi_Howlblade 17363181', 1609287093);
INSERT INTO `server_variables` VALUES('[POP]Quu_Domi_the_Gallant 17395870', 1609520933);
INSERT INTO `server_variables` VALUES('[POP]Crypt_Ghost 17555668', 1609531625);
INSERT INTO `server_variables` VALUES('[POP]Jolly_Green 17223889', 1608337806);
INSERT INTO `server_variables` VALUES('[POP]Epialtes 17530881', 1609044901);
INSERT INTO `server_variables` VALUES('[POP]Golden_Bat 17199564', 1609323916);
INSERT INTO `server_variables` VALUES('[POP]Stray_Mary 17219933', 1609507701);
INSERT INTO `server_variables` VALUES('[POP]Ah_Puch 17571903', 1609238554);
INSERT INTO `server_variables` VALUES('[POP]Deadly_Dodo 17268851', 1609515928);
INSERT INTO `server_variables` VALUES('[POP]Lumbering_Lambert 17195317', 1609518183);
INSERT INTO `server_variables` VALUES('[POP]Serpopard_Ishtar 17256690', 1609132771);
INSERT INTO `server_variables` VALUES('[POP]Poisonhand_Gnadgad 17387644', 1609531454);
INSERT INTO `server_variables` VALUES('[POP]BiGho_Headtaker 17379351', 1609455226);
INSERT INTO `server_variables` VALUES('[POP]Jeduah 17166543', 1609371854);
INSERT INTO `server_variables` VALUES('[POP]Buburimboo 17261003', 1609533241);
INSERT INTO `server_variables` VALUES('[POP]BeHya_Hundredwall 17363258', 1609470511);
INSERT INTO `server_variables` VALUES('[POP]Serpopard_Ishtar 17256563', 1609478266);
INSERT INTO `server_variables` VALUES('[POP]Tigerbane_Bakdak 17387606', 1609495515);
INSERT INTO `server_variables` VALUES('[POP]Hawkeyed_Dnatbat 17387567', 1609524970);
INSERT INTO `server_variables` VALUES('[POP]Slippery_Sucker 17293389', 1);
INSERT INTO `server_variables` VALUES('[POP]Nue 17231971', 1609323022);
INSERT INTO `server_variables` VALUES('[POP]Gwyllgi 17555664', 1609372767);
INSERT INTO `server_variables` VALUES('[POP]Noble_Mold 17273278', 1609160660);
INSERT INTO `server_variables` VALUES('[POP]GeDha_Evileye 17379450', 1609522447);
INSERT INTO `server_variables` VALUES('[POP]Daggerclaw_Dracos 17264818', 1608907156);
INSERT INTO `server_variables` VALUES('[POP]Trickster_Kinetix 17293537', 1609527565);
INSERT INTO `server_variables` VALUES('[POP]Orctrap 16785676', 1609026847);
INSERT INTO `server_variables` VALUES('[POP]Bloodpool_Vorax 17224019', 1609391662);
INSERT INTO `server_variables` VALUES('[POP]Eurytos 17420324', 1605188515);
INSERT INTO `server_variables` VALUES('[POP]Patripatan 17264972', 1609344690);
INSERT INTO `server_variables` VALUES('[POP]Nocuous_Weapon 17563801', 1609530576);
INSERT INTO `server_variables` VALUES('[POP]Donnergugi 17244268', 1609480645);
INSERT INTO `server_variables` VALUES('[POP]Desmodont 17571870', 1609236724);
INSERT INTO `server_variables` VALUES('[POP]Bigmouth_Billy 17191196', 1609185775);
INSERT INTO `server_variables` VALUES('KnightCrabRespawn', 1609540795);
INSERT INTO `server_variables` VALUES('[POP]Yaa_Haqa_the_Profane 17395954', 1609440460);
INSERT INTO `server_variables` VALUES('[POP]Skogs_Fru 17109338', 1609301277);
INSERT INTO `server_variables` VALUES('[POP]Bloodtear_Baldurf 17195318', 1609452595);
INSERT INTO `server_variables` VALUES('SimurghRespawn', 1609544766);
INSERT INTO `server_variables` VALUES('[POP]Fradubio 17203448', 1609521835);
INSERT INTO `server_variables` VALUES('[POP]Habergoass 17121603', 1607827487);
INSERT INTO `server_variables` VALUES('[POP]La_Velue 17121576', 1609220641);
INSERT INTO `server_variables` VALUES('[POP]Amemet 17490016', 1609545298);
INSERT INTO `server_variables` VALUES('RocRespawn', 1609585281);
INSERT INTO `server_variables` VALUES('[POP]Centurio_X-I 17629238', 1608424909);
INSERT INTO `server_variables` VALUES('[POP]Antican_Tag', 1609364289);
INSERT INTO `server_variables` VALUES('[POP]Eldritch_Edge 17228150', 1609524476);
INSERT INTO `server_variables` VALUES('[POP]Blighting_Brand 17269016', 1609526655);
INSERT INTO `server_variables` VALUES('[POP]ZoKhu_Blackcloud 17379564', 1608745941);
INSERT INTO `server_variables` VALUES('[POP]DaDha_Hundredmask 17379427', 1609439197);
INSERT INTO `server_variables` VALUES('[POP]Black_Triple_Stars 17227992', 1);
INSERT INTO `server_variables` VALUES('[POP]Slendlix_Spindlethumb 17563785', 1608254836);
INSERT INTO `server_variables` VALUES('[POP]Mind_Hoarder 17612859', 1609480294);
INSERT INTO `server_variables` VALUES('[POP]Demonic_Tiphia 17584398', 1609526525);
INSERT INTO `server_variables` VALUES('[POP]Drooling_Daisy 17228236', 1609220927);
INSERT INTO `server_variables` VALUES('[POP]Falcatus_Aranei 17486031', 1609386037);
INSERT INTO `server_variables` VALUES('[POP]Cargo_Crab_Colin 17485980', 1608529421);
INSERT INTO `server_variables` VALUES('[POP]Dune_Widow 17244396', 1609380837);
INSERT INTO `server_variables` VALUES('[POP]Keeper_of_Halidom 17272978', 1608792389);
INSERT INTO `server_variables` VALUES('SerketRespawn', 1609584650);
INSERT INTO `server_variables` VALUES('[POP]Kirata 17232044', 1609134481);
INSERT INTO `server_variables` VALUES('[POP]Western_Shadow 17613096', 1609461735);
INSERT INTO `server_variables` VALUES('[POP]Eastern_Shadow 17613110', 1609164533);
INSERT INTO `server_variables` VALUES('CapriciousCassieRespawn', 1609557089);
INSERT INTO `server_variables` VALUES('[POP]Fyuu_the_Seabellow 17498269', 1606120656);
INSERT INTO `server_variables` VALUES('[POP]Ose 17649822', 1609496231);
INSERT INTO `server_variables` VALUES('[POP]Hovering_Hotpot 17596628', 1609488787);
INSERT INTO `server_variables` VALUES('[POP]Tumbling_Truffle 17195259', 1609453572);
INSERT INTO `server_variables` VALUES('[POP]Timeworn_Warrior 17236045', 1609400137);
INSERT INTO `server_variables` VALUES('[POP]Gloomanita 17137821', 1609072451);
INSERT INTO `server_variables` VALUES('[POP]Dame_Blanche 17486129', 1609455185);
INSERT INTO `server_variables` VALUES('[POP]Black_Triple_Stars 17227972', 1609444421);
INSERT INTO `server_variables` VALUES('[POP]Blubbery_Bulge 17387920', 1);
INSERT INTO `server_variables` VALUES('[POP]Hazmat 17596520', 1609120998);
INSERT INTO `server_variables` VALUES('[POP]Citipati 16806162', 1);
INSERT INTO `server_variables` VALUES('[POP]Masan 17498159', 1609413196);
INSERT INTO `server_variables` VALUES('[POP]Lord_of_Onzozo 17649731', 1609573785);
INSERT INTO `server_variables` VALUES('[POP]Marquis_Sabnock 17436881', 1609459612);
INSERT INTO `server_variables` VALUES('[POP]Enkelados 17424423', 1609449946);
INSERT INTO `server_variables` VALUES('[POP]Steelbiter_Gudrud 17387585', 1609262850);
INSERT INTO `server_variables` VALUES('[POP]Moo_Ouzi_the_Swiftblade 17395816', 1609503570);
INSERT INTO `server_variables` VALUES('[POP]Sewer_Syrup 17461307', 1);
INSERT INTO `server_variables` VALUES('[POP]Qull_the_Shellbuster 17498285', 1609524972);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793927_InUse', 1);
INSERT INTO `server_variables` VALUES('[POP]Celphie 17289453', 1609281739);
INSERT INTO `server_variables` VALUES('[POP]Biast', 1609540225);
INSERT INTO `server_variables` VALUES('[POP]Shadow_Eye 17236180', 1608869855);
INSERT INTO `server_variables` VALUES('[POP]Prankster_Maverix 17207640', 1609475703);
INSERT INTO `server_variables` VALUES('[POP]Shii 17461315', 1607545170);
INSERT INTO `server_variables` VALUES('[POP]Barbaric_Weapon 17236027', 1609368216);
INSERT INTO `server_variables` VALUES('[POP]Friar_Rush 17432640', 1);
INSERT INTO `server_variables` VALUES('[POP]Antican_Praefectus 17629281', 1608427442);
INSERT INTO `server_variables` VALUES('[POP]Charybdis 17498522', 1609453458);
INSERT INTO `server_variables` VALUES('[POP]Bugbear_Strongman 16822423', 1609205864);
INSERT INTO `server_variables` VALUES('[PH]Tzee_Xicu_the_Manifest', 2);
INSERT INTO `server_variables` VALUES('[POP]Rhoitos 17420417', 1609058312);
INSERT INTO `server_variables` VALUES('[POP]Aquarius 17404000', 1609299203);
INSERT INTO `server_variables` VALUES('[POP]Ogygos 17420592', 1606755657);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793923_InUse', 1);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793924_Delay', 1606780392);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793922_Delay', 1606791706);
INSERT INTO `server_variables` VALUES('[POP]Wuur_the_Sandcomber 17498199', 1609071571);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793921_Delay', 1607899344);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793920_Delay', 1607899372);
INSERT INTO `server_variables` VALUES('ShikigamiWeaponRespawn', 1609541494);
INSERT INTO `server_variables` VALUES('[POP]Novv_the_Whitehearted 17498445', 1609437301);
INSERT INTO `server_variables` VALUES('[POP]Helldiver 17260907', 1608790670);
INSERT INTO `server_variables` VALUES('[POP]Yarr_the_Pearleyed 17498436', 1);
INSERT INTO `server_variables` VALUES('[POP]Soulstealer_Skullnix 17649818', 1608934862);
INSERT INTO `server_variables` VALUES('[POP]Peg_Powler 17649761', 1609060107);
INSERT INTO `server_variables` VALUES('[POP]Enkelados 17424385', 1609500795);
INSERT INTO `server_variables` VALUES('[POP]Ramponneau 17166705', 1609027098);
INSERT INTO `server_variables` VALUES('[POP]Megalobugard 16875741', 1609015165);
INSERT INTO `server_variables` VALUES('[POP]GaBhu_Unvanquished 17379626', 1609436231);
INSERT INTO `server_variables` VALUES('[POP]Ratatoskr 17170475', 1609359378);
INSERT INTO `server_variables` VALUES('[POP]Gargantua 17232079', 1607550787);
INSERT INTO `server_variables` VALUES('[POP]Gloom_Eye 17457204', 1608928940);
INSERT INTO `server_variables` VALUES('[POP]NiZho_Bladebender 17223797', 1);
INSERT INTO `server_variables` VALUES('[POP]Cwn_Cyrff 17576054', 1607525107);
INSERT INTO `server_variables` VALUES('[POP]Zuug_the_Shoreleaper 17498516', 1609421157);
INSERT INTO `server_variables` VALUES('[POP]Emergent_Elm 16990376', 1609030307);
INSERT INTO `server_variables` VALUES('[POP]Cactuar_Cantautor 17289560', 1608203981);
INSERT INTO `server_variables` VALUES('[POP]Kirtimukha 17170499', 1609392871);
INSERT INTO `server_variables` VALUES('[POP]Goblintrap 17109296', 1609427952);
INSERT INTO `server_variables` VALUES('[POP]Balam-Quitz 17178803', 1607838188);
INSERT INTO `server_variables` VALUES('[POP]Denn_the_Orcavoiced 17498464', 1609436315);
INSERT INTO `server_variables` VALUES('[POP]Goblinsavior_Heronox 17645609', 1607528488);
INSERT INTO `server_variables` VALUES('[POP]Flauros 17428737', 1608434404);
INSERT INTO `server_variables` VALUES('[POP]Bugbear_Strongman 16822427', 1608591091);
INSERT INTO `server_variables` VALUES('[POP]Zoraal_Jas_Pkuucha 16986197', 1609558073);
INSERT INTO `server_variables` VALUES('[POP]Hellion 17649795', 1609381021);
INSERT INTO `server_variables` VALUES('[POP]Sea_Hog 17498420', 1609390875);
INSERT INTO `server_variables` VALUES('[POP]Rhoikos 17420555', 1607845600);
INSERT INTO `server_variables` VALUES('[POP]Ixtab 17424475', 1);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793925_Delay', 1607991995);
INSERT INTO `server_variables` VALUES('[POP]Peallaidh 17101143', 1);
INSERT INTO `server_variables` VALUES('ClammingPoint_16793926_Delay', 1607991980);
INSERT INTO `server_variables` VALUES('[POP]Hoar-knuckled_Rimberry 17285394', 1609157232);
INSERT INTO `server_variables` VALUES('[POP]Mischievous_Micholas 17281149', 1608183224);
INSERT INTO `server_variables` VALUES('[POP]Ankabut 17137705', 1);
INSERT INTO `server_variables` VALUES('[POP]Northern_Shadow 17613103', 1609207192);
INSERT INTO `server_variables` VALUES('[POP]Okyupete 16879847', 1609369995);
INSERT INTO `server_variables` VALUES('[POP]Sozu_Sarberry 17428554', 1609369429);
INSERT INTO `server_variables` VALUES('[POP]Despot 17309954', 1609532958);
INSERT INTO `server_variables` VALUES('[POP]Overlord_Bakgodek', 1609770677);
INSERT INTO `server_variables` VALUES('[PH]Za_Dha_Adamantking', 1);
INSERT INTO `server_variables` VALUES('[POP]Yowie 17490204', 1609409681);
INSERT INTO `server_variables` VALUES('[POP]Tottering_Toby 17207476', 1);
INSERT INTO `server_variables` VALUES('[POP]Vouivre 17617130', 1609500879);
INSERT INTO `server_variables` VALUES('[POP]Ungur 17645755', 1609516419);
INSERT INTO `server_variables` VALUES('[POP]Lindwurm 17617013', 1608617728);
INSERT INTO `server_variables` VALUES('[POP]Supplespine_Mujwuj 17203475', 1608949524);
INSERT INTO `server_variables` VALUES('[POP]Taxim 17645742', 1609141047);
INSERT INTO `server_variables` VALUES('[POP]Ambusher_Antlion 16806249', 1608893483);
INSERT INTO `server_variables` VALUES('[POP]Southern_Shadow 17613121', 1609208778);
INSERT INTO `server_variables` VALUES('[POP]Intulo 16793742', 1609022911);
INSERT INTO `server_variables` VALUES('[POP]Calchas 17289547', 1);
INSERT INTO `server_variables` VALUES('[POP]Baronet_Romwe 17440986', 1609344905);
INSERT INTO `server_variables` VALUES('timeToGrow1', 1609614993);
INSERT INTO `server_variables` VALUES('[POP]Baron_Vapula 17440963', 1);
INSERT INTO `server_variables` VALUES('[POP]Sabotender_Mariachi 17489980', 1);
INSERT INTO `server_variables` VALUES('[POP]Sagittarius_X-XIII 17629301', 1609372745);
INSERT INTO `server_variables` VALUES('[POP]Amikiri 17645774', 1609426663);
INSERT INTO `server_variables` VALUES('TaisaiPicked1', 1);
INSERT INTO `server_variables` VALUES('[POP]Bonnacon 16798056', 1609504692);
INSERT INTO `server_variables` VALUES('[POP]Jaded_Jody 16986378', 1609480814);
INSERT INTO `server_variables` VALUES('[POP]Bluestreak_Gyugyuroon 17056156', 1);
INSERT INTO `server_variables` VALUES('[ZNM]SubjectsOfInterest', 55);
INSERT INTO `server_variables` VALUES('[ZNM]Fauna', 62);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `server_variables`
--
ALTER TABLE `server_variables`
  ADD PRIMARY KEY (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

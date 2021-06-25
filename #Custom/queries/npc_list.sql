-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Please ANNOTATE WELL for a clear understanding of what the query is adding/changing/fixing.     --
--                           Overly detaling your query is NOT needed.                             --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
--        DO NOT RUN QUERIES ON THE LIVE SERVER BEFORE TESTING IN A ISOLATED DEV ENVIRONMENT       --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------


-- ----------
-- GENERAL --
-- ----------

-- ----------------
-- MOUNT ZHAYOLM --
-- ----------------

UPDATE npc_list SET pos_x = "152.654", pos_y = "-14.225", pos_z = "-146.770", flag = "1", entityFlags = "3" WHERE npcid = "17027568";


-- ------------------------------
-- Hiding OOE NPCs and objects --
-- ------------------------------

UPDATE npc_list SET status = 2 WHERE polutils_name = "Wondrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Chichiroon";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Blingbrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Silke";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Pelftrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Ezura-Romazura";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Spondulix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "San d\'Orian Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Bastokan Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Windurstian Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "San d\'Orian Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Bastokan Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Windurstian Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Layton";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Capucine";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Victoire";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Fonteloube";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Palabelle";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Alaune";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Mystrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Suspicious Elvaan";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Habitox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Gerahja";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Gavoroi";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Selliste";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Bountibox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Balthilda";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Matthias";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Gulldago";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Specilox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Suspicious Galka";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Raving Opossum";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Clarion Star";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Cloud Walker";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Arbitrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Drozga";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Suspicious Tarutaru";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Shaty-Monty";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Selele";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Funtrox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Wetata";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Theraisie";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Priztrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Sweepstox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Kindlix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Pyropox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Falgima";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Defliaa";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Ansegusele";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Tevigogo";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Ledericus";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Ishvad";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Eukalline";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Hujette";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Kanil";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Theophylacte";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Rewardox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Tallula";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Bernegeois";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Malgrom";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Old Bellows";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Winrix";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Teleen";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Green Thumb Moogle";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Soupox";
UPDATE npc_list SET status = 2 WHERE polutils_name = "San d\'Orian Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Bastokan Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Windurstian Pursuivant";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Robino-Mobino";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Suspicious Hume";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Festive Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Dealer Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Curio Vendor Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Skipper Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%A.M.A.N. Reclaimer%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Matrimonial Coffer%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Celebratory Chest%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Mog Dinghy%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Odyssean Passage%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Artisan Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Marshal%"; -- Brenner/Ballista
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Splintery Chest%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Resume Point%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Magian Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Duplidoc%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Veridical Conflux%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Cavernous Maw%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Ethereal Junction%"; -- Unity Concord
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Symphonic Curator%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Pursuivant%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Ephemeral Moogle%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Ergon Locus%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%A.M.A.N. Liaison%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Seed Fragment%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Seed Crystal%";
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Burrow Researcher%"; -- Burrows
UPDATE npc_list SET status = 2 WHERE polutils_name LIKE "%Burrow Investigator%"; -- Burrows
UPDATE npc_list SET status = 2 WHERE name LIKE "%Planar_Rift%"; -- Voidwatch
UPDATE npc_list SET status = 2 WHERE npcid = "17727635" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17735873" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17739957" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17756353" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "16982640" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17719642" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17764607" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17776887" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17780999" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17830187" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17826177" AND polutils_name = "Treasure Coffer";
UPDATE npc_list SET status = 2 WHERE npcid = "17756453"; /*Blank (no name, right at the entrance of Heavens Tower)*/
UPDATE npc_list SET status = 2 WHERE npcid = "17772770"; -- Magian stuff
UPDATE npc_list SET status = 2 WHERE npcid = "17772729"; -- Rendezvous Point at Ru'Lude Gardens
UPDATE npc_list SET status = 2 WHERE polutils_name = "Mimble-Pimble";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Pattel-Bacchel"; /*Fishing fatigue system, not 100% sure if OOE*/
UPDATE npc_list SET status = 2 WHERE polutils_name = "Zahsa Syalmhaia";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Toppi-Meppi";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Kiria-Romaria";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Sevah Kummekihn";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Pompi-Rompi";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Mhabi Molkot";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Khoto Rokkorah";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Trisvain";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Rembard";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Gondebaud";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Atelloune";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Arvilauge";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Esmallegue";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Macchi Gazlitah";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Ajahkeem"; -- Fellow system
UPDATE npc_list SET status = 2 WHERE polutils_name = "Inconspicuous Door";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Jamal";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Rendezvous Point";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Afdeen";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Rakuru-Rakoru"; 
UPDATE npc_list SET status = 2 WHERE polutils_name = "Darcia";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Nantoto";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Chatnachoq";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Goldagrik";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Maze Mongers Shopfront"; -- Burrows
UPDATE npc_list SET status = 2 WHERE polutils_name = "Zalsuhm"; -- Mythic weapon's weapon skills unlock NPC
UPDATE npc_list SET status = 2 WHERE polutils_name = "Liki Steligho";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Domenic";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Monisette";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Oboro";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Shemo";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Pulonono"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Zopago"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Hantileon"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Kiria-Romaria"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Gonija"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Arvilauge"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Finbarr"; -- Chocobo society
UPDATE npc_list SET status = 2 WHERE polutils_name = "Vrednev"; -- (Burrows)
UPDATE npc_list SET status = 2 WHERE polutils_name = "Utrig";-- (Burrows)
UPDATE npc_list SET status = 2 WHERE polutils_name = "Mrohk Sahjuuli"; -- Salvage II
UPDATE npc_list SET status = 2 WHERE polutils_name = "Kokba Hostel";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Berangere";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Paparoon"; -- Mythic weapons
UPDATE npc_list SET status = 2 WHERE polutils_name = "Pacomart";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Tonasav";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Gorpa-Masorpa"; -- Ambuscade
UPDATE npc_list SET status = 2 WHERE polutils_name = "Ambuscade Tome"; -- Ambuscade
UPDATE npc_list SET status = 2 WHERE polutils_name = "Tya Padolih"; -- Scroll seller Mhaura
UPDATE npc_list SET status = 2 WHERE polutils_name = "Andrause"; -- A Shantoto ascension
UPDATE npc_list SET status = 2 WHERE polutils_name = "Nolan"; -- Escha
UPDATE npc_list SET status = 2 WHERE polutils_name = "Owain"; -- Voidwatch
UPDATE npc_list SET status = 2 WHERE polutils_name = "Jourdenaux";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Stampeding Bison"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Wandering Cloud"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Nickael"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Clemaurent"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Yvantoine"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Acacia"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Marlena"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Neriss"; -- Starlight celebration
UPDATE npc_list SET status = 2 WHERE polutils_name = "Somnial Threshold"; -- 2011 Dynamis feature https://forum.square-enix.com/ffxi/archive/index.php/t-13047.html?s=3c87bfc5ef04aeda47b9f62c04eb10dc
UPDATE npc_list SET status = 2 WHERE npcid = "17584481" AND name = "qm10"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17584482" AND name = "qm11"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17584483" AND name = "qm12"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17596841" AND name = "qm18"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17596842" AND name = "qm19"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17596843" AND name = "qm20"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17576428" AND name = "qm7"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17576427" AND name = "qm8"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17576426" AND name = "qm9"; -- Question marks for easy LB1
UPDATE npc_list SET status = 2 WHERE npcid = "17424518" AND name = "qm1"; -- Alkyoneus pop ???
UPDATE npc_list SET status = 2 WHERE npcid = "17424519" AND name = "qm2"; -- Pallas pop ???
UPDATE npc_list SET status = 2 WHERE npcid = "17031608" AND name = "qm1"; -- Big Bomb pop ???
UPDATE npc_list SET status = 2 WHERE npcid = "17428873" AND name = "qm10"; -- Sozu Rogberry pop ???
UPDATE npc_list SET status = 2 WHERE npcid = "17212135" AND name = "Moogle";
UPDATE npc_list SET status = 2 WHERE polutils_name = "Linkshell Concierge";

-- ------------------------------------
-- Stellar Fulcrum NPC IDs are wrong --
-- ------------------------------------
DELETE FROM npc_list WHERE npcid BETWEEN 17510682 AND 17510774;
INSERT IGNORE INTO `npc_list` VALUES (17510670,'Seed_Fragment','Seed Fragment',63,-528.941,0.254,0.889,32769,40,40,0,16,112,0,3,0x0000350900000000000000000000000000000000,2,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510671,'Achieve_Master','Achieve Master',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,'SOA',0);
INSERT IGNORE INTO `npc_list` VALUES (17510672,'Unity_Master','Unity Master',0,0.000,0.000,0.000,0,50,50,0,0,96,2,2051,0x0000340000000000000000000000000000000000,0,'SOA',0);
INSERT IGNORE INTO `npc_list` VALUES (17510677,'Kamlanaut','Kam\'lanaut',65,-0.023,-5.003,58.917,0,40,40,0,0,0,6,27,0x00008C0500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510678,'Kamlanaut','Kam\'lanaut',66,-0.030,6.289,58.791,0,40,40,0,0,0,6,27,0x00001F0300000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510679,'Lion','Lion',255,-19.884,-1.500,49.058,0,40,40,0,0,0,6,27,0x00003C0000000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510680,'Zeid','Zeid',142,12.929,-2.153,51.492,0,40,40,0,0,0,6,27,0x00003E0300000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510681,'Aldo','Aldo',66,-0.010,-4.500,66.281,0,40,40,0,0,0,6,27,0x00004E0000000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510682,'Ealdnarche','Eald\'narche',70,0.111,-8.500,75.943,0,40,30,0,0,0,6,27,0x00003D0000000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510683,'Verena','Verena',62,0.090,-8.499,79.287,0,40,24,0,0,0,6,27,0x00004F0000000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510684,'Shadow_Lord','Shadow Lord',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0000930500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510685,'Crystal_Knight','Crystal Knight',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0000980500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510686,'Crystal_Knight','Crystal Knight',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0000970500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510687,'Crystal_Knight','Crystal Knight',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0000990500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510688,'Crystal_Knight','Crystal Knight',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x00009A0500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510689,'Crystal_Knight','Crystal Knight',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0000960500000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510690,'_4z0','Qe\'Iov Gate',0,-519.994,-6.300,22.350,1,40,40,9,0,0,0,4099,0x0200000000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510691,'_4z1','Qo\'Tav Gate',0,0.000,198.213,-388.500,1,40,40,9,0,0,0,4099,0x0200000000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510692,'_4z2','Qo\'Tav Gate',0,0.000,-1.786,11.500,1,40,40,9,0,0,0,4099,0x0200000000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510693,'_4z3','Qo\'Tav Gate',0,0.000,-201.786,411.500,1,40,40,9,0,0,0,4099,0x0200000000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510699,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510700,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510701,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510702,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510703,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510704,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510705,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510706,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510707,'Ramblix','Ramblix',218,-515.921,1.059,-40.858,0,40,40,0,0,0,6,27,0x0000550000000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510708,'Goblin_Footprint','Goblin Footprint',218,-515.921,1.059,-40.858,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510709,'qm1','???',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2051,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510710,'blank','     ',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2051,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510711,'Serpent_Generals','Serpent Generals',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2051,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510712,'Rughadjeen','Rughadjeen',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2077,0x01000703B210B220B230B240B250796100700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510713,'Gadalar','Gadalar',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2075,0x01000101A010AE20AE30AE40AE506E6100700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510714,'Mihli_Aliapoh','Mihli Aliapoh',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2077,0x01000D07AE10AE20AE30AE40AE506F6020700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510715,'Zazarg','Zazarg',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2077,0x01000F089F10AE20AE30AE40AE50FE61FE710000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510716,'Najelith','Najelith',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2073,0x010006029510AE20A030AE40AE507B6100700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510717,'blank','     ',219,-336.007,-176.473,-10.953,86,50,50,0,8,0,1,1669,0x0000040100000000000000000000000000000000,64,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510718,'Mathilde','Mathilde',0,0.000,0.000,0.000,0,50,50,0,0,0,6,27,0x0100020200101520003003400850006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510719,'Aldo','Aldo',0,0.000,0.000,0.000,0,50,50,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510720,'Young_Aldo','Young Aldo',0,0.000,0.000,0.000,0,50,50,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510721,'Seed_Crystal','Seed Crystal',0,0.000,0.000,0.000,0,50,50,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510722,'qm2','???',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2051,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510723,'blank','     ',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2051,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510724,'blank','     ',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510725,'NPC01','NPC01',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510726,'NPC02','NPC02',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510727,'NPC03','NPC03',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510728,'NPC04','NPC04',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0100000000100020003000400050006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510729,'NPC05','NPC05',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0100000000100020003000400050006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510730,'Jyujin01','Jyujin01',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510731,'Jyujin02','Jyujin02',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510732,'Jyujin03','Jyujin03',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510733,'Jyujin04','Jyujin04',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510734,'Jyujin05','Jyujin05',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510735,'blank','     ',0,0.000,0.000,0.000,0,40,40,0,0,0,2,2051,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510736,'Verena','Verena',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x00004F0000000000000000000000000000000000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510737,'mob01','mob01',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x0100000158105820583058405850006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510738,'mob02','mob02',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0100020100101920193019401950006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510739,'mob03','mob03',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x010006013C103C203C303C403C50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510740,'mob04','mob04',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x0100000239103920393039403950006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510741,'mob05','mob05',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x01000C0244104420443044404450006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510742,'mob06','mob06',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x01000402A210A220A230A240A250006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510743,'mob07','mob07',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x01000A0356105620563056405650006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510744,'mob08','mob08',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x010000034E104E204E304E404E50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510745,'mob09','mob09',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x010002034C104C204C304C404C50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510746,'mob10','mob10',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x0100000400108720873087408750006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510747,'mob11','mob11',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0100040400100320033003400350006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510748,'mob12','mob12',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x0100090418101820183018401850006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510749,'mob13','mob13',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x0100050542104220423042404250006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510750,'mob14','mob14',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0100080550105020503050405050006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510751,'mob15','mob15',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x0100030588108820883088408850006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510752,'mob16','mob16',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x0100000600108E208E308E408E50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510753,'mob17','mob17',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x0100070689108920893089408950006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510754,'mob18','mob18',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x0100090660106020603060406050006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510755,'mob19','mob19',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x01000007A110A120A130A140A150006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510756,'mob20','mob20',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x01000B0700100920093009400950006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510757,'mob21','mob21',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x0100050700101F201F301F401F50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510758,'mob22','mob22',0,0.000,0.000,0.000,0,40,40,0,0,0,6,25,0x0100020865106520653065406550006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510759,'mob23','mob23',0,0.000,0.000,0.000,0,40,40,0,0,0,6,27,0x01000C086A106A206A306A406A50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510760,'mob24','mob24',0,0.000,0.000,0.000,0,40,40,0,0,0,6,29,0x010006081D101D201D301D401D50006000700000,32,NULL,1);
INSERT IGNORE INTO `npc_list` VALUES (17510761,'qm3','???',0,-515.423,-5.053,17.241,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT IGNORE INTO `npc_list` VALUES (17510762,'Moogle','Moogle',0,-515.423,-5.053,17.241,0,40,40,0,0,0,6,27,0x0000520000000000000000000000000000000000,32,NULL,1);

-- -------------------------------------------
-- The Sanctuary of ZiTah NPC IDs are wrong --
-- -------------------------------------------
DELETE FROM npc_list WHERE npcid BETWEEN 17273335 AND 17273435;
INSERT IGNORE INTO `npc_list` VALUES(17273334, 'qm1', '???', 0, -324.360, 0.115, 474.307, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273337, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273338, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273339, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273340, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273341, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273342, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273343, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273344, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273345, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273346, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273347, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273348, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273349, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273350, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273351, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273352, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273353, 'Treasure_Coffer', 'Treasure Coffer', 96, -195.923, -0.500, 84.055, 7, 40, 40, 0, 4, 12, 2, 2051, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273354, 'Achieve_Master', 'Achieve Master', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 2, 3, 0x0000320000000000000000000000000000000000, 0, 'SOA', 0);
INSERT IGNORE INTO `npc_list` VALUES(17273355, 'Unity_Master', 'Unity Master', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 96, 2, 2051, 0x0000340000000000000000000000000000000000, 0, 'SOA', 0);
INSERT IGNORE INTO `npc_list` VALUES(17273358, 'NPC[9]', '', 0, 0.000, -0.500, 0.000, 0, 40, 40, 0, 0, 0, 2, 1, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273359, 'NPC[10]', '', 0, 0.000, -0.500, 0.000, 0, 40, 40, 0, 16, 32, 2, 129, 0x00002c0900000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273360, 'blank', '', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273361, 'EFFECTER', 'EFFECTER', 144, -403.192, -130.218, 546.429, 32769, 40, 40, 0, 0, 0, 6, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273362, 'Carbuncle', 'Carbuncle', 144, -403.192, -130.218, 546.429, 32768, 40, 40, 0, 0, 0, 6, 27, 0x0000170300000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273363, 'Talking_Doll', 'Talking Doll', 113, -252.162, -5.319, -307.011, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273364, 'Credaurion_RK', 'Credaurion, R.K.', 189, -40.079, 0.358, -148.785, 19, 40, 40, 0, 0, 0, 2, 27, 0x01000c030d100c2002300c400250f96000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273365, 'Calliope_IM', 'Calliope, I.M.', 189, -40.079, 0.358, -148.785, 7, 40, 40, 0, 0, 0, 2, 27, 0x01000f0200100520053005400750b760b8700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273366, 'Ajimo-Majimo_WW', 'Ajimo-Majimo, W.W.', 189, -40.079, 0.358, -148.785, 7, 40, 40, 0, 0, 0, 2, 27, 0x01000c051310132016300540075052601e700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273367, 'Conquest_Banner', '', 180, -37.570, 0.287, -150.215, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002e0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273368, 'Conquest_Banner', '', 180, -37.570, 0.287, -150.215, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002f0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273369, 'Conquest_Banner', '', 180, -37.570, 0.287, -150.215, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000300300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273370, 'Conquest_Banner', '', 189, -40.079, 0.358, -148.785, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000310300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273371, 'Limion_RK', 'Limion, R.K.', 225, -252.454, -0.958, 624.366, 26, 40, 40, 0, 0, 0, 2, 27, 0x010005040d1006200c300c400c50086100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273372, 'Dedden_IM', 'Dedden, I.M.', 225, -252.454, -0.958, 624.366, 7, 40, 40, 0, 0, 0, 2, 27, 0x01000c0805100220023002400f504e602d700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273373, 'Ochocho_WW', 'Ochocho, W.W.', 225, -252.454, -0.958, 624.366, 6, 40, 40, 0, 0, 0, 2, 27, 0x01000c060f10182005300540075052601e700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273374, 'Kasim', 'Kasim', 221, -48.001, 0.121, -149.279, 7, 40, 40, 0, 0, 0, 2, 27, 0x00005f0300000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273375, 'Conquest_Banner', '', 217, -252.394, -0.978, 622.077, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002e0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273376, 'Conquest_Banner', '', 217, -252.394, -0.978, 622.077, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002f0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273377, 'Conquest_Banner', '', 217, -252.394, -0.978, 622.077, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000300300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273378, 'Conquest_Banner', '', 225, -252.454, -0.958, 624.366, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000310300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273379, 'NPC[1d]', '', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 3, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273380, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273381, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273382, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273383, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273384, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273385, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273386, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273387, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273388, 'blank', '', 0, 0.000, 0.000, 0.000, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273389, 'Cermet_Headstone', 'Cermet Headstone', 124, 232.307, -1.098, 279.952, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273390, 'ScenarioBoss', 'ScenarioBoss', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 155, 0x0000400100000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273391, 'blank', '', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273392, 'blank', '', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273393, 'qm2', '???', 120, 642.317, -4.877, -149.643, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273394, 'qm3', '???', 185, -418.884, 1.272, 48.382, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273395, 'qm4', '???', 79, 23.058, 0.483, 94.635, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273396, 'Carmelo', 'Carmelo', 79, 23.058, 0.483, 94.635, 1, 40, 40, 0, 1, 0, 2, 27, 0x0100060112101720003018401850006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273397, 'Dariah', 'Dariah', 33, 12.175, 1.421, 94.244, 0, 40, 40, 0, 1, 0, 6, 27, 0x0100020214101720133009400f50006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273398, 'Beastmens_Banner', 'Beastmen\'s Banner', 174, -399.822, 0.161, -168.998, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000310300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273399, 'Ramblix', 'Ramblix', 225, -428.864, -0.137, -443.629, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000550000000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273400, 'Goblin_Footprint', 'Goblin Footprint', 225, -428.864, -0.137, -443.629, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273401, 'relic', '', 70, 646.788, -2.175, -165.855, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273402, 'Capacucu', 'Capacucu', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100000643104320433043404350ff61ff710000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273403, 'Putori-Tutori', 'Putori-Tutori', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x010003054b104b204b304b404b504e6100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273404, 'Kilhwch', 'Kilhwch', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000d014d104d204d304d404d50406100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273405, 'Mieuseloir', 'Mieuseloir', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x010000034d104d204d304d404d503f6100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273406, 'Lhu_Mhakaracca', 'Lhu Mhakaracca', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000d07511051205130514051505b6100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273407, 'Xonia', 'Xonia', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000d0241104120413041404150536100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273408, 'Fonove', 'Fonove', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000c044f104f204f304f404f50526100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273409, 'Dzhau_Yaam', 'Dzhau Yaam', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x010007075b105b205b305b405b50d96000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273410, 'Kupalu-Harupalu', 'Kupalu-Harupalu', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000c0559105920593059405950586100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273411, 'Noillurie', 'Noillurie', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000a0457105720573057405750546100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273412, 'Umon-Paumon', 'Umon-Paumon', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000b0547104720473047404750566100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273413, 'Ghebben', 'Ghebben', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000c0855105520553055405550006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273414, 'Elrica', 'Elrica', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100040255105520553055405550006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273415, 'Terounalivet', 'Terounalivet', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100060353105320533053405350006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273416, 'qm5', '???', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17273417, 'relic', '', 43, -18.301, -0.507, 55.638, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273418, 'Ferreous_Coffin', 'Ferreous Coffin', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100090845104520453045404550336100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273420, 'Field_Manual', 'Field Manual', 125, -461.454, 0.990, -461.800, 19, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 32, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273421, 'Field_Manual', 'Field Manual', 67, -34.000, 0.057, -150.177, 7, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 32, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273422, 'Field_Parchment', 'Field Parchment', 96, -196.000, -0.500, 84.000, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273426, 'Mogball-Local', 'Mogball-Local', 0, 0.000, 0.000, 0.000, 1, 40, 40, 0, 0, 0, 2, 3, 0x0000310300000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273427, 'Mog-Tablet', 'Mog-Tablet', 0, 49.071, -0.341, -119.820, 7, 40, 40, 0, 5, 4, 6, 387, 0x0000f70800000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17273428, 'Planar_Rift', 'Planar Rift', 0, -275.000, 0.200, 46.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273429, 'Planar_Rift', 'Planar Rift', 0, -90.000, 0.600, -312.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273430, 'Planar_Rift', 'Planar Rift', 0, -400.000, 0.300, -130.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273431, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -274.899, 0.200, 46.000, 1, 40, 40, 0, 4, 100, 2, 3, 0x0000c90300000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273432, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -89.900, 0.600, -312.000, 1, 40, 40, 0, 4, 100, 2, 3, 0x0000c90300000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273433, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -399.899, 0.300, -130.000, 1, 40, 40, 0, 4, 100, 2, 3, 0x0000c90300000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17273434, 'Survival_Guide', 'Survival Guide', 64, -45.000, 0.200, -151.000, 1, 50, 50, 0, 17, 32, 2, 3, 0x0000810900000000000000000000000000000000, 0, NULL, 1);

-- ------------------------------------------
-- Western Altepa Desert NPC IDs are wrong --
-- ------------------------------------------
DELETE FROM npc_list WHERE npcid BETWEEN 17289719 AND 17289817;
INSERT IGNORE INTO `npc_list` VALUES(17289718, 'qm1', '???', 0, -659.294, 0.237, -338.234, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289720, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289721, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289722, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289723, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289724, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289725, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289726, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289727, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289728, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289729, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289730, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289731, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289732, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289733, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289734, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289735, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289736, 'Treasure_Coffer', 'Treasure Coffer', 128, 44.064, -0.500, -239.943, 6, 40, 40, 0, 4, 12, 2, 2051, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289737, 'Achieve_Master', 'Achieve Master', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 2, 3, 0x0000320000000000000000000000000000000000, 0, 'SOA', 0);
INSERT IGNORE INTO `npc_list` VALUES(17289738, 'Unity_Master', 'Unity Master', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 96, 2, 2051, 0x0000340000000000000000000000000000000000, 0, 'SOA', 0);
INSERT IGNORE INTO `npc_list` VALUES(17289741, 'NPC[7]', '', 0, 0.000, -0.500, 0.000, 0, 40, 40, 0, 0, 0, 2, 1, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289742, 'NPC[8]', '', 0, 0.000, -0.500, 0.000, 0, 40, 40, 0, 0, 32, 2, 129, 0x00002c0900000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289743, 'NPC[9]', '', 0, 0.000, -0.500, 0.000, 0, 40, 40, 0, 0, 32, 2, 129, 0x00002c0900000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289744, '_3h0', 'Altepa Gate', 0, -20.000, 9.305, 137.445, 1, 40, 40, 9, 0, 0, 0, 4099, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289745, '_3h1', '', 0, -12.731, 8.198, 114.008, 1, 40, 40, 9, 0, 0, 0, 6147, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289746, '_3h2', '', 0, -12.702, 8.198, 98.025, 1, 40, 40, 9, 0, 0, 0, 6147, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289747, '_3h3', '', 0, -27.264, 8.198, 97.978, 1, 40, 40, 9, 0, 0, 0, 6147, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289748, '_3h4', '', 0, -27.271, 8.198, 113.982, 1, 40, 40, 9, 0, 0, 0, 6147, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289749, '_3h5', 'Ruby Column', 0, 60.004, 8.497, -107.998, 1, 40, 40, 9, 0, 0, 0, 4099, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289750, '_3h6', 'Topaz Column', 0, -260.000, 8.500, -348.006, 1, 40, 40, 9, 0, 0, 0, 4099, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289751, '_3h7', 'Emerald Column', 0, -771.999, 0.498, -459.999, 1, 40, 40, 9, 0, 0, 0, 4099, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289752, '_3h8', 'Sapphire Column', 0, -499.998, 8.500, 227.999, 1, 40, 40, 9, 0, 0, 0, 4099, 0x0200000000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289753, 'EFFECTER', 'EFFECTER', 60, 0.000, -50.392, 0.000, 32769, 40, 40, 0, 0, 0, 6, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289754, 'Carbuncle', 'Carbuncle', 60, 0.000, -50.392, 0.000, 32768, 40, 40, 0, 0, 0, 6, 27, 0x0000170300000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289755, 'Talking_Doll', 'Talking Doll', 113, -252.162, -5.319, -307.011, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289756, 'Dreamrose', 'Dreamrose', 205, -262.403, -10.155, 49.164, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289757, 'qm2', '???', 245, -328.479, 0.068, -112.932, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289759, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289760, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289761, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289762, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289763, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289764, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289765, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289766, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289767, 'blank', '', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289768, 'Cermet_Headstone', 'Cermet Headstone', 77, -112.269, 9.983, -220.492, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289769, 'Peddlestox', 'Peddlestox', 207, 512.374, 0.017, 10.570, 26, 40, 40, 0, 0, 0, 2, 27, 0x0000f70100000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289770, 'Casket', 'Casket', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 1, 0x0000c00300000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289771, 'Casket', 'Casket', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289772, 'qm3', '???', 0, -197.901, -0.733, 357.648, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289773, 'qm4', '???', 0, -113.454, -4.459, -58.319, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289774, 'qm5', '???', 0, 3.302, -0.302, -250.435, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289775, 'qm6', '???', 0, -476.967, 0.159, 17.835, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289776, 'qm7', '???', 0, -454.701, -3.465, -286.864, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289777, 'qm8', '???', 0, -223.055, -0.085, -672.207, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289778, 'qm9', '???', 0, -631.524, 0.046, -336.254, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289779, 'qm10', '???', 0, -670.697, -8.438, -677.751, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289780, 'relic', '', 2, -152.197, -16.722, 20.337, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289781, 'Capacucu', 'Capacucu', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100000643104320433043404350ff61ff710000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289782, 'Putori-Tutori', 'Putori-Tutori', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x010003054b104b204b304b404b504e6100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289783, 'Kilhwch', 'Kilhwch', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000d014d104d204d304d404d50406100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289784, 'Mieuseloir', 'Mieuseloir', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x010000034d104d204d304d404d503f6100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289785, 'Lhu_Mhakaracca', 'Lhu Mhakaracca', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000d07511051205130514051505b6100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289786, 'Xonia', 'Xonia', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000d0241104120413041404150536100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289787, 'Fonove', 'Fonove', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000c044f104f204f304f404f50526100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289788, 'Dzhau_Yaam', 'Dzhau Yaam', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x010007075b105b205b305b405b50d96000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289789, 'Kupalu-Harupalu', 'Kupalu-Harupalu', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000c0559105920593059405950586100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289790, 'Noillurie', 'Noillurie', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000a0457105720573057405750546100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289791, 'Umon-Paumon', 'Umon-Paumon', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000b0547104720473047404750566100700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289792, 'Ghebben', 'Ghebben', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x01000c0855105520553055405550006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289793, 'Elrica', 'Elrica', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100040255105520553055405550006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289794, 'Terounalivet', 'Terounalivet', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 2075, 0x0100060353105320533053405350006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289795, 'qm11', '???', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289796, 'Ramblix', 'Ramblix', 247, 662.782, 12.015, -95.573, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000550000000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289797, 'Goblin_Footprint', 'Goblin Footprint', 247, 662.782, 12.015, -95.573, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17289798, 'Field_Manual', 'Field Manual', 189, 446.106, -1.824, 353.842, 1, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 32, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289799, 'Field_Manual', 'Field Manual', 41, -216.138, -11.805, 102.130, 32, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 32, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289800, 'Field_Manual', 'Field Manual', 65, -113.032, -2.101, -474.046, 26, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 32, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289801, 'Field_Parchment', 'Field Parchment', 128, 44.000, -0.500, -240.000, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289805, 'Mogball-Local', 'Mogball-Local', 0, 0.000, 0.000, 0.000, 1, 40, 40, 0, 0, 0, 2, 3, 0x0000310300000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289806, 'Mog-Tablet', 'Mog-Tablet', 0, -307.780, -0.777, -606.940, 7, 40, 40, 0, 5, 4, 6, 387, 0x0000f70800000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289807, 'Planar_Rift', 'Planar Rift', 0, 554.000, 0.699, 260.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289808, 'Planar_Rift', 'Planar Rift', 0, -228.000, -1.000, -498.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289809, 'Planar_Rift', 'Planar Rift', 0, -170.000, 0.001, 327.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289810, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, 554.099, 0.699, 260.000, 1, 40, 40, 0, 5, 0, 2, 3, 0x0000c90300000000000000000000000000000000, 0, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289811, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -227.899, -1.000, -498.000, 1, 40, 40, 0, 5, 0, 2, 3, 0x0000c90300000000000000000000000000000000, 0, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289812, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -169.899, 0.001, 327.000, 1, 40, 40, 0, 5, 0, 2, 3, 0x0000c90300000000000000000000000000000000, 0, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17289815, 'Fireworks', '', 233, 437.103, -12.259, 387.515, 32769, 40, 40, 0, 0, 0, 2, 2075, 0x0000470100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17289816, 'Survival_Guide', 'Survival Guide', 32, 420.000, -3.289, 11.000, 23, 50, 50, 0, 17, 32, 2, 3, 0x0000810900000000000000000000000000000000, 0, NULL, 1);

-- ------------------------------------------
-- Eastern Altepa Desert NPC IDs are wrong --
-- ------------------------------------------
DELETE FROM npc_list WHERE npcid BETWEEN 17244596 AND 17244669;
INSERT INTO `npc_list` VALUES (17244595,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244596,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244597,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244598,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244599,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244600,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244601,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244602,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244603,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244604,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244605,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244606,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244607,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244608,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244609,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244610,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244611,'Treasure_Coffer','Treasure Coffer',192,238.075,7.000,-367.900,7,40,40,0,4,12,2,2051,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244612,'Achieve_Master','Achieve Master',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,'SOA',0);
INSERT INTO `npc_list` VALUES (17244613,'Unity_Master','Unity Master',0,0.000,0.000,0.000,0,50,50,0,0,96,2,2051,0x0000340000000000000000000000000000000000,0,'SOA',0);
INSERT INTO `npc_list` VALUES (17244618,'Telepoint','Telepoint',0,-61.942,3.949,224.900,1,40,40,0,0,0,0,3,0x0000370000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17244621,'qm','???',223,111.939,-8.724,-72.803,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244622,'EFFECTER','EFFECTER',60,0.000,-50.392,0.000,32769,40,40,0,0,0,6,2051,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17244623,'Carbuncle','Carbuncle',60,0.000,-50.392,0.000,32768,40,40,0,0,0,6,27,0x0000170300000000000000000000000000000000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244624,'Talking_Doll','Talking Doll',113,-252.162,-5.319,-307.011,0,40,40,0,0,0,6,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17244626,'Eaulevisat_RK','Eaulevisat, R.K.',248,-258.041,8.473,-254.527,8,40,40,0,0,0,2,27,0x01000D030C100C200C300C400C50FA601B700000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17244627,'Lindgard_IM','Lindgard, I.M.',248,-258.041,8.473,-254.527,6,40,40,0,0,0,2,27,0x0100030205100520163005400550B860B6700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244628,'Variko-Njariko_WW','Variko-Njariko, W.W.',248,-258.041,8.473,-254.527,33,40,40,0,0,0,2,27,0x01000D0512101320053005400550546021700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244629,'Conquest_Banner','     ',239,-258.479,8.538,-256.276,1,40,40,0,0,0,2,2051,0x00002E0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244630,'Conquest_Banner','     ',239,-258.479,8.538,-256.276,1,40,40,0,0,0,2,2051,0x00002F0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244631,'Conquest_Banner','     ',239,-258.479,8.538,-256.276,1,40,40,0,0,0,2,2051,0x0000300300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244632,'Conquest_Banner','     ',248,-258.041,8.473,-254.527,1,40,40,0,0,0,2,2051,0x0000310300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244633,'Laimeve_RK','Laimeve, R.K.',169,226.493,-11.231,260.194,6,40,40,0,0,0,2,27,0x01000D040610062006300C4006500A6100700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244634,'Daborn_IM','Daborn, I.M.',169,226.493,-11.231,260.194,16,40,40,0,0,0,2,27,0x01000D080210022016300240025052601E700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244635,'Sahgygy_WW','Sahgygy, W.W.',169,226.493,-11.231,260.194,1,40,40,0,0,0,2,27,0x01000D060E10182006300540055054602D700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244636,'Sowande','Sowande',232,-259.123,8.477,-250.438,7,40,40,0,1,0,2,27,0x01000A01121018200F3007401150006000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244637,'Conquest_Banner','     ',154,228.186,-11.212,259.842,1,40,40,0,0,0,2,2051,0x00002E0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244638,'Conquest_Banner','     ',154,228.186,-11.212,259.842,1,40,40,0,0,0,2,2051,0x00002F0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244639,'Conquest_Banner','     ',154,228.186,-11.212,259.842,1,40,40,0,0,0,2,2051,0x0000300300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244640,'Conquest_Banner','     ',169,226.493,-11.231,260.194,1,40,40,0,0,0,2,2051,0x0000310300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244642,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244643,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244644,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244645,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244646,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244647,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244648,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244649,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244650,'qm2','???',76,47.852,-7.808,403.391,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244651,'Beastmens_Banner','Beastmen\'s Banner',60,-332.218,-1.208,126.229,1,40,40,0,0,0,0,3,0x0000310300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17244653,'Eulaclaire','Eulaclaire',119,-55.715,3.949,232.524,16,40,40,0,1,0,0,27,0x01000D04151010200A3015401850006000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244654,'blank','     ',120,-55.715,3.949,233.824,7,40,40,0,0,0,0,2075,0x0000560000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17244655,'Lokpix','Lokpix',129,-55.400,3.000,224.000,7,40,40,0,0,0,0,27,0x0000550000000000000000000000000000000000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244656,'Field_Manual','Field Manual',66,472.690,-1.165,-63.307,33,40,40,0,8,32,0,3,0x0000F20800000000000000000000000000000000,32,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17244657,'Field_Manual','Field Manual',149,-259.317,8.527,-260.421,27,40,40,0,8,32,0,3,0x0000F20800000000000000000000000000000000,32,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17244658,'Field_Manual','Field Manual',120,-64.828,3.949,232.528,16,40,40,0,8,32,0,3,0x0000F20800000000000000000000000000000000,32,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17244659,'Field_Parchment','Field Parchment',192,238.000,7.000,-368.000,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17244663,'Mogball-Local','Mogball-Local',0,0.000,0.000,0.000,1,40,40,0,0,0,2,3,0x0000310300000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17244664,'Mog-Tablet','Mog-Tablet',0,-42.003,-7.668,303.374,7,40,40,0,5,4,6,873,0x0000F70800000000000000000000000000000000,0,NULL,1);
-- Fireworks
INSERT INTO `npc_list` VALUES (17244667,'Fireworks','     ',89,398.651,16.000,596.820,32769,50,50,0,0,0,0,2075,0x0000470100000000000000000000000000000000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17244668,'Survival_Guide','Survival Guide',128,-260.000,8.500,-265.000,1,50,50,0,17,32,0,3,0x0000810900000000000000000000000000000000,0,'SURVIVAL_GUIDE',1);

-- ------------------------------------------
-- Yuhtunga Jungle NPC IDs are wrong --
-- ------------------------------------------
DELETE FROM npc_list WHERE npcid BETWEEN 17281559 AND 17281682;
INSERT IGNORE INTO `npc_list` VALUES(17281558, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281559, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281560, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281561, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281562, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281563, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281564, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281565, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281566, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281567, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281568, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281569, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281570, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281571, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281572, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281573, 'Treasure_Casket', 'Treasure Casket', 0, 0.000, 0.000, 0.000, 7, 40, 40, 0, 4, 4, 2, 3, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281574, 'Treasure_Coffer', 'Treasure Coffer', 224, -451.919, -0.800, -299.927, 7, 40, 40, 0, 4, 12, 2, 2051, 0x0000c50300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281575, 'Achieve_Master', 'Achieve Master', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 2, 3, 0x0000320000000000000000000000000000000000, 0, 'SOA', 0);
INSERT IGNORE INTO `npc_list` VALUES(17281576, 'Unity_Master', 'Unity Master', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 96, 2, 2051, 0x0000340000000000000000000000000000000000, 0, 'SOA', 0);
INSERT IGNORE INTO `npc_list` VALUES(17281581, 'Firebloom_Tree_Root', 'Firebloom Tree Root', 121, -102.860, 5.500, -90.699, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281582, 'Firebloom_Tree_Root', 'Firebloom Tree Root', 115, -97.108, 6.500, -107.499, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281583, 'Firebloom_Tree_Root', 'Firebloom Tree Root', 242, -90.248, 7.400, -102.046, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281584, 'Firebloom_Tree_Root', 'Firebloom Tree Root', 103, -117.016, 5.857, -103.580, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281585, 'Blue_Rafflesia', 'Blue Rafflesia', 170, -468.876, 0.070, 220.247, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281586, 'Blue_Rafflesia', 'Blue Rafflesia', 109, -150.779, -0.200, -223.072, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281587, 'Blue_Rafflesia', 'Blue Rafflesia', 83, 50.360, -0.100, -501.773, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281588, 'qm1', '???', 240, 357.448, 3.999, 217.592, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281589, 'qm2', '???', 236, 362.586, 3.999, 220.106, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281590, 'Ildy-Goldy', 'Ildy-Goldy', 85, 403.552, 21.469, 249.278, 0, 40, 40, 0, 1, 0, 6, 29, 0x010008051d10282010300d400d50006000700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281591, '1', '1', 137, 450.573, 19.395, 259.278, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000110100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281592, '2', '2', 142, 451.246, 19.336, 258.129, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000110100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281593, '3', '3', 131, 453.352, 19.135, 258.622, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000110100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281594, '4', '4', 127, 453.853, 19.052, 257.665, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000110100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281595, '5', '5', 119, 453.368, 19.120, 258.964, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000110100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281596, 'EFFECTER', 'EFFECTER', 197, -30.873, -57.000, 285.545, 32769, 40, 40, 0, 0, 0, 6, 2051, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281597, 'Carbuncle', 'Carbuncle', 197, -30.873, -57.000, 285.545, 32768, 40, 40, 0, 0, 0, 6, 27, 0x0000170300000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281598, 'Talking_Doll', 'Talking Doll', 113, -252.162, -5.319, -307.011, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281599, 'Zorchorevi_RK', 'Zorchorevi, R.K.', 191, -242.487, 0.000, -402.772, 6, 40, 40, 0, 0, 0, 2, 27, 0x01000f030d100c2002300c400c504b601b700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281600, 'Mahol_IM', 'Mahol, I.M.', 191, -242.487, 0.000, -402.772, 8, 40, 40, 0, 0, 0, 2, 27, 0x0100010205100520163005400550bc60b8700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281601, 'Uphra-Kophra_WW', 'Uphra-Kophra, W.W.', 191, -242.487, 0.000, -402.772, 1, 40, 40, 0, 0, 0, 2, 27, 0x01000f051210132016300540075058601e700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281602, 'Conquest_Banner', '', 188, -240.330, 0.000, -404.032, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002e0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281603, 'Conquest_Banner', '', 188, -240.330, 0.000, -404.032, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002f0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281604, 'Conquest_Banner', '', 188, -240.330, 0.000, -404.032, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000300300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281605, 'Conquest_Banner', '', 191, -242.487, 0.000, -402.772, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000310300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281606, 'Mupia_RK', 'Mupia, R.K.', 255, -241.334, 0.000, 478.602, 7, 40, 40, 0, 0, 0, 2, 27, 0x01000f040610062006300c400650cd6000700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281607, 'Bammiro_IM', 'Bammiro, I.M.', 255, -241.334, 0.000, 478.602, 21, 40, 40, 0, 0, 0, 2, 27, 0x01000f0802100220163002400f5057602d700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281608, 'Richacha_WW', 'Richacha, W.W.', 255, -241.334, 0.000, 478.602, 8, 40, 40, 0, 0, 0, 2, 27, 0x01000f060e10182005300540055058601e700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281609, 'Robino-Mobino', 'Robino-Mobino', 209, -245.854, 0.137, -404.282, 7, 40, 40, 0, 1, 0, 2, 27, 0x01000a05121018200f3007401150006000700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281610, 'Conquest_Banner', '', 247, -241.684, 0.000, 476.590, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002e0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281611, 'Conquest_Banner', '', 247, -241.684, 0.000, 476.590, 1, 40, 40, 0, 0, 0, 2, 2051, 0x00002f0300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281612, 'Conquest_Banner', '', 247, -241.684, 0.000, 476.590, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000300300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281613, 'Conquest_Banner', '', 255, -241.334, 0.000, 478.602, 1, 40, 40, 0, 0, 0, 2, 2051, 0x0000310300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281615, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281616, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281617, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281618, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281619, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281620, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281621, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281622, 'Moogle', 'Moogle', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 2, 4194307, 0x0000520000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281624, 'Cermet_Headstone', 'Cermet Headstone', 215, 493.915, 19.658, 303.495, 32769, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281625, 'OpoopoA', 'OpoopoA', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000a00100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281626, 'OpoopoB', 'OpoopoB', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000a00100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281627, 'OpoopoC', 'OpoopoC', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000a00100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281629, 'Logging_Point', 'Logging Point', 0, -494.337, 2.541, 174.775, 32775, 40, 40, 0, 0, 0, 0, 3, 0x0000770900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281630, 'Logging_Point', 'Logging Point', 0, 22.268, 4.422, -496.500, 32775, 40, 40, 0, 0, 0, 2, 3, 0x0000770900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281631, 'Logging_Point', 'Logging Point', 0, -534.010, -0.086, 168.876, 32774, 40, 40, 0, 0, 0, 2, 3, 0x0000770900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281632, 'Logging_Point', 'Logging Point', 0, -52.218, 1.830, -456.071, 32775, 40, 40, 0, 0, 0, 2, 3, 0x0000770900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281633, 'Logging_Point', 'Logging Point', 0, -217.955, 2.944, -142.003, 32775, 40, 40, 0, 0, 0, 2, 3, 0x0000770900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281634, 'Logging_Point', 'Logging Point', 0, -494.337, 2.541, 174.775, 32775, 40, 40, 0, 0, 0, 2, 3, 0x0000770900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281635, 'Harvesting_Point', 'Harvesting Point', 0, -250.381, 12.358, -418.463, 32774, 40, 40, 0, 0, 0, 0, 3, 0x0000760900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281636, 'Harvesting_Point', 'Harvesting Point', 0, -650.923, 11.987, -59.148, 32774, 40, 40, 0, 0, 0, 2, 3, 0x0000760900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281637, 'Harvesting_Point', 'Harvesting Point', 0, -60.695, 8.121, 308.915, 32774, 40, 40, 0, 0, 0, 2, 3, 0x0000760900000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281638, 'Beastmens_Banner', 'Beastmen\'s Banner', 132, -305.061, 16.172, -438.904, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000310300000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281639, 'Peddlestox', 'Peddlestox', 171, -103.286, 0.601, 434.866, 21, 40, 40, 0, 0, 0, 2, 27, 0x0000f70100000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281640, 'Casket', 'Casket', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 1, 0x0000c00300000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281641, 'Casket', 'Casket', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281642, 'qm3', '???', 0, 83.726, -1.212, 448.329, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281643, 'qm4', '???', 0, -114.254, -3.981, -125.471, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281644, 'qm5', '???', 0, -300.823, 6.558, 9.208, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281645, 'qm6', '???', 0, -539.311, -0.168, 203.151, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281646, 'qm7', '???', 0, -577.734, -0.706, -82.563, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281647, 'qm8', '???', 0, -361.835, 15.695, -399.517, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281648, 'qm9', '???', 0, -294.827, -1.530, -453.237, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281649, 'qm10', '???', 0, 369.795, 2.478, 201.805, 1, 40, 40, 0, 0, 0, 0, 131, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281650, 'Ramblix', 'Ramblix', 133, -220.259, -0.016, 498.796, 0, 40, 40, 0, 0, 0, 6, 27, 0x0000550000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281651, 'Goblin_Footprint', 'Goblin Footprint', 133, -220.259, -0.016, 498.796, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 0);
INSERT IGNORE INTO `npc_list` VALUES(17281653, 'Marilleune', 'Marilleune', 202, -340.271, 15.945, -472.734, 1, 40, 40, 0, 1, 0, 2, 27, 0x01000604151010200a3015401850006000700000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281655, 'LuckRune', 'LuckRune', 77, -95.486, 11.188, 418.153, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281656, 'Field_Manual', 'Field Manual', 42, -224.526, -0.298, 497.211, 8, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281657, 'Field_Manual', 'Field Manual', 64, -237.403, 0.000, -403.785, 1, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281658, 'Field_Manual', 'Field Manual', 243, -457.094, 8.102, -38.796, 27, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281659, 'Field_Manual', 'Field Manual', 12, 380.648, 20.113, 348.324, 21, 40, 40, 0, 8, 32, 0, 3, 0x0000f20800000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281660, 'Field_Parchment', 'Field Parchment', 224, -452.000, -0.800, -300.000, 1, 40, 40, 0, 0, 0, 0, 3, 0x0000340000000000000000000000000000000000, 0, 'FIELD_MANUALS', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281664, 'Mogball-Local', 'Mogball-Local', 0, 0.000, 0.000, 0.000, 1, 40, 40, 0, 0, 0, 2, 3, 0x0000310300000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281665, 'Mog-Tablet', 'Mog-Tablet', 0, 0.000, 0.000, 0.000, 0, 40, 40, 0, 0, 0, 6, 3, 0x0000320000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281666, 'Planar_Rift', 'Planar Rift', 0, -242.000, 0.550, 405.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281667, 'Planar_Rift', 'Planar Rift', 0, 280.000, 4.599, 215.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281668, 'Planar_Rift', 'Planar Rift', 0, -335.000, 17.000, -365.000, 1, 40, 40, 0, 5, 100, 0, 3, 0x00006f0900000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281669, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -241.899, 0.550, 405.000, 1, 40, 40, 0, 4, 100, 2, 3, 0x0000c90300000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281670, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, 280.100, 4.599, 215.000, 1, 40, 40, 0, 4, 100, 2, 3, 0x0000c90300000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281671, 'Riftworn_Pyxis', 'Riftworn Pyxis', 0, -334.899, 17.000, -365.000, 1, 40, 40, 0, 4, 100, 2, 3, 0x0000c90300000000000000000000000000000000, 2, 'VOIDWATCH', 1);
INSERT IGNORE INTO `npc_list` VALUES(17281674, 'Survival_Guide', 'Survival Guide', 64, -239.500, 0.000, -404.000, 1, 50, 50, 0, 17, 32, 2, 3, 0x0000810900000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281675, 'blank', '', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 2, 2051, 0x0000340000000000000000000000000000000000, 0, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281676, 'Siren', 'Siren', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 6, 27, 0x0000930900000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281677, 'Siren', 'Siren', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 6, 27, 0x0000930900000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281678, 'csnpc', 'Volto Oscuro', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 6, 27, 0x010000018411e620e630e640e650006000700000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281679, 'Zeid', 'Zeid', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 6, 27, 0x00003e0300000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281680, 'csnpc', '', 0, 0.000, 0.000, 0.000, 0, 50, 50, 0, 0, 0, 6, 27, 0x0000f30a00000000000000000000000000000000, 32, NULL, 1);
INSERT IGNORE INTO `npc_list` VALUES(17281681, 'qm11', '???', 253, -409.553, 17.356, -380.626, 1, 50, 50, 0, 0, 0, 0, 3, 0x0000780900000000000000000000000000000000, 0, NULL, 1);

-- -----------------------------------
-- Yhoator Jungle NPC IDs are wrong --
-- -----------------------------------
DELETE FROM npc_list WHERE npcid BETWEEN 17285617 AND 17285713;
INSERT INTO `npc_list` VALUES (17285616,'qm1','???',0,546.093,0.134,-432.901,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285617,'NPC[1ee]','',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285618,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285619,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285620,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285621,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285622,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285623,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285624,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285625,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285626,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285627,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285628,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285629,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285630,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285631,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285632,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285633,'Treasure_Casket','Treasure Casket',0,0.000,0.000,0.000,7,40,40,0,4,4,2,3,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285634,'Treasure_Coffer','Treasure Coffer',224,-363.918,-0.500,-403.938,7,40,40,0,4,12,2,2051,0x0000C50300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285635,'Achieve_Master','Achieve Master',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,'SOA',0);
INSERT INTO `npc_list` VALUES (17285636,'Unity_Master','Unity Master',0,0.000,0.000,0.000,0,50,50,0,0,96,2,2051,0x0000340000000000000000000000000000000000,0,'SOA',0);
INSERT INTO `npc_list` VALUES (17285638,'NPC[2]','',0,0.000,0.000,0.000,0,50,50,0,0,0,2,1,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285639,'NPC[3]','',0,0.000,0.000,0.000,0,50,50,0,16,32,2,129,0x00002C0900000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285640,'NPC[4]','',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285641,'blank','     ',0,0.000,0.000,0.000,0,50,50,0,0,0,2,2051,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285642,'EFFECTER','EFFECTER',197,-30.873,-57.000,285.545,32769,40,40,0,0,0,6,2051,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285643,'Carbuncle','Carbuncle',197,-30.873,-57.000,285.545,32768,40,40,0,0,0,6,27,0x0000170300000000000000000000000000000000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285644,'Talking_Doll','Talking Doll',113,-252.162,-5.319,-307.011,0,40,40,0,0,0,6,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285645,'qm2','???',183,-94.073,-0.999,22.295,32775,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285646,'Telepoint','Telepoint',0,-280.942,0.597,-144.156,1,40,40,0,0,0,0,3,0x0000370000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285647,'Dimensional_Portal','Dimensional Portal',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285648,'Shattered_Telepoint','Shattered Telepoint',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285649,'Ilieumort_RK','Ilieumort, R.K.',33,200.254,0.000,-80.324,18,40,40,0,0,0,2,27,0x010001030C100C200C300C400250D26000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285650,'Mintoo_IM','Mintoo, I.M.',33,200.254,0.000,-80.324,8,40,40,0,0,0,2,27,0x0100020200100520053005400750BD60B6700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285651,'Etaj-Pohtaj_WW','Etaj-Pohtaj, W.W.',33,200.254,0.000,-80.324,1,40,40,0,0,0,2,27,0x0100000513101320053005400550046121700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285652,'Conquest_Banner','     ',14,198.253,0.000,-80.331,1,40,40,0,0,0,2,2051,0x00002E0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285653,'Conquest_Banner','     ',14,198.253,0.000,-80.331,1,40,40,0,0,0,2,2051,0x00002F0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285654,'Conquest_Banner','     ',14,198.253,0.000,-80.331,1,40,40,0,0,0,2,2051,0x0000300300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285655,'Conquest_Banner','     ',33,200.254,0.000,-80.324,1,40,40,0,0,0,2,2051,0x0000310300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285656,'Emila_RK','Emila, R.K.',241,-84.113,0.551,224.902,25,40,40,0,0,0,2,27,0x010000040D1006200C300C400C50CF6000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285657,'Guddal_IM','Guddal, I.M.',241,-84.113,0.551,224.902,18,40,40,0,0,0,2,27,0x010000080510022002300240025058601E700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285658,'Ghantata_WW','Ghantata, W.W.',241,-84.113,0.551,224.902,8,40,40,0,0,0,2,27,0x010000060F1018200630054007504E602D700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285659,'Mugha_Dovajaiho','Mugha Dovajaiho',99,203.844,-0.014,-80.618,7,40,40,0,1,0,2,27,0x01000F07121018200F3007401150006000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285660,'Conquest_Banner','     ',238,-84.793,0.476,223.829,1,40,40,0,0,0,2,2051,0x00002E0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285661,'Conquest_Banner','     ',238,-84.793,0.476,223.829,1,40,40,0,0,0,2,2051,0x00002F0300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285662,'Conquest_Banner','     ',238,-84.793,0.476,223.829,1,40,40,0,0,0,2,2051,0x0000300300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285663,'Conquest_Banner','     ',241,-84.113,0.551,224.902,1,40,40,0,0,0,2,2051,0x0000310300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285664,'NPC[1b]','',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285665,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285666,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285667,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285668,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285669,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285670,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285671,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285672,'Moogle','Moogle',0,0.000,0.000,0.000,0,40,40,0,0,0,2,4194307,0x0000520000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285673,'blank','     ',0,0.000,0.000,0.000,0,50,50,0,0,0,2,2051,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285674,'Logging_Point','Logging Point',0,-384.176,2.696,-16.097,32775,40,40,0,0,0,0,3,0x0000770900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285675,'Logging_Point','Logging Point',0,-341.286,4.744,16.386,32775,40,40,0,0,0,2,3,0x0000770900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285676,'Logging_Point','Logging Point',0,-373.440,2.991,64.697,32775,40,40,0,0,0,2,3,0x0000770900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285677,'Logging_Point','Logging Point',0,-22.719,7.038,-90.699,32775,40,40,0,0,0,2,3,0x0000770900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285678,'Logging_Point','Logging Point',0,-262.101,4.662,56.436,32775,40,40,0,0,0,2,3,0x0000770900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285679,'Logging_Point','Logging Point',0,-22.870,0.250,-44.010,32775,40,40,0,0,0,2,3,0x0000770900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285680,'Harvesting_Point','Harvesting Point',0,140.242,12.319,-108.471,32774,40,40,0,0,0,0,3,0x0000760900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285681,'Harvesting_Point','Harvesting Point',0,108.884,8.263,-579.216,32774,40,40,0,0,0,2,3,0x0000760900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285682,'Harvesting_Point','Harvesting Point',0,108.884,8.263,-579.216,32774,40,40,0,0,0,2,3,0x0000760900000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285683,'qm3','???',64,203.332,0.000,82.045,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285684,'Beastmens_Banner','Beastmen\'s Banner',96,366.014,-0.185,-394.801,1,40,40,0,0,0,0,3,0x0000310300000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285685,'Peddlestox','Peddlestox',39,-499.914,1.465,-109.039,18,40,40,0,0,0,2,27,0x0000F70100000000000000000000000000000000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285686,'Casket','Casket',0,0.000,0.000,0.000,0,40,40,0,0,0,6,1,0x0000C00300000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285687,'Casket','Casket',0,0.000,0.000,0.000,0,40,40,0,0,0,6,131,0x0000340000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285688,'qm5','???',0,80.520,-1.312,200.147,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285689,'qm6','???',0,198.650,-0.783,58.046,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285690,'qm7','???',0,205.932,-1.097,-174.886,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285691,'qm8','???',0,525.239,-1.224,-394.046,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285692,'qm9','???',0,240.341,-0.826,-402.532,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285693,'qm10','???',0,16.069,-0.860,-393.843,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285694,'qm11','???',0,-255.358,-0.558,-405.178,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285695,'qm4','???',0,-149.929,-1.148,56.761,1,40,40,0,0,0,0,131,0x0000340000000000000000000000000000000000,0,NULL,0);
INSERT INTO `npc_list` VALUES (17285696,'NPC[37]','',0,0.000,0.000,0.000,0,50,50,0,0,0,2,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285697,'Kiteh_Nanjyea','Kiteh Nanjyea',192,300.042,-3.999,-516.958,1,40,40,0,1,0,2,27,0x0100060700108720873087408750006000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285698,'blank','     ',157,-272.200,0.300,-148.800,7,40,40,0,0,0,0,2075,0x0000560000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285699,'Paurelde','Paurelde',155,-273.301,0.300,-149.800,1,40,40,0,1,0,0,27,0x01000804151010200A3015401850006000700000,32,NULL,1);
INSERT INTO `npc_list` VALUES (17285701,'Field_Manual','Field Manual',157,194.933,0.000,-83.997,18,40,40,0,8,32,0,3,0x0000F20800000000000000000000000000000000,32,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17285702,'Field_Manual','Field Manual',50,-280.777,0.267,-152.416,8,40,40,0,8,32,0,3,0x0000F20800000000000000000000000000000000,32,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17285703,'Field_Manual','Field Manual',193,-272.773,6.644,142.934,1,40,40,0,8,32,0,3,0x0000F20800000000000000000000000000000000,32,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17285704,'Field_Parchment','Field Parchment',224,-364.000,-0.500,-404.000,1,40,40,0,0,0,0,3,0x0000340000000000000000000000000000000000,0,'FIELD_MANUALS',1);
INSERT INTO `npc_list` VALUES (17285708,'Mogball-Local','Mogball-Local',0,0.000,0.000,0.000,1,40,40,0,0,0,2,3,0x0000310300000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285709,'Mog-Tablet','Mog-Tablet',0,0.000,0.000,0.000,0,40,40,0,0,0,6,3,0x0000320000000000000000000000000000000000,0,NULL,1);
INSERT INTO `npc_list` VALUES (17285712,'Survival_Guide','Survival Guide',160,197.000,0.001,-81.000,1,50,50,0,17,32,0,3,0x0000810900000000000000000000000000000000,0,'SURVIVAL_GUIDE',1);

-- --------------------------
-- Fixing animation issues --
-- --------------------------

UPDATE npc_list SET animation = "6" WHERE npcid = "17760449" AND polutils_name = "Laughing Lizard"; -- He will now fish
UPDATE npc_list SET animationsub = "0" WHERE npcid = "17481821" AND polutils_name = "Smoke Breath"; -- He won't hold imaginary buckets any longer
-- UPDATE npc_list SET animationsub = "0" WHERE npcid = "17481822" AND polutils_name = "Smoke Breath"; -- ONLY FOR TOPAZ-NEXT as IDs are slightly different
-- UPDATE npc_list SET animation = "8" WHERE npcid = "16806320" AND name = "_07h"; - NEEDS VERIFICATION - /*Fixing an issue where Miasmas in Attowha Chasm can get locked in a static state*/
-- UPDATE npc_list SET animation = "8" WHERE npcid = "16806322" AND name = "_07j"; - NEEDS VERIFICATION - /*Fixing an issue where Miasmas in Attowha Chasm can get locked in a static state*/


-- ----------------------------
-- NPCs with wrong positions --
-- ----------------------------

UPDATE npc_list SET pos_x = "-22.3693", pos_y = "2.0000", pos_z = "-15.6613" WHERE npcid = "17719425"; -- Adjusting Dahjal's position in South Sandoria (Traveling Troupe)


-- ----------------------------------------------------
-- Removing OOE Homepoints/adjusting their positions --
-- ----------------------------------------------------

-- Al'Taieu
UPDATE npc_list SET status = 2 WHERE npcid = "16912996" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "16912997" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "16912998" AND polutils_name = "Home Point #3";

-- Attohwa Chasm
UPDATE npc_list SET status = 2 WHERE npcid = "16806383" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "16806384" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "16806385" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "16806386" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "16806387" AND polutils_name = "Home Point #5";

-- Bastok Markets
UPDATE npc_list SET pos_x = "-293.7912", pos_y = "-10.0000", pos_z = "-102.5386" WHERE npcid = "17739860";
UPDATE npc_list SET status = 2 WHERE npcid = "17739861" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17739862" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "17739863" AND polutils_name = "Home Point #4";

-- Bastok Mines
UPDATE npc_list SET status = 2 WHERE npcid = "17735749" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17735750" AND polutils_name = "Home Point #3";

-- Bhaflau Thickets
UPDATE npc_list SET status = 2 WHERE npcid = "16990618" AND polutils_name = "Home Point #1";

-- Caedarva Mire
UPDATE npc_list SET status = 2 WHERE npcid = "17101351" AND polutils_name = "Home Point #1";

-- Cape Teriggan
UPDATE npc_list SET status = 2 WHERE npcid = "17240529" AND polutils_name = "Home Point #1";

-- Castle Zvahl Keep
UPDATE npc_list SET status = 2 WHERE npcid = "17441102" AND polutils_name = "Home Point #1";

-- Den of Rancor
UPDATE npc_list SET status = 2 WHERE npcid = "17433096" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "17433097" AND polutils_name = "Home Point #2";

-- Fei'Yin
UPDATE npc_list SET status = 2 WHERE npcid = "17613277" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "17613278" AND polutils_name = "Home Point #2";

-- Giddeus
UPDATE npc_list SET status = 2 WHERE npcid = "17371619" AND polutils_name = "Home Point #1";

-- Grand Palace of Hu'Xzoi
UPDATE npc_list SET status = 2 WHERE npcid = "16916940" AND polutils_name = "Home Point #1";

-- Ifrit's Cauldron
UPDATE npc_list SET status = 2 WHERE npcid = "17617275" AND polutils_name = "Home Point #1";

-- Lower Jeuno
UPDATE npc_list SET status = 2 WHERE npcid = "17780874" AND polutils_name = "Home Point #2";

-- Metalworks
UPDATE npc_list SET status = 2 WHERE npcid = "17748181" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "17748182" AND polutils_name = "Home Point #2";

-- Mhaura
UPDATE npc_list SET status = 2 WHERE npcid = "17797161" AND polutils_name = "Home Point #1";

-- Misareaux Coast
UPDATE npc_list SET status = 2 WHERE npcid = "16880010" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "16880011" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "16880012" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "16880013" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "16880014" AND polutils_name = "Home Point #5";

-- Mount Zhayolm
UPDATE npc_list SET status = 2 WHERE npcid = "17027625" AND polutils_name = "Home Point #1";

-- Newton Movalpolos
UPDATE npc_list SET status = 2 WHERE npcid = "16826628" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "16826629" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "16826630" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "16826631" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "16826632" AND polutils_name = "Home Point #5";

-- Norg
UPDATE npc_list SET status = 2 WHERE npcid = "17809461" AND polutils_name = "Home Point #2";

-- Northern San d'Oria
UPDATE npc_list SET status = 2 WHERE npcid = "17723505" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17723506" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "17723507" AND polutils_name = "Home Point #4";

-- Palborough Mines
UPDATE npc_list SET status = 2 WHERE npcid = "17363377" AND polutils_name = "Home Point #1";

-- Port Bastok
UPDATE npc_list SET pos_x = "53.6451", pos_y = "7.5000", pos_z = "-28.6819" WHERE npcid = "17743944";
UPDATE npc_list SET status = 2 WHERE npcid = "17743945" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17743946" AND polutils_name = "Home Point #3";

-- Port Jeuno
UPDATE npc_list SET status = 2 WHERE npcid = "17784890" AND polutils_name = "Home Point #2";

-- Port San d'Oria
UPDATE npc_list SET pos_x = "-66.0769", pos_y = "4.0000", pos_z = "-104.9475" WHERE npcid = "17727574";
UPDATE npc_list SET status = 2 WHERE npcid = "17727575" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17727576" AND polutils_name = "Home Point #3";

-- Port Windurst
UPDATE npc_list SET pos_x = "-67.9796", pos_y = "-4.0000", pos_z = "110.6745" WHERE npcid = "17760396";
UPDATE npc_list SET status = 2 WHERE npcid = "17760397" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17760398" AND polutils_name = "Home Point #3";

-- Pso'Xja
UPDATE npc_list SET status = 2 WHERE npcid = "16814567" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "16814568" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "16814569" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "16814570" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "16814571" AND polutils_name = "Home Point #5";

-- Qufim Island
UPDATE npc_list SET status = 2 WHERE npcid = "17293826" AND polutils_name = "Home Point #1";

-- Quicksand Caves
UPDATE npc_list SET status = 2 WHERE npcid = "17629777" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "17629778" AND polutils_name = "Home Point #2";

-- Rabao
UPDATE npc_list SET status = 2 WHERE npcid = "17788956" AND polutils_name = "Home Point #2";

-- Riverne - Site #A01
UPDATE npc_list SET status = 2 WHERE npcid = "16900399" AND polutils_name = "Home Point #1";

-- Riverne - Site #B01
UPDATE npc_list SET status = 2 WHERE npcid = "16896250" AND polutils_name = "Home Point #1";

-- Ru'Aun Gardens
UPDATE npc_list SET status = 2 WHERE npcid = "17310117" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "17310118" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17310119" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "17310120" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "17310121" AND polutils_name = "Home Point #5";

-- Ru'Lude Gardens
UPDATE npc_list SET status = 2 WHERE npcid = "17772800" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "17772801" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17772802" AND polutils_name = "Home Point #3";

-- Southern San d'Oria
UPDATE npc_list SET status = 2 WHERE npcid = "17719432" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17719433" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "17719434" AND polutils_name = "Home Point #4";

-- Tavnazian Safehold
UPDATE npc_list SET status = 2 WHERE npcid = "x" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "x" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "x" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "x" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "x" AND polutils_name = "Home Point #5";

-- The Boyahda Tree
UPDATE npc_list SET status = 2 WHERE npcid = "17404416" AND polutils_name = "Home Point #1";

-- The Garden of Ru'Hmet
UPDATE npc_list SET status = 2 WHERE npcid = "16921138" AND polutils_name = "Home Point #1";

-- The Shrine of Ru'Avitau
UPDATE npc_list SET status = 2 WHERE npcid = "17506833" AND polutils_name = "Home Point #1";

-- Toraimarai Canal
UPDATE npc_list SET status = 2 WHERE npcid = "17469856" AND polutils_name = "Home Point #1";

-- Uleguerand Range
UPDATE npc_list SET status = 2 WHERE npcid = "16798151" AND polutils_name = "Home Point #1";
UPDATE npc_list SET status = 2 WHERE npcid = "16798152" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "16798153" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "16798154" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "16798155" AND polutils_name = "Home Point #5";

-- Upper Jeuno
UPDATE npc_list SET status = 2 WHERE npcid = "17776728" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17776729" AND polutils_name = "Home Point #3";

-- Windurst Waters
UPDATE npc_list SET status = 2 WHERE npcid = "17752217" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17752218" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "17752219" AND polutils_name = "Home Point #4";

-- Windurst Woods
UPDATE npc_list SET status = 2 WHERE npcid = "17764537" AND polutils_name = "Home Point #2";
UPDATE npc_list SET status = 2 WHERE npcid = "17764538" AND polutils_name = "Home Point #3";
UPDATE npc_list SET status = 2 WHERE npcid = "17764539" AND polutils_name = "Home Point #4";
UPDATE npc_list SET status = 2 WHERE npcid = "17764540" AND polutils_name = "Home Point #5";

-- -----------------------------------
-- Remove unused NPCs from WideScan --
-- -----------------------------------

UPDATE npc_list SET widescan = 0 WHERE polutils_name = "WALLMASTER";
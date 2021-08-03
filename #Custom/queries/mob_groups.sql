-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Please ANNOTATE WELL for a clear understanding of what the query is adding/changing/fixing.     --
--                           Overly detaling your query is NOT needed.                             --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
--        DO NOT RUN QUERIES ON THE LIVE SERVER BEFORE TESTING IN A ISOLATED DEV ENVIRONMENT       --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------


-- --------------------------------------------
-- Normalizing spawn times in starting areas --
-- --------------------------------------------

UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 100 AND respawntime BETWEEN 2 AND 450; -- (West Ronfaure) -- Was 210
UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 101 AND respawntime BETWEEN 2 AND 450; -- (East Ronfaure) -- Was 210
UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 106 AND respawntime BETWEEN 2 AND 450; -- (North_Gustaberg) -- Was 210
UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 107 AND respawntime BETWEEN 2 AND 450; -- (South_Gustaberg) -- Was 210
UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 115 AND respawntime BETWEEN 2 AND 450; -- (West_Sarutabaruta) -- Was 210
UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 116 AND respawntime BETWEEN 2 AND 450; -- (East_Sarutabaruta) -- Was 210
UPDATE mob_groups SET respawntime = 300 WHERE zoneid = 172 AND respawntime BETWEEN 2 AND 450; -- (Zeruhn_Mines) -- Was 210


-- ------------------------------------------
-- Bug fixes  --
-- ------------------------------------------

-- Bohyada Tree
UPDATE mob_groups SET dropid = "3997" WHERE name = "Old_Goobbue"; -- Old Gobbue needs its own drop list
UPDATE mob_groups SET minLevel = "75", maxLevel = "78" WHERE groupid = 26 AND zoneid = 153 AND name = "Skimmer"; -- Note these are called Snaggletooth_Peapuk in the DATs.

-- Castle Oztroja
UPDATE mob_groups SET HP = 2500 WHERE name = "Odontotyrannus" AND groupid = 41; -- Adjusted HP values for PLD AF2

-- Davoi
UPDATE mob_groups SET HP = 7500 WHERE name = "One-eyed_Gwajboj" and zoneid = 149; --  Adjusted HP values for PLD AF3
UPDATE mob_groups SET HP = 6000 WHERE name = "Three-eyed_Prozpuz" and zoneid = 149; --  Adjusted HP values for PLD AF3

-- Den of Rancor
UPDATE mob_groups SET respawntime = "0", spawntype = "32" WHERE name = "Sozu_Bliberry"; -- Changing NM to lottery pop from Tonberry Imprecator

-- Lower Delkfutts Tower
UPDATE mob_groups SET dropid = "993" WHERE name = "Gigas_Sculptor"; -- Delkfutt Chest Key ONLY - 3% drop rate (had no drop table)
UPDATE mob_groups SET dropid = "993" WHERE name = "Gigas_Punisher"; -- Delkfutt Chest Key ONLY - 3% drop rate (had no drop table)
UPDATE mob_groups SET dropid = "993" WHERE name = "Gigas_Hallwatcher"; -- Delkfutt Chest Key ONLY - 3% drop rate (had no drop table)

-- North Gustaberg
UPDATE mob_groups SET dropid = "1958" WHERE name = "Ornery_Sheep" and zoneid = 106; -- North Gustaberg Ornery Sheep had no drop table

-- Sacrarium
UPDATE mob_groups SET HP = 6000 WHERE name = "Old_Professor_Mariselle"; -- Increase HP by 1000 due to lack of teleport
UPDATE mob_groups SET HP = 1500 WHERE name = "Mariselles_Pupil"; -- Increase HP by 500 due to lack of teleport

-- Sea Serpent Grotto
UPDATE mob_groups SET respawntime = "0", spawntype = "32" WHERE name = "Charybdis" and groupid = "51";

-- Temple of Uggalepih
UPDATE mob_groups SET respawntime = "0", spawntype = "32" WHERE name = "Sozu_Rogberry"; -- Convert from force pop to lotto pop.

-- Xarcabard
UPDATE mob_groups SET respawntime = "600" WHERE zoneid = 112 AND name = "Shadow_Dragon"; -- Respawn time should be 10 min and not 30 min
UPDATE mob_groups SET dropid = "885" WHERE zoneid = 24 AND name = "Fomor_Ranger"; -- Ranger was using a Sacrarium drop ID, droping keys and subligar.


-- ------------------------------------------
-- Adding missing NMs or whole mob groups  --
-- ------------------------------------------

-- Kuftal Tunnel
INSERT IGNORE INTO `mob_groups` VALUES (20,2314,174,'Ladon',300,0,1477,0,0,80,82,0); -- Ladon mobs were missing from Kuftal Tunnel

-- Quicksand Caves
INSERT IGNORE INTO `mob_groups` VALUES (39, 6186, 208, 'Sabotender_Bailaor', 960, 0, 3160, 0, 0, 52, 59, 0);
INSERT IGNORE INTO `mob_groups` VALUES (40, 6187, 208, 'Sabotender_Bailarin', 0, 32, 3161, 0, 0, 59, 59, 0);

-- Zeruhn Mines
INSERT IGNORE INTO `mob_groups` VALUES (8,6031,172,'Giant_Amoeba',0,32,3999,0,0,6,8,0); -- Giant Amoeba NM - Query needed for the mob to spawn

-- ---------------------------------------------------------------
-- Adjusting mob stats for a more accurate TOAU ERA experience  --
-- ---------------------------------------------------------------


-- Bibiki Bay
UPDATE mob_groups SET HP = "4400" WHERE zoneid = 4 AND name = "Serra"; -- Adding proper total HPs (https://www.youtube.com/watch?v=YY19p_Ll0C0)
UPDATE mob_groups SET HP = "2500" WHERE zoneid = 4 AND name = "Intulo"; -- Very rough guess on its total HP... https://ffxi.allakhazam.com/db/bestiary.html?fmob=2901&p=1#comments

-- Behemoth's Dominion
UPDATE mob_groups SET HP = "4000" WHERE zoneid = 127 AND name = "Picklix_Longindex"; -- Adding proper total HPs (https://www.youtube.com/watch?v=QbxXkacJ7X0)
UPDATE mob_groups SET HP = "4000" WHERE zoneid = 127 AND name = "Moxnix_Nightgoggle"; -- Adding proper total HPs (https://www.youtube.com/watch?v=QbxXkacJ7X0)
UPDATE mob_groups SET HP = "4000" WHERE zoneid = 127 AND name = "Doglix_Muttsnout"; -- Adding proper total HPs (https://www.youtube.com/watch?v=QbxXkacJ7X0)

-- Davoi
UPDATE mob_groups SET HP = "4000" WHERE zoneid = 149 AND name = "Barakbok"; -- Adding proper total HPs (https://www.youtube.com/watch?v=yoo5J1oWQFk)
UPDATE mob_groups SET HP = "6800" WHERE zoneid = 149 AND name = "Gavotvut"; -- Adding proper total HPs (https://www.youtube.com/watch?v=yoo5J1oWQFk)
UPDATE mob_groups SET HP = "10500" WHERE zoneid = 149 AND name = "Bilopdop"; -- Adding proper total HPs (https://www.youtube.com/watch?v=JUpOCW6RprI)
UPDATE mob_groups SET HP = "6000" WHERE zoneid = 149 AND name = "Deloknok"; -- Adding proper total HPs (https://www.youtube.com/watch?v=JUpOCW6RprI)
UPDATE mob_groups SET HP = "3500" WHERE name = "Poisonhand_Gnadgad" and zoneid = "149"; -- Correct Poionshand from 1200hp to 3500hp


UPDATE mob_groups SET HP = "7800", minLevel = 55, maxLevel = 60 WHERE zoneid = 149 AND name = "Purpleflash_Brukdok"; -- Purpleflash Brukdok

-- FeiYin
UPDATE mob_groups SET HP = "40000" WHERE zoneid = 204 AND name = "Capricious_Cassie"; -- Adding proper total HPs (https://www.youtube.com/watch?v=XF1SoH3oirM)
UPDATE mob_groups SET HP = "7000" WHERE zoneid = 204 AND name = "Miser_Murphy"; -- Miser Murphy

-- Garlaige Citadel
UPDATE mob_groups SET HP = "8500" WHERE poolid = 1831 AND name = "Guardian_Statue"; -- HP correction

-- Ghelsba Outpost
UPDATE mob_groups SET HP = "2000", minLevel = "42", maxLevel = "42" WHERE zoneid = 140 AND name = "Cyranuce_M_Cutauleon"; -- Boosting DRG BCNM fight (https://www.youtube.com/watch?v=DR8MG-hftXY)
UPDATE mob_groups SET HP = "1500" WHERE zoneid = 140 AND name = "Kilioa"; -- Adjusting HPs(https://www.youtube.com/watch?v=DR8MG-hftXY)
UPDATE mob_groups SET HP = "1300" WHERE zoneid = 140 AND name = "Kalamainu"; -- Adjusting HPs(https://www.youtube.com/watch?v=DR8MG-hftXY)
UPDATE mob_groups SET HP = 750 WHERE NAME = 'Furies'; -- https://www.youtube.com/watch?v=185yQJFpfBI
UPDATE mob_groups SET HP = 1100 WHERE NAME = 'Colo-colo'; -- https://www.youtube.com/watch?v=2ay1DUzlmYs

-- Gusgen Mines
UPDATE mob_groups SET HP = "6000" WHERE zoneid = 196 AND name = "Wandering_Ghost"; -- Per FFXIciclopedia this mob should have 6k HP.

-- Horlais Peak
UPDATE mob_groups SET HP = "1500" WHERE zoneid = 139 AND name = "Pilwiz"; -- Adjusting HPs(https://www.youtube.com/watch?v=50GMKNSHqmQ)
UPDATE mob_groups SET HP = "1300" WHERE zoneid = 139 AND name = "Bisan"; -- Adjusting HPs(https://www.youtube.com/watch?v=50GMKNSHqmQ)

-- Jade Sepulcher
UPDATE mob_groups SET HP = "2300" WHERE groupid = "2270" AND zoneid = "67"; -- Raubahn in Jade Sepulcher
UPDATE mob_groups SET HP = "2300" WHERE groupid = "1980" AND zoneid = "57"; -- Qultada in Jade Sepulcher

-- Jugner Forest
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 104 AND name = "Meteormauler_Zhagtegg"; -- We script its spawn

-- Kuftal Tunnel
UPDATE mob_groups SET HP = "9000" WHERE zoneid = 174 AND name = "Phantom_Worm"; -- Adding proper total HPs (https://www.youtube.com/watch?v=n0IwgZc7Nx8)

-- Konschtat Highlands
UPDATE mob_groups SET HP = "1600", minLevel = "36", maxLevel = "36" WHERE zoneid = 108 AND name = "Forger"; -- Boosting SAM quest NMs

-- Korroloka Tunnel
UPDATE mob_groups SET HP = "1000", minLevel = "33", maxLevel = "33" WHERE zoneid = 173 AND name = "Korroloka_Leech"; -- Boosting NIN quest NMs

-- Kuftal Tunnel
UPDATE mob_groups SET HP = "9000" WHERE zoneid = 174 AND name = "Phantom_Worm"; -- Adding proper total HPs (https://www.youtube.com/watch?v=n0IwgZc7Nx8)

-- Palborough Mines
UPDATE mob_groups SET HP = "850", spawntype = "128" WHERE zoneid = 143 AND name = "No_Mho_Crimsonarmor"; -- Based on this video he should have around 850 HP (https://www.youtube.com/watch?v=z3g1b2BuJuU). His spawn should also be scripted.
UPDATE mob_groups SET HP = "5500" WHERE zoneid = 143 AND name = "Ni_Ghu_Nestfender"; -- Based on this video he should have around 850 HP (https://www.youtube.com/watch?v=j8XKcQWmsYU)

-- Passhow Marshlands
UPDATE mob_groups SET HP = "2700" WHERE zoneid = 109 AND name = "Bo_Who_Warmonger"; -- Based on this video he should have around 2700 HP (https://www.youtube.com/watch?v=CV7WNt6vaWU)

-- Phanauet Channel
UPDATE mob_groups SET HP = "4000" WHERE zoneid = 1 AND name = "Vodyanoi"; -- Adding proper total HPs (https://www.youtube.com/watch?v=QrlYY1Fzt7g)

-- Phomiuna Aqueducts
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 27 AND name = "Eba"; -- We script its spawn
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 27 AND name = "Mahisha"; -- We script its spawn
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 27 AND name = "Tres_Duendes"; -- We script its spawn

-- Riverne - Site #A01
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 30 AND name = "Carmine_Dobsonfly"; -- We script their spawn

-- Ro'Maeve
UPDATE mob_groups SET HP = "9600" WHERE zoneid = 122 AND name = "Eldhrimnir"; -- Adding proper total HPs

-- Sea Serpent Grotto
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 176 AND name = "Ocean_Sahagin"; -- We script their spawn

-- South Gustaberg
UPDATE mob_groups SET HP = "300" WHERE zoneid = 107 AND name = "Leaping_Lizzy"; -- Adding proper total HPs https://www.youtube.com/watch?v=i_gg6C9w_bU

-- The Sanctuary of ZiTah
UPDATE mob_groups SET HP = "2000"  WHERE zoneid = 121 AND name = "Guardian_Treant"; -- Boosting SAM quest NMs

-- Uleguerand Range
UPDATE mob_groups SET HP = "12000" WHERE zoneid = 5 AND name = "Snow_Maiden"; -- Adding proper total HPs (https://www.youtube.com/watch?v=o5rSVbEncFs)
UPDATE mob_groups SET HP = "15000", dropid = "3998" WHERE zoneid = 5 AND name = "Father_Frost"; -- Not really proper source for this, but giving him more HP than its PH (Snow Maiden). Also adding custom droplist so we can set different drop rate for Purgatory Collar.
UPDATE mob_groups SET HP = "20000" WHERE zoneid = 5 AND name = "Mountain_Worm_NM"; -- Adding proper total HPs (https://www.youtube.com/watch?v=TKkd7HBE8fk)
UPDATE mob_groups SET HP = "9000" WHERE zoneid = 5 AND name = "Bonnacon"; -- Adding proper total HPs (https://www.youtube.com/watch?v=5ssAuE-bFMs)
UPDATE mob_groups SET HP = "8000" WHERE zoneid = 5 AND name = "White_Coney"; -- Adding proper total HPs (https://www.youtube.com/watch?v=9I8SfbyPduM)
UPDATE mob_groups SET HP = "8000" WHERE zoneid = 5 AND name = "Black_Coney"; -- Adding proper total HPs (https://www.youtube.com/watch?v=tXUrBewXA8A)

-- Valkurm Dunes
UPDATE mob_groups SET HP = "1150" WHERE zoneid = 103 AND name = "Valkurm_Emperor"; -- Adding proper total HPs https://www.youtube.com/watch?v=GeEaLHzJT7I

-- SAM AF2
UPDATE mob_groups SET HP = "2500" WHERE zoneid = 2984 and name = "Onryo";
UPDATE mob_groups SET HP = "2500" WHERE zoneid = 1077 and name = "Doman";

-- Yuhtunga Jungle
UPDATE mob_groups SET spawntype = "128" WHERE zoneid = 123 AND name = "Meww_the_Turtlerider"; -- We script its spawn

-- CoP 3-5 Diabolos
UPDATE mob_groups SET minLevel = 54, maxLevel = 54 WHERE poolid = 1027 and name = "Diabolos";

-- Balga's Dais
	-- Divine Punishers
UPDATE mob_groups SET HP = "5500" WHERE zoneid = 146 and name = "Aa_Nawu_the_Thunderblade"; -- https://ffxiclopedia.fandom.com/wiki/Divine_Punishers
UPDATE mob_groups SET HP = "4500" WHERE zoneid = 146 and name = "Cuu_Doko_the_Blizzard";
UPDATE mob_groups SET HP = "4500" WHERE zoneid = 146 and name = "Yoo_Mihi_the_Haze";
UPDATE mob_groups SET HP = "5500" WHERE zoneid = 146 and name = "Voo_Tolu_the_Ghostfist";
UPDATE mob_groups SET HP = "5000" WHERE zoneid = 146 and name = "Gii_Jaha_the_Raucous";
UPDATE mob_groups SET HP = "5000" WHERE zoneid = 146 and name = "Zuu_Xowu_the_Darksmoke";

-- Waughroon Shrine
	-- SAM AF3
UPDATE mob_groups SET HP = "3000" WHERE zoneid = 144 and name = "Onki"; -- HP Adjustment
UPDATE mob_groups SET HP = "7500" WHERE zoneid = 144 and name = "Rasetsu"; -- HP Adjustment
UPDATE mob_groups SET HP = "6000" WHERE zoneid = 144 and name = "Gaki"; -- HP Adjustment

-- BLM AF 1 & 3
UPDATE mob_groups SET hp = "3200" WHERE name = "chaos_elemental" AND zoneid = "112"; -- Set proper HP for BLM AF Weapon mob.
UPDATE mob_groups SET hp = "3000" WHERE name = "magic_sludge" AND zoneid = "169"; -- Set proper HP for BLM AF weapon mob.

-- WHM AF 1 & 3
UPDATE mob_groups SET hp = "6800", minlevel = "60", maxlevel = "65" WHERE name = "marchelute" and zoneid = "103"; -- Set proper HP & levels for WHM AF weapon mob.
UPDATE mob_groups SET hp = "16500", minlevel = "65", maxlevel = "65" WHERE name = "altedour_i_tavnazia" and zoneid = "204"; -- Set proper HP & levels for WHM AF3 mob.

-- THF AF 2
UPDATE mob_groups SET hp = "5500" WHERE name = "climbpix_highrise" and zoneid = "120"; -- Set proper HP for THF AF2 NM1
UPDATE mob_groups SET hp = "8300" WHERE name = "gambilox_wanderling" and zoneid = "106"; -- Set proper HP for THF AF2 NM2

-- PLD AF 2 & 3
UPDATE mob_groups SET hp = "2500" WHERE name = "odontotyrannus" and zoneid = "151"; -- Set proper HP for PLD AF2 NM
UPDATE mob_groups SET hp = "6000" WHERE name = "three-eyed_prozpuz" and zoneid = "149"; -- Set proper HP for PLD AF3 NM1
UPDATE mob_groups SET hp = "7500" WHERE name = "one-eyed_gwajboj" and zoneid = "149"; -- Set proper HP for PLD AF3 NM2

-- DRK AF 1, 2, 3
UPDATE mob_groups SET hp = "3750" WHERE name = "vaa_huja_the_erudite" and zoneid = "145"; -- Set proper HP for DRK AF1 NM
UPDATE mob_groups SET hp = "7600" WHERE name = "gerwitzs_axe" and zoneid = "193"; -- Set proper HP for DRK AF2 NM1
UPDATE mob_groups SET hp = "5000" WHERE name = "gerwitzs_sword" and zoneid = "193"; -- Set proper HP for DRK AF2 NM2
UPDATE mob_groups SET hp = "5000" WHERE name = "gerwitzs_soul" and zoneid = "193"; -- Set proper HP for DRK AF2 NM3
UPDATE mob_groups SET hp = "8000" WHERE name = "gerwitzs_scythe" and zoneid = "157"; -- Set proper HP for DRK AF3 NM1
UPDATE mob_groups SET hp = "2500" WHERE name = "scythe_victim" and zoneid = "157"; -- Set proper HP for DRK AF3 NM2

-- BST AF 2
UPDATE mob_groups SET hp = "6750" WHERE name = "dabotzs_ghost" and zoneid = "204"; -- Set proper HP for BST AF2 NM

-- BRD AF 1,2,3

UPDATE mob_groups SET hp = "3200" WHERE name = "tros" and zoneid = "166"; -- Set proper HP for BRD AF1 NM
UPDATE mob_groups SET hp = "8000" WHERE name = "yum_kimil" and zoneid = "195"; -- Set proper HP for BRD AF2 NM1
UPDATE mob_groups SET hp = "5800" WHERE name = "owl_guardian" and zoneid = "195"; -- Set proper HP for BRD AF2 NM2
UPDATE mob_groups SET hp = "6000" WHERE name = "dog_guardian" and zoneid = "195"; -- Set proper HP for BRD AF2 NM3
UPDATE mob_groups SET hp = "4000" WHERE name = "bugaboo" and zoneid = "150"; -- Set proper HP for BRD AF3 NM

-- RNG AF 3
UPDATE mob_groups SET hp = "22000" WHERE name = "koenigstiger" and zoneid = "112"; -- Set proper HP for RNG AF3 NM

-- NIN AF 1,3
UPDATE mob_groups SET hp = "2800" WHERE name = "tsuchigumo" and zoneid = "114"; -- Set proper HP for NIN AF1 NM1 & 2
UPDATE mob_groups SET hp = "2300" WHERE name = "tsuchigumo" and zoneid = "220"; -- Set proper HP for NIN AF2 NM
UPDATE mob_groups SET hp = "7500" WHERE name = "kappa_akuso" and zoneid = "124"; -- Set proper HP for NIN AF3 NM1
UPDATE mob_groups SET hp = "5200" WHERE name = "kappa_bonze" and zoneid = "124"; -- Set proper HP for NIN AF3 NM2
UPDATE mob_groups SET hp = "6300" WHERE name = "kappa_biwa" and zoneid = "124"; -- Set proper HP for NIN AF3 NM3

-- DRG AF 1,2
UPDATE mob_groups SET hp = "5000" WHERE name = "decurio_i-iii" and zoneid = "114"; -- Set proper HP for DRG AF1 NM
UPDATE mob_groups SET hp = "6200", minlevel = "52", maxlevel= "52" WHERE name = "sturmtiger" and zoneid = "105"; -- Set proper HP and level for DRG AF2 NM

-- BLU AF
UPDATE mob_groups SET hp = "4000", minlevel = "60", maxlevel ="60" WHERE name = "immortal_flan"; -- Set proper HP and levelfor BLU AF2 NM
UPDATE mob_groups SET hp = "8600", mp = "10000", minlevel = "65", maxlevel ="65" WHERE name = "nepionic_soulflayer" and zoneid = "72"; -- Set proper HP, MP and level for BLU AF3 NM


-- COR AF
UPDATE mob_groups SET hp = "5800" WHERE name = "gowam" and zoneid = "60"; -- Set proper HP for COR AF3 NM1
UPDATE mob_groups SET hp = "5000" WHERE name = "yazquhl" and zoneid = "60"; -- Set proper HP for COR AF3 NM2

-- ------------------------------------------------
-- Custom changes to improve leveling experience --
-- ------------------------------------------------

-- Yuhtunga Jungle
UPDATE mob_groups SET minLevel = "31"  WHERE zoneid = 123 AND name = "Yuhtunga_Mandragora"; -- Higher min level for Mandragoras for more steady xp-gains at level 25


-- ---------------------------------------------
-- Adjusting spawntimes in Dungeon like areas --
-- ---------------------------------------------

-- Dangruf Wadi
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Snipper";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Stone_Eater";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Rock_Lizard";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Thug";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Weaver";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Fisher";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Ambusher";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Tinkerer";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Butcher";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Mugger";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Leecher";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Goblin_Gambler";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Hoarder_Hare";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Steam_Lizard";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Wadi_Crab";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 191 AND respawntime = 300 AND name = "Wadi_Hare";

-- Garlaige_Citadel
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 200 AND respawntime = 300 AND name = "Fallen_Mage";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 200 AND respawntime = 300 AND name = "Fallen_Major";

-- Gusgen_Mines
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 196 AND respawntime = 300 AND name = "Wendigo";

-- Inner_Horutoto_Ruins
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 192 AND respawntime = 300 AND name = "Wendigo";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 192 AND respawntime = 300 AND name = "Boggart";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 192 AND respawntime = 300 AND name = "Skinnymajinx";

-- Maze_of_Shakhrami
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 198 AND respawntime = 300 AND name = "Wendigo";

-- Ordelles_Caves
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 193 AND respawntime = 300 AND name = "Vorpal_Bunny";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 193 AND respawntime = 300 AND name = "Slash_Pine";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 193 AND respawntime = 300 AND name = "Stroper";
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 193 AND respawntime = 300 AND name = "Napalm";
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 193 AND respawntime = 300 AND name = "Stroper_Chyme";

-- Outer_Horutoto_Ruins
UPDATE mob_groups SET respawntime = "600"  WHERE zoneid = 194 AND respawntime = 300 AND name = "Balloon";


-- ---------------------------------------------------------------------------
-- Adjusting OOE mob levels to ERA values (also custom non-ERA adjustments) --
-- ---------------------------------------------------------------------------

-- Arrapago Reef
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "72", maxLevel = "73" WHERE g.zoneid = 54 AND s.mobname = "Dweomershell";

-- Bostaunieux Oubliette
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "55", maxLevel = "59" WHERE g.zoneid = 167 AND s.mobname = "Blind_Bat";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "64", maxLevel = "66" WHERE g.zoneid = 167 AND s.mobname = "Dabilla";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "58", maxLevel = "62" WHERE g.zoneid = 167 AND s.mobname = "Panna_Cotta";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "68", maxLevel = "70" WHERE g.zoneid = 167 AND s.mobname = "Nachtmahr";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "69", maxLevel = "74" WHERE g.zoneid = 167 AND s.mobname = "Wurdalak";

-- Bibiki Bay
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "76", maxLevel = "79" WHERE g.zoneid = 4 AND s.mobname = "hobgoblin_toreador";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "76", maxLevel = "79" WHERE g.zoneid = 4 AND s.mobname = "hobgoblin_alastor";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "76", maxLevel = "79" WHERE g.zoneid = 4 AND s.mobname = "hobgoblin_physician";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "78", maxLevel = "80" WHERE g.zoneid = 4 AND s.mobname = "camelopard";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "73", maxLevel = "76" WHERE g.zoneid = 4 AND s.mobname = "bight_rarab";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "76", maxLevel = "78" WHERE g.zoneid = 4 AND s.mobname = "hypnos_eft";

-- Boyahda tree
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "72", maxLevel = "75" WHERE g.zoneid = 153 AND s.mobname = "Mourning_Crawler";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "75", maxLevel = "78" WHERE g.zoneid = 153 AND s.mobname = "Snaggletooth_Peapuk";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "73", maxLevel = "76" WHERE g.zoneid = 153 AND s.mobname = "Viseclaw";

-- Crawlers' Nest
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "50", maxLevel = "53" WHERE g.zoneid = 197 AND s.mobname = "Dancing_Jewel";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "47", maxLevel = "49" WHERE g.zoneid = 197 AND s.mobname = "King_Crawler";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "51", maxLevel = "54" WHERE g.zoneid = 197 AND s.mobname = "Olid_Funguar";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "55", maxLevel = "57" WHERE g.zoneid = 197 AND s.mobname = "Vespo";

-- Dangruf_Wadi
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "21", maxLevel = "23" WHERE g.zoneid = 191 AND s.mobname = "Couloir_Leech";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "16", maxLevel = "20" WHERE g.zoneid = 191 AND s.mobname = "Fume_Lizard";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "9", maxLevel = "12" WHERE g.zoneid = 191 AND s.mobname = "Witchetty_Grub";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "11", maxLevel = "14" WHERE g.zoneid = 191 AND s.mobname = "Prim_Pika";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "16", maxLevel = "20" WHERE g.zoneid = 191 AND s.mobname = "Trimmer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "11", maxLevel = "14" WHERE g.zoneid = 191 AND s.mobname = "Natty_Gibbon";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "12", maxLevel = "16" WHERE g.zoneid = 191 AND s.mobname = "Goblin_Headsman";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "21", maxLevel = "23" WHERE g.zoneid = 191 AND s.mobname = "Goblin_Conjurer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "12", maxLevel = "16" WHERE g.zoneid = 191 AND s.mobname = "Goblin_Bladesmith";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "21", maxLevel = "23" WHERE g.zoneid = 191 AND s.mobname = "Goblin_Bushwhacker";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "12", maxLevel = "16" WHERE g.zoneid = 191 AND s.mobname = "Goblin_Brigand";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "21", maxLevel = "23" WHERE g.zoneid = 191 AND s.mobname = "Goblin_Healer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "16", maxLevel = "20" WHERE g.zoneid = 191 AND s.mobname = "Fire_Elemental";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "7", maxLevel = "9" WHERE g.zoneid = 191 AND s.mobname = "Wadi_Crab";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "11", maxLevel = "14" WHERE g.zoneid = 191 AND s.mobname = "Wadi_Hare";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "6", maxLevel = "8" WHERE g.zoneid = 191 AND s.mobname = "Hoarder_Hare";

-- FeiYin
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "40", maxLevel = "42" WHERE g.zoneid = 204 AND s.mobname = "Balayang";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 204 AND s.mobname = "Sentient_Carafe";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "40", maxLevel = "42" WHERE g.zoneid = 204 AND s.mobname = "Wekufe";

-- Garlaige Citadel
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "56", maxLevel = "58" WHERE g.zoneid = 200 AND s.mobname = "Warden_Beetle";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "59", maxLevel = "62" WHERE g.zoneid = 200 AND s.mobname = "Kaboom";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "55" WHERE g.zoneid = 200 AND s.mobname = "Fortalice_Bats";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "54", maxLevel = "56" WHERE g.zoneid = 200 AND s.mobname = "Donjon_Bat";

-- Gusgen Mines
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "33", maxLevel = "36" WHERE g.zoneid = 196 AND s.mobname = "Accursed_Soldier";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "33", maxLevel = "36" WHERE g.zoneid = 196 AND s.mobname = "Accursed_Sorcerer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "27", maxLevel = "30" WHERE g.zoneid = 196 AND s.mobname = "Madfly";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "23", maxLevel = "26" WHERE g.zoneid = 196 AND s.mobname = "Rockmill";

 -- Inner Horutoto Ruins
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "17", maxLevel = "20" WHERE g.zoneid = 192 AND s.mobname = "Covin_Bat";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "11", maxLevel = "16" WHERE g.zoneid = 192 AND s.mobname = "Deathwatch_Beetle";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "20", maxLevel = "23" WHERE g.zoneid = 192 AND s.mobname = "Goblin_Flesher";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "20", maxLevel = "23" WHERE g.zoneid = 192 AND s.mobname = "Goblin_Lurcher";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "20", maxLevel = "23" WHERE g.zoneid = 192 AND s.mobname = "Goblin_Metallurgist";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "20", maxLevel = "23" WHERE g.zoneid = 192 AND s.mobname = "Goblin_Trailblazer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "25", maxLevel = "28" WHERE g.zoneid = 192 AND s.mobname = "Skinnymalinks";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "25", maxLevel = "28" WHERE g.zoneid = 192 AND s.mobname = "Skinnymajinx";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "12", maxLevel = "15" WHERE g.zoneid = 192 AND s.mobname = "Troika_Bats";

-- King Ranperres Tomb
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "62", maxLevel = "64" WHERE g.zoneid = 190 AND s.mobname = "Ogre_Bat";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "58", maxLevel = "60" WHERE g.zoneid = 190 AND s.mobname = "Ossuary_Worm";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "64", maxLevel = "66" WHERE g.zoneid = 190 AND s.mobname = "Bonnet_Beetle";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "63", maxLevel = "65" WHERE g.zoneid = 190 AND s.mobname = "Barrow_Scorpion";

-- Korroloka Tunnel
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "28", maxLevel = "31" WHERE g.zoneid = 173 AND s.mobname = "Spool_Leech";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "29", maxLevel = "32" WHERE g.zoneid = 173 AND s.mobname = "Lacerator";

-- Lufaise Meadows
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "81", maxLevel = "83" WHERE g.zoneid = 24 AND s.mobname = "Abraxas";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "81", maxLevel = "83" WHERE g.zoneid = 24 AND s.mobname = "Tavnazian_Ram";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "47", maxLevel = "49" WHERE g.zoneid = 24 AND s.mobname = "Dark_Elemental";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Bard";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Beastmaster";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "54" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Black_Mage";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "54" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Dark_Knight";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "54" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Dragoon";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "34", maxLevel = "36" WHERE g.zoneid = 24 AND s.mobname = "Fomor_s_Wyvern";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "54" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Monk";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "54" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Ninja";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "52", maxLevel = "54" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Paladin";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Ranger";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Red_Mage";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Samurai";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "53", maxLevel = "55" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Samurai";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "41", maxLevel = "43" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Summoner";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "34", maxLevel = "36" WHERE g.zoneid = 24 AND s.mobname = "Fomor_s_Elemental";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "42", maxLevel = "44" WHERE g.zoneid = 24 AND s.mobname = "Fomor_Warrior";

-- Maze of Shakhrami
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "26", maxLevel = "29" WHERE g.zoneid = 198 AND s.mobname = "Warren_Bat";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "23", maxLevel = "26" WHERE g.zoneid = 198 AND s.mobname = "Chaser_Bats";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "24", maxLevel = "28" WHERE g.zoneid = 198 AND s.mobname = "Bleeder_Leech";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "29", maxLevel = "31" WHERE g.zoneid = 198 AND s.mobname = "Crypterpillar";

-- Ordelles Caves
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "23", maxLevel = "26" WHERE g.zoneid = 193 AND s.mobname = "Buds_Bunny";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "29", maxLevel = "31" WHERE g.zoneid = 193 AND s.mobname = "Targe_Beetle";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "27", maxLevel = "29" WHERE g.zoneid = 193 AND s.mobname = "Swagger_Spruce";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "25", maxLevel = "27" WHERE g.zoneid = 193 AND s.mobname = "Bilis_Leech";

-- Outer Horutoto Ruins
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "15", maxLevel = "18" WHERE g.zoneid = 194 AND s.mobname = "Fetor_Bats";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "20", maxLevel = "23" WHERE g.zoneid = 194 AND s.mobname = "Thorn_Bat";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "23", maxLevel = "25" WHERE g.zoneid = 194 AND s.mobname = "Fuligo";

-- Ranguemont Pass
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "26", maxLevel = "30" WHERE g.zoneid = 166 AND s.mobname = "Goblin_Artificer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "26", maxLevel = "30" WHERE g.zoneid = 166 AND s.mobname = "Goblin_Hoodoo";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "26", maxLevel = "30" WHERE g.zoneid = 166 AND s.mobname = "Goblin_Tanner";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "26", maxLevel = "30" WHERE g.zoneid = 166 AND s.mobname = "Goblin_Chaser";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "25", maxLevel = "28" WHERE g.zoneid = 166 AND s.mobname = "Bilesucker";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "42", maxLevel = "44" WHERE g.zoneid = 166 AND s.mobname = "Hovering_Oculus";

-- The Eldieme Necropolis
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "53", maxLevel = "55" WHERE g.zoneid = 195 AND s.mobname = "Nekros_Hound";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "60", maxLevel = "63" WHERE g.zoneid = 195 AND s.mobname = "Hellbound_Warrior";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "60", maxLevel = "63" WHERE g.zoneid = 195 AND s.mobname = "Hellbound_Warlock";

-- Toraimarai Canal
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "58", maxLevel = "60" WHERE g.zoneid = 169 AND s.mobname = "Deviling_Bats";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "60", maxLevel = "62" WHERE g.zoneid = 169 AND s.mobname = "Plunderer_Crab";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "57", maxLevel = "59" WHERE g.zoneid = 169 AND s.mobname = "Blackwater_Pugil";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "65", maxLevel = "67" WHERE g.zoneid = 169 AND s.mobname = "Starborer";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "65", maxLevel = "67" WHERE g.zoneid = 169 AND s.mobname = "Sodden_Bones";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "65", maxLevel = "67" WHERE g.zoneid = 169 AND s.mobname = "Drowned_Bones";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "64", maxLevel = "67" WHERE g.zoneid = 169 AND s.mobname = "Flume_Toad";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "64", maxLevel = "66" WHERE g.zoneid = 169 AND s.mobname = "Rapier_Scorpion";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "63", maxLevel = "65" WHERE g.zoneid = 169 AND s.mobname = "Poroggo_Excavator";

-- West Ronfaure
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "3", maxLevel = "6" WHERE g.zoneid = 100 AND s.mobname = "River_Crab";

-- Zeruhn Mines
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "2", maxLevel = "4" WHERE g.zoneid = 172 AND s.mobname = "Colliery_Bat";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "3", maxLevel = "5" WHERE g.zoneid = 172 AND s.mobname = "Soot_Crab";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "2", maxLevel = "4" WHERE g.zoneid = 172 AND s.mobname = "Burrower_Worm";
UPDATE mob_groups g JOIN mob_spawn_points s ON (g.groupid = s.groupid) SET minLevel = "3", maxLevel = "6" WHERE g.zoneid = 172 AND s.mobname = "Veindigger_Leech";




-- -------------------------------
-- DYNAMIS -----------------------
-- -------------------------------

UPDATE mob_groups SET respawntime = "0", spawntype = "128" WHERE zoneid = "188"; -- Sets all Dynamis Jeuno mobs to not respawn and to have a scripted spawn type.
UPDATE mob_groups SET minlevel = "75", maxlevel = "77" WHERE zoneid = "188" AND minlevel != "85"; -- Sets everything expect megaboss to level 75-77, megaboss is 85-85 already
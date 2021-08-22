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

-- Lufaise Meadows
UPDATE mob_groups SET spawntype = 8 WHERE name = "Cluster" and zoneid = 24; --  Clusters in Lufaise Meadows should only spawn during foggy weather
UPDATE mob_groups SET spawntype = 8 WHERE name = "Atomic_Cluster" and zoneid = 24; --  Atomic Clusters in Lufaise Meadows should only spawn during foggy weather

-- Misareaux_Coast
UPDATE mob_groups SET spawntype = 8 WHERE name = "Atomic_Cluster" and zoneid = 25; --  Atomic Clusters in Misareaux Coast should only spawn during foggy weather

-- Monastic Cavern
UPDATE mob_groups SET HP = 7000 WHERE name = "Orcish_Overlord" and zoneid = 150; -- Hard to find a reference video from era, but this mob should not have same HP values as regular mobs around its area
UPDATE mob_groups SET HP = 60000 WHERE name = "Overlord_Bakgodek" and zoneid = 150; -- Manually captured some HP vales from this video https://www.youtube.com/watch?v=RqVfLcm4PNE&t=20s. 1% seems to be around 600 hps.

-- North Gustaberg
UPDATE mob_groups SET dropid = "1958" WHERE name = "Ornery_Sheep" and zoneid = 106; -- North Gustaberg Ornery Sheep had no drop table

-- Sacrarium
UPDATE mob_groups SET HP = 5000 WHERE name = "Old_Professor_Mariselle"; -- Reset HP values for teleport working
UPDATE mob_groups SET HP = 1000 WHERE name = "Mariselles_Pupil"; -- Reset HP values for teleport working

-- Sea Serpent Grotto
UPDATE mob_groups SET respawntime = "0", spawntype = "32" WHERE name = "Charybdis" and groupid = "51";

-- Sky
UPDATE mob_groups SET spawntype = 128 WHERE name = "Faust"; -- Set spawntype
UPDATE mob_groups SET spawntype = 128 WHERE name = "Zipacna"; -- Set spawntype
UPDATE mob_groups SET spawntype = 128 WHERE name = "Mother_Globe"; -- Set spawntype

-- Temple of Uggalepih
UPDATE mob_groups SET respawntime = "0", spawntype = "32" WHERE name = "Sozu_Rogberry"; -- Convert from force pop to lotto pop.
UPDATE mob_groups SET hp = "7000" WHERE name ="Sozu_Rogberry"; -- Increase Sozu Rogberry HP from 3k >> 7k

-- Xarcabard
UPDATE mob_groups SET respawntime = "600" WHERE zoneid = 112 AND name = "Shadow_Dragon"; -- Respawn time should be 10 min and not 30 min
UPDATE mob_groups SET dropid = "885" WHERE zoneid = 24 AND name = "Fomor_Ranger"; -- Ranger was using a Sacrarium drop ID, droping keys and subligar.

-- Yhoator Jungle
UPDATE mob_groups SET HP = 6500 WHERE name = "Edacious_Opo-opo" and zoneid = 124; -- Edacious Opo-opo HP adjustment

-- Bostaunieux Oubliette
UPDATE mob_groups SET HP = 11500 WHERE name = "Sewer_Syrup" and zoneid = 167; -- Hp increaase


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

-- Castle Oztroja
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Cutter"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Drummer_present"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Meat_Maggot"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Interrogator_pres"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Oracle"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Herald_present"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Priest_present"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Theologist_both"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Bastion_Bats"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 151 AND name = "Yagudo_Votary_present"; -- respawntime was 792

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

-- Davoi
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Davoi_Mush"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Davoi_Pugil"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Davoi_Wasp"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Wolf_Bat"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Orcish_Nightraider"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Orcish_Beastrider"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Orcish_Impaler"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Orcish_Fighter"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Orcish_Cursemaker"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Davoi_Hornet"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Orcish_Serjeant"; -- respawntime was 792
UPDATE mob_groups SET respawntime = "720"  WHERE zoneid = 149 AND name = "Wood_Bats"; -- respawntime was 792

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

-- Arrapago_Reef
UPDATE mob_groups SET minLevel = 72, maxLevel = 73 WHERE name = "Dweomershell" AND zoneid = 54;

-- Bostaunieux Oubliette
UPDATE mob_groups SET minLevel = 55, maxLevel = 59 WHERE name = "Blind_Bat" AND zoneid = 167;
UPDATE mob_groups SET minLevel = 64, maxLevel = 66 WHERE name = "Dabilla" AND zoneid = 167;
UPDATE mob_groups SET minLevel = 58, maxLevel = 62 WHERE name = "Panna_Cotta" AND zoneid = 167;
UPDATE mob_groups SET minLevel = 68, maxLevel = 70 WHERE name = "Nachtmahr" AND zoneid = 167;
UPDATE mob_groups SET minLevel = 69, maxLevel = 74 WHERE name = "Wurdalak" AND zoneid = 167;

-- Bibiki Bay
UPDATE mob_groups SET minLevel = 76, maxLevel = 79 WHERE name = "hobgoblin_toreador" AND zoneid = 4;
UPDATE mob_groups SET minLevel = 76, maxLevel = 79 WHERE name = "hobgoblin_alastor" AND zoneid = 4;
UPDATE mob_groups SET minLevel = 76, maxLevel = 79 WHERE name = "hobgoblin_physician" AND zoneid = 4;
UPDATE mob_groups SET minLevel = 78, maxLevel = 80 WHERE name = "camelopard" AND zoneid = 4;
UPDATE mob_groups SET minLevel = 73, maxLevel = 76 WHERE name = "bight_rarab" AND zoneid = 4;
UPDATE mob_groups SET minLevel = 76, maxLevel = 78 WHERE name = "hypnos_eft" AND zoneid = 4;

-- Boyahda tree
UPDATE mob_groups SET minLevel = 72, maxLevel = 75 WHERE name = "Mourning_Crawler" AND zoneid = 153;
UPDATE mob_groups SET minLevel = 75, maxLevel = 78 WHERE name = "Snaggletooth_Peapuk" AND zoneid = 153;
UPDATE mob_groups SET minLevel = 73, maxLevel = 76 WHERE name = "Viseclaw" AND zoneid = 153;

-- Crawlers' Nest
UPDATE mob_groups SET minLevel = 50, maxLevel = 53 WHERE name = "Dancing_Jewel" AND zoneid = 197;
UPDATE mob_groups SET minLevel = 47, maxLevel = 49 WHERE name = "King_Crawler" AND zoneid = 197;
UPDATE mob_groups SET minLevel = 51, maxLevel = 54 WHERE name = "Olid_Funguar" AND zoneid = 197;
UPDATE mob_groups SET minLevel = 55, maxLevel = 57 WHERE name = "Vespo" AND zoneid = 197;

-- Dangruf_Wadi
UPDATE mob_groups SET minLevel = 21, maxLevel = 23 WHERE name = "Couloir_Leech" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 16, maxLevel = 20 WHERE name = "Fume_Lizard" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 9, maxLevel = 12 WHERE name = "Witchetty_Grub" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 11, maxLevel = 14 WHERE name = "Prim_Pika" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 16, maxLevel = 20 WHERE name = "Trimmer" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 11, maxLevel = 14 WHERE name = "Natty_Gibbon" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 12, maxLevel = 16 WHERE name = "Goblin_Headsman" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 21, maxLevel = 23 WHERE name = "Goblin_Conjurer" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 12, maxLevel = 16 WHERE name = "Goblin_Bladesmith" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 21, maxLevel = 23 WHERE name = "Goblin_Bushwhacker" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 12, maxLevel = 16 WHERE name = "Goblin_Brigand" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 21, maxLevel = 23 WHERE name = "Goblin_Healer" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 16, maxLevel = 20 WHERE name = "Fire_Elemental" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 7, maxLevel = 9 WHERE name = "Wadi_Crab" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 11, maxLevel = 14 WHERE name = "Wadi_Hare" AND zoneid = 191;
UPDATE mob_groups SET minLevel = 6, maxLevel = 8 WHERE name = "Hoarder_Hare" AND zoneid = 191;

-- FeiYin
UPDATE mob_groups SET minLevel = 40, maxLevel = 42 WHERE name = "Balayang" AND zoneid = 204;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Sentient_Carafe" AND zoneid = 204;
UPDATE mob_groups SET minLevel = 40, maxLevel = 42 WHERE name = "Wekufe" AND zoneid = 204;

-- Garlaige Citadel
UPDATE mob_groups SET minLevel = 56, maxLevel = 58 WHERE name = "Warden_Beetle" AND zoneid = 200;
UPDATE mob_groups SET minLevel = 59, maxLevel = 62 WHERE name = "Kaboom" AND zoneid = 200;
UPDATE mob_groups SET minLevel = 52, maxLevel = 55 WHERE name = "Fortalice_Bats" AND zoneid = 200;
UPDATE mob_groups SET minLevel = 54, maxLevel = 56 WHERE name = "Donjon_Bat" AND zoneid = 200;

-- Gusgen Mines
UPDATE mob_groups SET minLevel = 33, maxLevel = 36 WHERE name = "Accursed_Soldier" AND zoneid = 196;
UPDATE mob_groups SET minLevel = 33, maxLevel = 36 WHERE name = "Accursed_Sorcerer" AND zoneid = 196;
UPDATE mob_groups SET minLevel = 27, maxLevel = 30 WHERE name = "Madfly" AND zoneid = 196;
UPDATE mob_groups SET minLevel = 23, maxLevel = 26 WHERE name = "Rockmill" AND zoneid = 196;

-- Inner Horutoto Ruins
UPDATE mob_groups SET minLevel = 17, maxLevel = 20 WHERE name = "Covin_Bat" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 11, maxLevel = 16 WHERE name = "Deathwatch_Beetle" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Goblin_Flesher" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Goblin_Lurcher" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Goblin_Metallurgist" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Goblin_Trailblazer" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 25, maxLevel = 28 WHERE name = "Skinnymalinks" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 25, maxLevel = 28 WHERE name = "Skinnymajinx" AND zoneid = 192;
UPDATE mob_groups SET minLevel = 12, maxLevel = 15 WHERE name = "Troika_Bats" AND zoneid = 192;

-- King Ranperres Tomb
UPDATE mob_groups SET minLevel = 62, maxLevel = 64 WHERE name = "Ogre_Bat" AND zoneid = 190;
UPDATE mob_groups SET minLevel = 58, maxLevel = 60 WHERE name = "Ossuary_Worm" AND zoneid = 190;
UPDATE mob_groups SET minLevel = 64, maxLevel = 66 WHERE name = "Bonnet_Beetle" AND zoneid = 190;
UPDATE mob_groups SET minLevel = 63, maxLevel = 65 WHERE name = "Barrow_Scorpion" AND zoneid = 190;

-- Korroloka Tunnel
UPDATE mob_groups SET minLevel = 28, maxLevel = 31 WHERE name = "Spool_Leech" AND zoneid = 173;
UPDATE mob_groups SET minLevel = 29, maxLevel = 32 WHERE name = "Lacerator" AND zoneid = 173;

-- Lufaise Meadows
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomor_Bard" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomor_Beastmaster" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Black_Mage" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Dark_Knight" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Dragoon" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 34, maxLevel = 36 WHERE name = "Fomor_s_Wyvern" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Monk" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Ninja" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 52, maxLevel = 54 WHERE name = "Fomor_Paladin" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomor_Ranger" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomor_Red_Mage" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomor_Samurai" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 53, maxLevel = 55 WHERE name = "Fomor_Samurai" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 41, maxLevel = 43 WHERE name = "Fomor_Summoner" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 34, maxLevel = 36 WHERE name = "Fomor_s_Elemental" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 42, maxLevel = 44 WHERE name = "Fomor_Warrior" AND zoneid = 24;
UPDATE mob_groups SET minLevel = 80, maxLevel = 83 WHERE name = "Abraxas" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 33, maxLevel = 36 WHERE name = "Acrophies" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 43, maxLevel = 44 WHERE name = "Air_Elemental" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 34, maxLevel = 37 WHERE name = "Bugard" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 38, maxLevel = 40 WHERE name = "Cluster" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 33, maxLevel = 36 WHERE name = "Crimson_Knight_Crab" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 84, maxLevel = 86 WHERE name = "Dark_Elemental" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Gigas_Slinger" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Gigas_Wrestler" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 49, maxLevel = 53 WHERE name = "Leshachikha" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 31, maxLevel = 34 WHERE name = "Miner_Bee" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Orcish_Beastrider" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Orcish_Brawler" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Orcish_Impaler" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 35, maxLevel = 38 WHERE name = "Orcish_Nightraider" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 37, maxLevel = 40 WHERE name = "Orcish_Stonelauncher" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 81, maxLevel = 83 WHERE name = "Tavnazian_Ram" AND zoneid = 24; -- Fixed levels
UPDATE mob_groups SET minLevel = 43, maxLevel = 44 WHERE name = "Thunder_Elemental" AND zoneid = 24 AND groupid = 25; -- Fixed levels
UPDATE mob_groups SET minLevel = 62, maxLevel = 63 WHERE name = "Thunder_Elemental" AND zoneid = 24 AND groupid = 78; -- Fixed levels

-- Maze of Shakhrami
UPDATE mob_groups SET minLevel = 26, maxLevel = 29 WHERE name = "Warren_Bat" AND zoneid = 198;
UPDATE mob_groups SET minLevel = 23, maxLevel = 26 WHERE name = "Chaser_Bats" AND zoneid = 198;
UPDATE mob_groups SET minLevel = 24, maxLevel = 28 WHERE name = "Bleeder_Leech" AND zoneid = 198;
UPDATE mob_groups SET minLevel = 29, maxLevel = 31 WHERE name = "Crypterpillar" AND zoneid = 198;

-- Ordelles Caves
UPDATE mob_groups SET minLevel = 23, maxLevel = 26 WHERE name = "Buds_Bunny" AND zoneid = 193;
UPDATE mob_groups SET minLevel = 29, maxLevel = 31 WHERE name = "Targe_Beetle" AND zoneid = 193;
UPDATE mob_groups SET minLevel = 27, maxLevel = 29 WHERE name = "Swagger_Spruce" AND zoneid = 193;
UPDATE mob_groups SET minLevel = 25, maxLevel = 27 WHERE name = "Bilis_Leech" AND zoneid = 193;

-- Outer Horutoto Ruins
UPDATE mob_groups SET minLevel = 15, maxLevel = 18 WHERE name = "Fetor_Bats" AND zoneid = 194;
UPDATE mob_groups SET minLevel = 20, maxLevel = 23 WHERE name = "Thorn_Bat" AND zoneid = 194;
UPDATE mob_groups SET minLevel = 23, maxLevel = 25 WHERE name = "Fuligo" AND zoneid = 194;

-- Ranguemont Pass
UPDATE mob_groups SET minLevel = 26, maxLevel = 30 WHERE name = "Goblin_Artificer" AND zoneid = 166;
UPDATE mob_groups SET minLevel = 26, maxLevel = 30 WHERE name = "Goblin_Hoodoo" AND zoneid = 166;
UPDATE mob_groups SET minLevel = 26, maxLevel = 30 WHERE name = "Goblin_Tanner" AND zoneid = 166;
UPDATE mob_groups SET minLevel = 26, maxLevel = 30 WHERE name = "Goblin_Chaser" AND zoneid = 166;
UPDATE mob_groups SET minLevel = 25, maxLevel = 28 WHERE name = "Bilesucker" AND zoneid = 166;
UPDATE mob_groups SET minLevel = 42, maxLevel = 44 WHERE name = "Hovering_Oculus" AND zoneid = 166;

-- The Eldieme Necropolis
UPDATE mob_groups SET minLevel = 53, maxLevel = 55 WHERE name = "Nekros_Hound" AND zoneid = 195;
UPDATE mob_groups SET minLevel = 60, maxLevel = 63 WHERE name = "Hellbound_Warrior" AND zoneid = 195;
UPDATE mob_groups SET minLevel = 60, maxLevel = 63 WHERE name = "Hellbound_Warlock" AND zoneid = 195;

-- Toraimarai Canal
UPDATE mob_groups SET minLevel = 58, maxLevel = 60 WHERE name = "Deviling_Bats" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 60, maxLevel = 62 WHERE name = "Plunderer_Crab" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 57, maxLevel = 59 WHERE name = "Blackwater_Pugil" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 65, maxLevel = 67 WHERE name = "Starborer" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 65, maxLevel = 67 WHERE name = "Sodden_Bones" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 65, maxLevel = 67 WHERE name = "Drowned_Bones" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 64, maxLevel = 67 WHERE name = "Flume_Toad" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 64, maxLevel = 66 WHERE name = "Rapier_Scorpion" AND zoneid = 169;
UPDATE mob_groups SET minLevel = 63, maxLevel = 65 WHERE name = "Poroggo_Excavator" AND zoneid = 169;

-- West Ronfaure
UPDATE mob_groups SET minLevel = 3, maxLevel = 6 WHERE name = "River_Crab" AND zoneid = 100;

-- Zeruhn Mines
UPDATE mob_groups SET minLevel = 2, maxLevel = 4 WHERE name = "Colliery_Bat" AND zoneid = 172;
UPDATE mob_groups SET minLevel = 3, maxLevel = 5 WHERE name = "Soot_Crab" AND zoneid = 172;
UPDATE mob_groups SET minLevel = 2, maxLevel = 4 WHERE name = "Burrower_Worm" AND zoneid = 172;
UPDATE mob_groups SET minLevel = 3, maxLevel = 6 WHERE name = "Veindigger_Leech" AND zoneid = 172;

-- -------------------------------
-- DYNAMIS -----------------------
-- -------------------------------

UPDATE mob_groups SET respawntime = "0", spawntype = "128" WHERE zoneid = "188"; -- Sets all Dynamis Jeuno mobs to not respawn and to have a scripted spawn type.
UPDATE mob_groups SET minlevel = "75", maxlevel = "77" WHERE zoneid = "188" AND minlevel != "85"; -- Sets everything expect megaboss to level 75-77, megaboss is 85-85 already
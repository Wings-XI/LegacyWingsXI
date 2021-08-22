-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Please ANNOTATE WELL for a clear understanding of what the query is adding/changing/fixing.     --
--                           Overly detaling your query is NOT needed.                             --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
--        DO NOT RUN QUERIES ON THE LIVE SERVER BEFORE TESTING IN A ISOLATED DEV ENVIRONMENT       --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------

-- IMPORTANT: Run mob_family_system queries before these!!!


-- -----------
-- GENERAL  --
-- -----------



-- Beadeaux
UPDATE mob_pools SET modelid = X'00008B0200000000000000000000000000000000' WHERE poolid = 538 AND name = "Bronze_Quadav"; -- His model was not era accurate.

-- Bibiki Bay
UPDATE mob_pools SET immunity = "1040", entityflags = "7" WHERE name = "Shen"; -- Immune to Silence and Requiem and also increased its size
UPDATE mob_pools SET immunity = "12" WHERE name = "Shens_Filtrate"; -- Immune to Bind, Stun

-- Bostaunieux Oubliette
UPDATE mob_pools SET familyid = "172" WHERE poolid = 5138 AND name = "Bloodsucker"; -- Bloodsucker NM should link with regular Bloodsucker as confirmed here: https://ffxi.allakhazam.com/db/bestiary.html?fmob=726

-- Castle Oztroja
UPDATE mob_pools SET entityFlags = "4" WHERE poolid = 2016 AND name = "Huu_Xalmo_the_Savage"; -- Model size should be bigger.

-- Davoi
UPDATE mob_pools SET immunity = "1" WHERE poolid = 419 AND name = "Bilopdop"; -- Bilopdop should be immune to Sleep
UPDATE mob_pools SET immunity = "17" WHERE poolid = 3233 AND name = "Purpleflash_Brukdok"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = "1" WHERE poolid = 2980 AND name = "One-eyed_Gwajboj"; -- Immunte to sleep
UPDATE mob_pools SET immunity = "1" WHERE poolid = 3902 AND name = "Three-eyed_Prozpuz"; -- Immunte to sleep
UPDATE mob_groups SET HP = 7500 WHERE name = "One-eyed_Gwajboj" and zoneid = 149; --  Adjusted HP values for PLD AF3
UPDATE mob_groups SET HP = 6000 WHERE name = "Three-eyed_Prozpuz" and zoneid = 149; --  Adjusted HP values for PLD AF3

-- Fei'yin
UPDATE mob_pools SET cmbDelay = 200 WHERE poolid = 2678 AND name = "Miser_Murphy"; -- Faster delay

-- Garliage Citidel
UPDATE mob_pools SET immunity = "233" WHERE poolid = 1831 AND name = "Guardian_Statue"; -- Immune to Sleep, Stun, Bind, Slow, Paralyze

-- Ghelsba Outpost
UPDATE mob_pools SET cmbDelay = 160 WHERE NAME = 'Kilioa'; -- Kilioa has CLEARLY a faster attack speed as seen here: https://www.youtube.com/watch?v=DR8MG-hftXY
UPDATE mob_pools SET cmbDelay = 160 WHERE NAME = 'Kalamainu'; -- Kalamainu has CLEARLY a faster attack speed as seen here: https://www.youtube.com/watch?v=DR8MG-hftXY

-- Gustav Tunnel
UPDATE mob_pools SET spellList = "0", immunity = "1" WHERE poolid = 584 AND name = "Bune"; -- Bune should be immune to all forms of sleep and should not cast spells

-- Horlais Peak
UPDATE mob_pools SET spellList = 477 WHERE NAME = 'Pilwiz'; -- He should only cast Stonega II

-- Jade Sepulcher
UPDATE mob_pools SET aggro = "0", true_detection = "0", links = "0" WHERE poolid = 3327; -- Raubahn - BLU LB5 -- Adding his spell list

-- Jugner Forest
UPDATE mob_pools SET entityFlags = "159", familyid = 189 WHERE poolid = 2643 AND name = "Meteormauler_Zhagtegg"; -- His size should be bigger and should link with other Orcs

-- Labyrinth of Onzozo
UPDATE mob_pools SET immunity = "17" WHERE poolid = 2439 AND name = "Lord_of_Onzozo"; -- LoO should be only immune to Silence and Sleep

-- Meriphataud Mountains
UPDATE mob_pools SET entityFlags = "4", familyid = 270 WHERE poolid = 788 AND name = "Coo_Keja_the_Unseen"; -- His size should be bigger and should link with other Yagudos

-- Monastic Cavern
UPDATE mob_pools SET entityFlags = "1183", skill_list_id = 189 WHERE poolid = 3075 AND name = "Overlord_Bakgodek"; -- He was previously using a skill list for Dynamis Orc. He was also missing Howl. His model was also too small

-- Palborough Mines
UPDATE mob_pools SET hasSpellScript = "1", entityflags = "4", cmbDmgMult = "200"  WHERE name = "Ni_Ghu_Nestfender"; -- His casts are scripted via LUA. His dmg needs to be higher. He should have a bigger size
UPDATE mob_pools SET modelid = X'0000990200000000000000000000000000000000', entityflags = "4"  WHERE name = "No_Mho_Crimsonarmor"; -- His model and size was not era accurate. Fixed.

-- Passhow Marshlands
UPDATE mob_pools SET entityFlags = "4", familyid = 202 WHERE poolid = 519 AND name = "Bo_Who_Warmonger"; -- His size should be bigger and should link with other Quadavs
UPDATE mob_pools SET links = "1" WHERE name = "Water_Wasp"; -- Add sight linking to Water Wasps.
UPDATE mob_pools SET aggro = "1" WHERE name = "Land_Pugil"; -- Add sound aggro to Land Pugil.

-- Quicksand Caves
UPDATE mob_pools SET hasSpellScript = "1" WHERE name = "Ancient_Vessel" AND poolid = 128; -- Scripting the spell casting of Ancient Vessel so it use more Firaga 3 & Aeroga 3
INSERT IGNORE INTO `mob_pools` VALUES(6186, 'Sabotender_Bailaor', 'Sabotender_Bailaor', 212, 0x0000740100000000000000000000000000000000, 2, 2, 5, 240, 100, 0, 1, 0, 0, 0, 0, 0, 204, 133, 0, 0, 0, 1, 0, 212);
INSERT IGNORE INTO `mob_pools` VALUES(6187, 'Sabotender_Bailarin', 'Sabotender_Bailarin', 212, 0x0000740100000000000000000000000000000000, 2, 2, 7, 240, 100, 0, 1, 0, 0, 2, 0, 0, 204, 133, 0, 0, 0, 1, 0, 212);

-- RoMaeve
UPDATE mob_pools SET familyid = 110, links = 1 WHERE poolid = 3603 AND name = "Shikigami_Weapon"; -- Changed family so it links with other weapons

-- Sacrarium
	-- CoP 4-3
UPDATE mob_pools SET immunity = "17", spellList = 478, behavior = 0 WHERE name = "Old_Professor_Mariselle" AND poolid = 2964; -- Immune to sleep and silence & custom spell list. Fixes no_standack issue.
UPDATE mob_pools SET immunity = "17", spellList = 479 WHERE name = "Mariselles_Pupil" AND poolid = 2566; -- Immune to sleep and silence & custom spell list

-- Sea Serpent Grotto
UPDATE mob_pools SET entityFlags = "4" WHERE poolid = 2914 AND name = "Novv_the_Whitehearted"; -- His size should be bigger

-- Spire of Mea
UPDATE mob_pools SET cmbDelay = 200 WHERE NAME = 'Delver'; -- Delver has CLEARLY a faster attack speed as seen here: https://www.youtube.com/watch?v=rd4QhL_pqUQ

-- Spire of Dem
UPDATE mob_pools SET cmbDelay = 180 WHERE NAME = 'Progenerator'; -- Faster attack speed to mimic era
UPDATE mob_pools SET entityFlags = 4 WHERE NAME = 'Progenerator'; -- Faster attack speed to mimic era

-- Spire of Holla
UPDATE mob_pools SET cmbDelay = 180 WHERE NAME = 'Wreaker'; -- Faster attack speed to mimic era

-- The Shrine of Ru'Avitau
UPDATE mob_pools SET roamflag = "256" WHERE name = "Faust"; -- Change fausts roam flag to follow only lua.

-- Uleguerand Range
UPDATE mob_pools SET spellList = "470", cmbDelay = "260", immunity = "8" WHERE name = "Geush_Urvan"; -- Immune to Stun, custom auto-attack ability to ignore shadows, adjusting his spell list
UPDATE mob_pools SET skill_list_id = "1199" WHERE name = "Black_Coney"; -- Adding his ability list

-- Upper Delkfuts Tower
UPDATE mob_pools SET cmbSkill = 6, cmbDelay = 210 WHERE name = "Alkyoneus"; -- Alky wrongfully had H2H skill, which somehow added an innate Hundred Fists bug under some conditions. Era reference video https://www.youtube.com/watch?v=3BpBRFamFxs

-- Yuhtunga Jungle
UPDATE mob_pools SET entityFlags = "4" where poolid = 2647 AND name = "Meww_the_Turtlerider"; -- His size should be bigger
UPDATE mob_pools SET entityFlags = "7" where poolid = 4252 AND name = "Voluptuous_Vilma"; -- Her size should be bigger

-- Zeruhn Mines
INSERT IGNORE INTO `mob_pools` VALUES (6031,'Giant_Amoeba','Giant_Amoeba',229,X'0000240100000000000000000000000000000000',1,1,7,240,100,0,1,0,0,16,0,0,245,131,0,0,0,0,0,229); -- Adding Giant Amoeba to the server

-- Divine Might (Quest)
UPDATE mob_pools SET immunity = "1" WHERE name = "Ark_Angel_EV"; -- Immune to Sleep - retail accurate
UPDATE mob_pools SET immunity = "1" WHERE name = "Ark_Angel_GK"; -- Immune to Sleep - retail accurate
UPDATE mob_pools SET immunity = "1" WHERE name = "Ark_Angel_HM"; -- Immune to Sleep - retail accurate
UPDATE mob_pools SET immunity = "1" WHERE name = "Ark_Angel_MR"; -- Immune to Sleep - retail accurate
UPDATE mob_pools SET immunity = "1" WHERE name = "Ark_Angel_TT"; -- Immune to Sleep - retail accurate

-- CoP 2-5 Ancient Vows: Mammets
UPDATE mob_pools SET immunity = "1" WHERE name = "Mammet-19_Epsilon"; -- Immune to Sleep & Lullaby: https://www.youtube.com/watch?v=r1zd7ZTkDkE&t=151s&ab_channel=Mcatchan

-- Carpenters Landing
UPDATE mob_pools SET cmbDelay = 100 WHERE NAME = 'Overgrown_Ivy'; -- Overgrown_Ivy should have attacks speed close to that of Hundred Fists https://youtu.be/7Jrnhdg7PFs?t=830

-- CoP 5-3U Where Messengers Gather (Boneyard Gully Fight)
-- Shikaree_X
UPDATE mob_pools SET skill_list_id = "1155" WHERE name = "Shikaree_X" and poolid = 3598; -- Had wrong skill id list
UPDATE mob_pools SET cmbSkill = "2" WHERE name = "Shikaree_X" and poolid = 3598; -- Was H2H now Dagger
UPDATE mob_pools SET spellList = "471" WHERE name = "Shikaree_X" and poolid = 3598; -- Created spell list for Shikaree_X

-- Shikaree_Y
UPDATE mob_pools SET skill_list_id = "1156" WHERE name = "Shikaree_Y" and poolid = 3600; -- Had wrong skill id list
UPDATE mob_pools SET cmbSkill = "7" WHERE name = "Shikaree_Y" and poolid = 3600; -- Was Dagger now Scythe
UPDATE mob_pools SET sJob = "2" WHERE name = "Shikaree_Y" and poolid = 3600; -- Was DRK/DRK now DRK/MNK
UPDATE mob_pools SET spellList = "472" WHERE name = "Shikaree_Y" and poolid = 3600; -- Created spell list for Shikaree_Y

-- Shikaree_Z
UPDATE mob_pools SET skill_list_id = "1157" WHERE name = "Shikaree_Z" and poolid = 3601; -- Had wrong skill id list
UPDATE mob_pools SET spellList = "473" WHERE name = "Shikaree_Z" and poolid = 3601; -- Creasted spell list for Shikaree_Z

-- CoP 5-3L Past Sins (Mineshaft 2716 Fight)
-- Chekochuk
UPDATE mob_pools SET spellList = "474" WHERE name = "Chekochuk" and poolid = 707; -- Created custom spell list ID - used three different FFXI Captures
-- Movamuq
UPDATE mob_pools SET spellList = "475" WHERE name = "Movamuq" and poolid = 2766; -- Created custom spell list ID - used three different FFXI Captures
-- Trikotrak
UPDATE mob_pools SET spellList = "476" WHERE name = "Trikotrak" and poolid = 4005; -- Created custom spell list ID - used three different FFXI Captures
-- Bugbby
UPDATE mob_pools SET cmbDelay = 400 WHERE NAME = 'Bugbby'; -- Highered delay to mimic attack speed with the addition of double attack/triple attack % https://youtu.be/KM6KAX2iAQ0?t=575

-- Multiple areas
UPDATE mob_pools SET modelid = X'0000890200000000000000000000000000000000', entityFlags = "133" WHERE name = "Ancient_Quadav" AND poolid  = 125; -- Ancient Quadavs were using wrong armored models
UPDATE mob_pools SET entityFlags = "4" WHERE name = "Ruby_Quadav" AND poolid = 3410; -- Ruby Quadav model was too small
UPDATE mob_pools SET modelid = X'0000910200000000000000000000000000000000', entityFlags = "4" WHERE name = "Adaman_Quadav" AND poolid = 46; -- Adaman Quadavs were using wrong armored models and wrong size
UPDATE mob_pools SET modelid = X'00008B0200000000000000000000000000000000' WHERE name = "Bronze_Quadav" AND poolid = 538; -- Bronze Quadavs were using wrong armored models

-- CoP 3-5 Diabolos
UPDATE mob_pools SET immunity = "17", cmbDelay = 180 WHERE name = "Diabolos" and poolid = 1027; -- Immune to Sleeps and Silence

-- BCNM 20 Wings of Fury - Furies
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Furies" and poolid = 1441; -- Change skill list ID for new WS

-- Fixing all Bat Trio ("bats" family - NOT "bat") WS Skill Lists (Zilart Areas = 47, Promathia areas + NM = 504)
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Black_Triple_Stars" and poolid = 440; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Bulldog_Bats" and poolid = 575; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Canal_Bats" and poolid = 5129; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Dark_Bats" and poolid = 909; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Fomors_Bats" and poolid = 1394; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Hazhalm_Bats" and poolid = 1906; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Incubus_Bats" and poolid = 2073; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Nightmare_Gaylas" and poolid = 2853; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Nosferatu_Bats" and poolid = 2911; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Succubus_Bats" and poolid = 6177; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Tres_Duendes" and poolid = 3997; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Utgarth_Bats" and poolid = 4110; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Vampyr_Bats" and poolid = 4128; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Volcanic_Bats" and poolid = 4244; -- Adds Turbulence and Slipstream
UPDATE mob_pools SET skill_list_id = 504 WHERE name = "Wingrats" and poolid = 4353; -- Adds Turbulence and Slipstream

-- Minotaur
UPDATE mob_pools SET cmbDelay = 340 WHERE name = "Minotaur" and poolid = 2675; -- Lowered delay to match era

-- King Vinegarroon
UPDATE mob_pools SET immunity = 1 WHERE name = "King_Vinegarroon" and poolid = 2262; -- Immunte to sleep

-- SAM AF2
UPDATE mob_pools SET immunity = 1, spellList = 2 WHERE name = "Onryo" and poolid = 2984; -- Immunte to sleep and changed spell list to better reflect correct spells
UPDATE mob_pools SET immunity = 1, cmbDelay = 300 WHERE name = "Doman" and poolid = 1077; -- Immunte to sleep

-- BLM AF 1 & 3
UPDATE mob_pools SET immunity = "17" WHERE name = "chaos_elemental"; -- Adds silence and sleep immune for BLM AF weapon mob.
UPDATE mob_pools SET immunity = "25" WHERE name = "magic_sludge"; -- Add silence, sleep and stun immune.

-- WHM AF 3
UPDATE mob_pools SET immunity = "25" WHERE name = "altedour_i_tavnazia"; -- Add silence, sleep and stun immune. WHM AF3 mob

-- PLD AF 3
UPDATE mob_pools SET immunity = "17" WHERE name = "three-eyed_prozpuz"; -- Add Sleep and silence immune to PFD AF3 NM 1
UPDATE mob_pools SET immunity = "17" WHERE name = "one-eyed_gwajboj"; -- Add Sleep and silence immune to PFD AF3 NM 2

-- DRK AF 1,2,3
UPDATE mob_pools SET immunity = "8" WHERE name = "vaa_huja_the_erudite"; -- Add stun immune to DRK AF1 NM
UPDATE mob_pools SET immunity = "48" WHERE name = "gerwitzs_soul"; -- Add silence and paralyze immune to DRK AF2 NM3
UPDATE mob_pools SET immunity = "17" WHERE name = "gerwitzs_scythe"; -- Add silence and sleep immune to DRK AF3 NM1
UPDATE mob_pools SET immunity = "1" WHERE name = "scythe_victim"; -- Add sleep immune to DRK AF3 NM2

-- BST AF 2
UPDATE mob_pools SET immunity = "16" WHERE name = "dabotzs_ghost"; -- Add silence immune to BST AF2 NM

-- BRD AF 1,2,3
UPDATE mob_pools SET immunity = "16" WHERE name = "tros"; -- Add silence immune to BRD AF1 NM
UPDATE mob_pools SET immunity = "1" WHERE name = "yum_kimil"; -- Add sleep immune to BRD AF2 NM1
UPDATE mob_pools SET immunity = "8" WHERE name = "bugaboo"; -- Add stun immune to BRD AF3 NM

-- NIN AF 1,3
UPDATE mob_pools SET immunity = "1" WHERE name = "tsuchigumo"; -- Add sleep immune to NIN AF1 NM1 & 2
UPDATE mob_pools SET immunity = "1" WHERE name = "kappa_akuso"; -- Add sleep immune to NIN AF3 NM1
UPDATE mob_pools SET immunity = "1" WHERE name = "kappa_bonze"; -- Add sleep immune to NIN AF3 NM2
UPDATE mob_pools SET immunity = "1" WHERE name = "kappa_biwa"; -- Add sleep immune to NIN AF3 NM3

-- DRG AF 1,3
UPDATE mob_pools SET immunity = "16" WHERE name = "decurio_i-iii"; -- Add silence immune to DRG AF1 NM
UPDATE mob_pools SET immunity = "9" WHERE name = "cleuvarion_m_resoaix"; -- Add sleep and stun immune to DRG AF3 NM1
UPDATE mob_pools SET immunity = "9" WHERE name = "rompaulion_s_citalle"; -- Add sleep and stun immune to DRG AF3 NM2

-- BLU AF
UPDATE mob_pools SET immunity = "24", skill_list_id ="238" WHERE name = "nepionic_soulflayer"; -- Add silence and stun immune to BLU AF3 NM

-- LB2 Mobs
UPDATE mob_pools SET immunity = "17", cmbDelay = "200" WHERE name = "Boreal_Tiger"; -- Immune to sleep & silence
UPDATE mob_pools SET immunity = "1", cmbDelay = "200" WHERE name = "Boreal_Hound"; -- Immune to sleep
UPDATE mob_pools SET immunity = "1" WHERE name = "Boreal_Coeurl"; -- Immune to sleep

-- KA Attack Speed Fix
UPDATE mob_pools SET cmbDelay ="140" WHERE name = "King_Arthro"; -- Increase KA Attack speed to match reference video https://www.youtube.com/watch?v=mhDcFbpuS0Y&t=287s

-- Sacrarium
UPDATE mob_pools SET links = "0" WHERE name = "Azren_Kuba"; -- Should not link with each other
UPDATE mob_pools SET links = "0" WHERE name = "Azren_Kuguza"; -- Should not link with each other

-- Sky
UPDATE mob_pools SET cmbDelay = 150, immunity = 1 WHERE name = "Zipacna"; -- Speeds up delay
UPDATE mob_pools SET immunity = 17 WHERE name = "Mother_Globe"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = 641 WHERE name = "Despot"; -- Immune to Slow, Elegy and Sleep
UPDATE mob_pools SET immunity = 17 WHERE name = "Ullikummi"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = 641 WHERE name = "Faust"; -- Immune to Slow, Elegy and Sleep
UPDATE mob_pools SET immunity = 17 WHERE name = "Olla_Grande"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = 17 WHERE name = "Olla_Media"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = 17 WHERE name = "Olla_Pequena"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = 17 WHERE name = "Steam_Cleaner"; -- Immune to sleep and silence
UPDATE mob_pools SET immunity = 1 WHERE name = "Brigandish_Blade"; -- Immune to sleep


-- ---------
-- OTHERS --
-- ---------

-- UPDATE mob_pools SET familyid = "111" WHERE name = "Goblin_Fisher";  --NOT NEEDED FOR WINGS AND NEEDS UPDATE FOR TOPAZ AS SHOULD AFFECT ALL ARMORED GOBLINS
UPDATE mob_pools SET familyid = "550" WHERE name LIKE "%_of_batons"; -- Unique Cardian family type so they can drop Earth crystals
UPDATE mob_pools SET familyid = "551" WHERE name LIKE "%_of_coins"; -- Unique Cardian family type so they can drop Light crystals
UPDATE mob_pools SET familyid = "552" WHERE name LIKE "%_of_swords"; -- Unique Cardian family type so they can drop Fire crystals





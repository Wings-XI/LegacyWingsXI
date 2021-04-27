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

-- Bibiki Bay
UPDATE mob_pools SET immunity = "1040", entityflags = "7" WHERE name = "Shen"; -- Immune to Silence and Requiem and also increased its size
UPDATE mob_pools SET immunity = "12" WHERE name = "Shens_Filtrate"; -- Immune to Bind, Stun

-- Bostaunieux Oubliette
UPDATE mob_pools SET familyid = "172" WHERE poolid = 5138 AND name = "Bloodsucker"; -- Bloodsucker NM should link with regular Bloodsucker as confirmed here: https://ffxi.allakhazam.com/db/bestiary.html?fmob=726

-- Jade Sepulcher
UPDATE mob_pools SET aggro = "0", true_detection = "0", links = "0" WHERE poolid = 3327; -- Raubahn - BLU LB5 -- Adding his spell list

-- Jugner Forest
UPDATE mob_pools SET entityFlags = "159", familyid = 189 WHERE poolid = 2643 AND name = "Meteormauler_Zhagtegg"; -- His size should be bigger and should link with other Orcs

-- Meriphataud Mountains
UPDATE mob_pools SET entityFlags = "4", familyid = 270 WHERE poolid = 788 AND name = "Coo_Keja_the_Unseen"; -- His size should be bigger and should link with other Yagudos

-- Monastic Cavern
UPDATE mob_pools SET entityFlags = "1183" WHERE poolid = 3075 AND name = "Overlord_Bakgodek"; -- Making him bigger

-- Palborough Mines
UPDATE mob_pools SET hasSpellScript = "1", entityflags = "4", cmbDmgMult = "200"  WHERE name = "Ni_Ghu_Nestfender"; -- His casts are scripted via LUA. His dmg needs to be higher. He should have a bigger size
UPDATE mob_pools SET modelid = X'0000990200000000000000000000000000000000', entityflags = "4"  WHERE name = "No_Mho_Crimsonarmor"; -- His model and size was not era accurate. Fixed.

-- Passhow Marshlands
UPDATE mob_pools SET entityFlags = "4", familyid = 202 WHERE poolid = 519 AND name = "Bo_Who_Warmonger"; -- His size should be bigger and should link with other Quadavs

-- Quicksand Caves
UPDATE mob_pools SET hasSpellScript = "1" WHERE name = "Ancient_Vessel" AND poolid = 128; -- Scripting the spell casting of Ancient Vessel so it use more Firaga 3 & Aeroga 3

-- RoMaeve
UPDATE mob_pools SET familyid = 110, links = 1 WHERE poolid = 3603 AND name = "Shikigami_Weapon"; -- Changed family so it links with other weapons

-- Sea Serpent Grotto
UPDATE mob_pools SET entityFlags = "4" WHERE poolid = 2914 AND name = "Novv_the_Whitehearted"; -- His size should be bigger

-- Spire of Mea
UPDATE mob_pools SET cmbDelay = 200 WHERE NAME = 'Delver'; -- Delver has CLEARLY a faster attack speed as seen here: https://www.youtube.com/watch?v=rd4QhL_pqUQ

-- Uleguerand Range
UPDATE mob_pools SET spellList = "436", cmbDelay = "260", immunity = "8" WHERE name = "Geush_Urvan"; -- Immune to Stun, custom auto-attack ability to ignore shadows, adjusting his spell list
UPDATE mob_pools SET skill_list_id = "1199" WHERE name = "Black_Coney"; -- Adding his ability list

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

-- ---------
-- OTHERS --
-- ---------

-- UPDATE mob_pools SET familyid = "111" WHERE name = "Goblin_Fisher";  --NOT NEEDED FOR WINGS AND NEEDS UPDATE FOR TOPAZ AS SHOULD AFFECT ALL ARMORED GOBLINS

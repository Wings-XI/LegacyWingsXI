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
-- General --
-- ----------

-- Balga's Dais
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,1333); -- Moa Constrictors KSNM 30 abilities added - Contagion Transfer
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,1334); -- Moa Constrictors KSNM 30 abilities added - Contamination
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,1335); -- Moa Constrictors KSNM 30 abilities added - Toxic Pick
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,406); -- Moa Constrictors KSNM 30 abilities added - Hammer Beak
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,407); -- Moa Constrictors KSNM 30 abilities added - Poison Pick
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,408); -- Moa Constrictors KSNM 30 abilities added - Sound Vacuum
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,410); -- Moa Constrictors KSNM 30 abilities added - Sound Blast
INSERT IGNORE INTO mob_skill_lists VALUES ('Giant_Moa',1198,411); -- Moa Constrictors KSNM 30 abilities added - Baleful Gaze

-- Ghelsba Outpost
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,813); -- Adding missing TP moves for DRG Quest BCNM - dispelling_wind
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,814); -- Adding missing TP moves for DRG Quest BCNM - deadly_drive
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,815); -- Adding missing TP moves for DRG Quest BCNM - wind_wall
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,816); -- Adding missing TP moves for DRG Quest BCNM - fang_rush
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,817); -- Adding missing TP moves for DRG Quest BCNM - dread_shriek
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,818); -- Adding missing TP moves for DRG Quest BCNM - tail_crush
INSERT IGNORE INTO mob_skill_lists VALUES ('Cyranuce_M_Cutauleon',498,822); -- Adding missing TP moves for DRG Quest BCNM - chaos_breath

-- Jade Sepulcher
INSERT IGNORE INTO mob_skill_lists VALUES ('Raubahn',783,34); -- Red Lotus Blade
INSERT IGNORE INTO mob_skill_lists VALUES ('Raubahn',783,39); -- Spirits Within

-- Riverne Site #A01 & #B01
INSERT IGNORE INTO mob_skill_lists VALUES ('Hippogryph',140,577); -- Jettatura - Hippogryph ability
DELETE FROM mob_skill_lists WHERE mob_skill_id = 2828 AND skill_list_id = 140; -- Jettatura - Hippogryph ability - This version should ONLY be used by Dynamis Hippogryphs as it includes AOE effect
INSERT IGNORE INTO mob_skill_lists VALUES ('Hippogryph',140,579); -- Choke Breath - Hippogryph ability
INSERT IGNORE INTO mob_skill_lists VALUES ('Hippogryph',140,580); -- Fantod - Hippogryph ability
INSERT IGNORE INTO mob_skill_lists VALUES ('Hippogryph',141,579); -- Choke Breath - Hippogryph ability (different family group used mostly by NMs)
INSERT IGNORE INTO mob_skill_lists VALUES ('Hippogryph',141,580); -- Fantod - Hippogryph ability (different family group used mostly by NMs)
INSERT IGNORE INTO mob_skill_lists VALUES ('Hippogryph',141,1330); -- Only NM Hippogryphs use it randomly right after any WS (different family group used mostly by NMs)

-- Spire of Mea
DELETE FROM mob_skill_lists WHERE mob_skill_id = 1229 AND skill_list_id = 707; -- Brain Spike - Delver (NM) - This ability is ONLY used by regular Cravers and not NM types. NMs use Impalement instead.


-- Uleguerand Range
INSERT IGNORE INTO mob_skill_lists VALUES ('Geush_special_attack',1200,1475); -- Auto-attack replacement that ignores shadows
INSERT IGNORE INTO mob_skill_lists VALUES ('Buffalo',57,1331); -- Counterstance
INSERT IGNORE INTO mob_skill_lists VALUES ('Black_Coney',1199,661); -- Snow Cloud
INSERT IGNORE INTO mob_skill_lists VALUES ('Black_Coney',1199,259); -- Whirl Claws
INSERT IGNORE INTO mob_skill_lists VALUES ('Black_Coney',1199,257); -- Foot Kick

-- New skill list for bats in Promathia and Aht Urhgan areas
INSERT IGNORE INTO mob_skill_lists VALUES ('Bats_other',504,393); -- Sonic boom
INSERT IGNORE INTO mob_skill_lists VALUES ('Bats_other',504,395); -- jet stream
INSERT IGNORE INTO mob_skill_lists VALUES ('Bats_other',504,1157); -- Slipstream
INSERT IGNORE INTO mob_skill_lists VALUES ('Bats_other',504,1158); -- Turbulence

-- BCNM 30 Dropping Like Flies
DELETE FROM mob_skill_lists WHERE skill_list_name = "FlyDark" and mob_skill_id = "660"; -- Huntfly should not cast Venom

-- BLU AF3
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1963);
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1964);
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1965);
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1966);
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1967);
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1968);
INSERT IGNORE INTO `mob_skill_lists` VALUES('Nepionic_Soulflayer', 238, 1969);


-- COR LB5
INSERT IGNORE INTO mob_skill_lists VALUES ('Qultada',145,39); -- Qultada WS Spirits Within 
INSERT IGNORE INTO mob_skill_lists VALUES ('Qultada',145,34); -- Qultada WS red Lotus Blade
INSERT IGNORE INTO mob_skill_lists VALUES ('Qultada',145,33); -- Qultada WS burning blade
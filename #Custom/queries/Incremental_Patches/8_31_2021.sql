-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Please ANNOTATE WELL for a clear understanding of what the query is adding/changing/fixing.     --
--                           Overly detaling your query is NOT needed.                             --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
--        DO NOT RUN QUERIES ON THE LIVE SERVER BEFORE TESTING IN A ISOLATED DEV ENVIRONMENT       --
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------


-- -----------
-- GENERAL  --
-- -----------

UPDATE mob_groups SET HP = "25000" WHERE zoneid = 128 AND name = "Aspidochelone"; -- Adding proper total HPs https://www.youtube.com/watch?v=juBFwm5p9pM
UPDATE mob_groups SET HP = "10000" WHERE zoneid = 128 AND name = "Adamantoise"; -- Adding proper total HPs https://www.youtube.com/watch?v=fdAVUBtvziA

UPDATE mob_droplist SET itemRate = "50" WHERE itemID = "1195" AND dropType != 2  AND dropType != 4  AND dropID  = "193"; -- *flask_of_romaeve_spring_water* from *Aura_Pot* was *20*


UPDATE mob_droplist SET itemRate = "900" WHERE itemID = "12923" AND dropType != 2  AND dropType != 4  AND dropID  = "2008"; -- *jujitsu_sitabaki* from *Poisonhand_Gnadgad* was *913*
UPDATE mob_droplist SET itemRate = "100" WHERE itemID = "13728" AND dropType != 2  AND dropType != 4  AND dropID  = "2008"; -- *jujitsu_gi* from *Poisonhand_Gnadgad* was *81*

DELETE FROM guild_item_points WHERE itemid = 4162;
DELETE FROM guild_item_points WHERE itemid = 16432;

UPDATE mob_family_system SET system = Demon WHERE familyid = 224; -- Change Shadow Lord family system to "Demon" classification (currently unclassified)
UPDATE mob_family_system SET system = Demon WHERE familyid = 225; -- Change Shadow Lord family system to "Demon" classification (currently unclassified)
UPDATE mob_family_system SET system = Demon WHERE familyid = 361; -- Change Dynamis Lord family system to "Demon" classification (currently unclassified)

UPDATE mob_pools SET cmbDelay = 185 WHERE NAME = 'Shadow_Lord'; -- Faster attack speed to mimic era

-- CLUSTER FIX --
-- Fire Clusters
DELETE from mob_droplist WHERE itemID = "4104" AND dropType != 2  AND dropType != 4  AND dropID  = "831";
INSERT INTO `mob_droplist` VALUES(831, 0, 0, 1000, 4104, 1000); -- Fire Cluster 100%
INSERT INTO `mob_droplist` VALUES(831, 0, 0, 1000, 4104, 240); -- 2nd Fire Cluster 24%
INSERT INTO `mob_droplist` VALUES(831, 0, 0, 1000, 4104, 100); -- 3rd Fire Cluster 10%
DELETE from mob_droplist WHERE itemID = "4104" AND dropType != 2  AND dropType != 4  AND dropID  = "832";
INSERT INTO `mob_droplist` VALUES(832, 0, 0, 1000, 4104, 1000); -- Fire Cluster 100%
INSERT INTO `mob_droplist` VALUES(832, 0, 0, 1000, 4104, 240); -- 2nd Fire Cluster 24%
INSERT INTO `mob_droplist` VALUES(832, 0, 0, 1000, 4104, 100); -- 3rd Fire Cluster 10%

-- Ice Clusters
DELETE from mob_droplist WHERE itemID = "4105" AND dropType != 2  AND dropType != 4  AND dropID  = "1347";
INSERT INTO `mob_droplist` VALUES(1347, 0, 0, 1000, 4105, 1000); -- Ice Cluster 100%
INSERT INTO `mob_droplist` VALUES(1347, 0, 0, 1000, 4105, 240); -- 2nd Ice Cluster 24%
INSERT INTO `mob_droplist` VALUES(1347, 0, 0, 1000, 4105, 100); -- 3rd Ice Cluster 10%

-- Wind Clusters
DELETE from mob_droplist WHERE itemID = "4106" AND dropType != 2  AND dropType != 4  AND dropID  = "38";
INSERT INTO `mob_droplist` VALUES(38, 0, 0, 1000, 4106, 1000); -- Wind Cluster 100%
INSERT INTO `mob_droplist` VALUES(38, 0, 0, 1000, 4106, 240); -- 2nd Wind Cluster 24%
INSERT INTO `mob_droplist` VALUES(38, 0, 0, 1000, 4106, 100); -- 3rd Wind Cluster 10%
DELETE from mob_droplist WHERE itemID = "4106" AND dropType != 2  AND dropType != 4  AND dropID  = "39";
INSERT INTO `mob_droplist` VALUES(39, 0, 0, 1000, 4106, 1000); -- Wind Cluster 100%
INSERT INTO `mob_droplist` VALUES(39, 0, 0, 1000, 4106, 240); -- 2nd Wind Cluster 24%
INSERT INTO `mob_droplist` VALUES(39, 0, 0, 1000, 4106, 100); -- 3rd Wind Cluster 10%
DELETE from mob_droplist WHERE itemID = "4106" AND dropType != 2  AND dropType != 4  AND dropID  = "40";
INSERT INTO `mob_droplist` VALUES(40, 0, 0, 1000, 4106, 1000); -- Wind Cluster 100%
INSERT INTO `mob_droplist` VALUES(40, 0, 0, 1000, 4106, 240); -- 2nd Wind Cluster 24%
INSERT INTO `mob_droplist` VALUES(40, 0, 0, 1000, 4106, 100); -- 3rd Wind Cluster 10%

-- Earth Clusters
DELETE from mob_droplist WHERE itemID = "4107" AND dropType != 2  AND dropType != 4  AND dropID  = "733";
INSERT INTO `mob_droplist` VALUES(733, 0, 0, 1000, 4107, 1000); -- Earth Cluster 100%
INSERT INTO `mob_droplist` VALUES(733, 0, 0, 1000, 4107, 240); -- 2nd Earth Cluster 24%
INSERT INTO `mob_droplist` VALUES(733, 0, 0, 1000, 4107, 100); -- 3rd Earth Cluster 10%
DELETE from mob_droplist WHERE itemID = "4107" AND dropType != 2  AND dropType != 4  AND dropID  = "734";
INSERT INTO `mob_droplist` VALUES(734, 0, 0, 1000, 4107, 1000); -- Earth Cluster 100%
INSERT INTO `mob_droplist` VALUES(734, 0, 0, 1000, 4107, 240); -- 2nd Earth Cluster 24%
INSERT INTO `mob_droplist` VALUES(734, 0, 0, 1000, 4107, 100); -- 3rd Earth Cluster 10%
DELETE from mob_droplist WHERE itemID = "4107" AND dropType != 2  AND dropType != 4  AND dropID  = "735";
INSERT INTO `mob_droplist` VALUES(735, 0, 0, 1000, 4107, 1000); -- Earth Cluster 100%
INSERT INTO `mob_droplist` VALUES(735, 0, 0, 1000, 4107, 240); -- 2nd Earth Cluster 24%
INSERT INTO `mob_droplist` VALUES(735, 0, 0, 1000, 4107, 100); -- 3rd Earth Cluster 10%
DELETE from mob_droplist WHERE itemID = "4107" AND dropType != 2  AND dropType != 4  AND dropID  = "736";
INSERT INTO `mob_droplist` VALUES(736, 0, 0, 1000, 4107, 1000); -- Earth Cluster 100%
INSERT INTO `mob_droplist` VALUES(736, 0, 0, 1000, 4107, 240); -- 2nd Earth Cluster 24%
INSERT INTO `mob_droplist` VALUES(736, 0, 0, 1000, 4107, 100); -- 3rd Earth Cluster 10%

-- Lightning Clusters
DELETE from mob_droplist WHERE itemID = "4108" AND dropType != 2  AND dropType != 4  AND dropID  = "2410";
INSERT INTO `mob_droplist` VALUES(2410, 0, 0, 1000, 4108, 1000); -- Lightning Cluster 100%
INSERT INTO `mob_droplist` VALUES(2410, 0, 0, 1000, 4108, 240); -- 2nd Lightning Cluster 24%
INSERT INTO `mob_droplist` VALUES(2410, 0, 0, 1000, 4108, 100); -- 3rd Lightning Cluster 10%
DELETE from mob_droplist WHERE itemID = "4108" AND dropType != 2  AND dropType != 4  AND dropID  = "2411";
INSERT INTO `mob_droplist` VALUES(2411, 0, 0, 1000, 4108, 1000); -- Lightning Cluster 100%
INSERT INTO `mob_droplist` VALUES(2411, 0, 0, 1000, 4108, 240); -- 2nd Lightning Cluster 24%
INSERT INTO `mob_droplist` VALUES(2411, 0, 0, 1000, 4108, 100); -- 3rd Lightning Cluster 10%
DELETE from mob_droplist WHERE itemID = "4108" AND dropType != 2  AND dropType != 4  AND dropID  = "2412";
INSERT INTO `mob_droplist` VALUES(2412, 0, 0, 1000, 4108, 1000); -- Lightning Cluster 100%
INSERT INTO `mob_droplist` VALUES(2412, 0, 0, 1000, 4108, 240); -- 2nd Lightning Cluster 24%
INSERT INTO `mob_droplist` VALUES(2412, 0, 0, 1000, 4108, 100); -- 3rd Lightning Cluster 10%
DELETE from mob_droplist WHERE itemID = "4108" AND dropType != 2  AND dropType != 4  AND dropID  = "2413";
INSERT INTO `mob_droplist` VALUES(2413, 0, 0, 1000, 4108, 1000); -- Lightning Cluster 100%
INSERT INTO `mob_droplist` VALUES(2413, 0, 0, 1000, 4108, 240); -- 2nd Lightning Cluster 24%
INSERT INTO `mob_droplist` VALUES(2413, 0, 0, 1000, 4108, 100); -- 3rd Lightning Cluster 10%

-- Water Clusters
DELETE from mob_droplist WHERE itemID = "4109" AND dropType != 2  AND dropType != 4  AND dropID  = "2629";
INSERT INTO `mob_droplist` VALUES(2629, 0, 0, 1000, 4109, 1000); -- Water Cluster 100%
INSERT INTO `mob_droplist` VALUES(2629, 0, 0, 1000, 4109, 240); -- 2nd Water Cluster 24%
INSERT INTO `mob_droplist` VALUES(2629, 0, 0, 1000, 4109, 100); -- 3rd Water Cluster 10%
DELETE from mob_droplist WHERE itemID = "4109" AND dropType != 2  AND dropType != 4  AND dropID  = "2630";
INSERT INTO `mob_droplist` VALUES(2630, 0, 0, 1000, 4109, 1000); -- Water Cluster 100%
INSERT INTO `mob_droplist` VALUES(2630, 0, 0, 1000, 4109, 240); -- 2nd Water Cluster 24%
INSERT INTO `mob_droplist` VALUES(2630, 0, 0, 1000, 4109, 100); -- 3rd Water Cluster 10%
DELETE from mob_droplist WHERE itemID = "4109" AND dropType != 2  AND dropType != 4  AND dropID  = "2631";
INSERT INTO `mob_droplist` VALUES(2631, 0, 0, 1000, 4109, 1000); -- Water Cluster 100%
INSERT INTO `mob_droplist` VALUES(2631, 0, 0, 1000, 4109, 24); -- 2nd Water Cluster 24%
INSERT INTO `mob_droplist` VALUES(2631, 0, 0, 1000, 4109, 100); -- 3rd Water Cluster 10%

-- Light Clusters
DELETE from mob_droplist WHERE itemID = "4110" AND dropType != 2  AND dropType != 4  AND dropID  = "1521";
INSERT INTO `mob_droplist` VALUES(1521, 0, 0, 1000, 4110, 1000); -- Light Cluster 100%
INSERT INTO `mob_droplist` VALUES(1521, 0, 0, 1000, 4110, 240); -- 2nd Light Cluster 24%
INSERT INTO `mob_droplist` VALUES(1521, 0, 0, 1000, 4110, 100); -- 3rd Light Cluster 10%

-- Dark Clusters
DELETE from mob_droplist WHERE itemID = "4111" AND dropType != 2  AND dropType != 4  AND dropID  = "568";
INSERT INTO `mob_droplist` VALUES(568, 0, 0, 1000, 4111, 1000); -- Dark Cluster 100%
INSERT INTO `mob_droplist` VALUES(568, 0, 0, 1000, 4111, 240); -- 2nd Dark Cluster 24%
INSERT INTO `mob_droplist` VALUES(568, 0, 0, 1000, 4111, 100); -- 3rd Dark Cluster 10%

INSERT IGNORE INTO item_mods VALUES(16506,431,1); -- Stun Kukri
INSERT IGNORE INTO item_mods VALUES(17614,431,1); -- Stun Kukri +1
INSERT IGNORE INTO item_mods VALUES(16432,431,1); -- Stun Jamadhars
INSERT IGNORE INTO item_mods VALUES(17484,431,1); -- Stun Jamadhars +1
INSERT IGNORE INTO item_mods VALUES(16503,431,1); -- Stun Knife
INSERT IGNORE INTO item_mods VALUES(17600,431,1); -- Stun Knife +1
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

UPDATE bcnm_info SET rules = 20 WHERE name = "shattering_stars"; -- No Exp loss when you die to Maat

UPDATE mob_groups SET HP = 11500 WHERE name = "Sewer_Syrup" and zoneid = 167; -- Hp increase
UPDATE mob_spawn_points SET pos_x = -21.04, pos_y = 0.9251, pos_z = -340.1736, pos_rot = 127 WHERE mobid = "17461307";

UPDATE mob_pools SET cmbSkill = 6, cmbDelay = 210 WHERE name = "Alkyoneus"; -- Alky wrongfully had H2H skill, which somehow added an innate Hundred Fists bug under some conditions. Era reference video https://www.youtube.com/watch?v=3BpBRFamFxs
UPDATE mob_groups SET HP = 7000 WHERE name = "Orcish_Overlord" and zoneid = 150; -- Hard to find a reference video from era, but this mob should not have same HP values as regular mobs around its area
UPDATE mob_groups SET HP = 60000 WHERE name = "Overlord_Bakgodek" and zoneid = 150; -- Manually captured some HP vales from this video https://www.youtube.com/watch?v=RqVfLcm4PNE&t=20s. 1% seems to be around 600 hps.
UPDATE mob_pools SET skill_list_id = 189 WHERE name = "Overlord_Bakgodek"; -- He was previously using a skill list for Dynamis Orc. He was also missing Howl.

UPDATE mob_droplist SET itemRate = "750" WHERE itemID = "554" AND dropType != 2  AND dropType != 4  AND dropID  = "1932";
UPDATE mob_droplist SET itemRate = "1000" WHERE itemID = "751" AND dropType != 2  AND dropType != 4  AND dropID  = "1932";
UPDATE mob_droplist SET itemRate = "750" WHERE itemID = "1432" AND dropType != 2  AND dropType != 4  AND dropID  = "1932";

UPDATE mob_spawn_points SET pos_x = 0, pos_y = 0, pos_z = 0 WHERE mobid = "16986355"; -- Deactivating Hydra until reworked.
UPDATE nm_spawn_points SET pos_x = 0, pos_y = 0, pos_z = 0 WHERE mobid = "16986355"; -- Deactivating Hydra until reworked.

DELETE from mob_droplist WHERE itemID = "12362" AND dropType != 2  AND dropType != 4  AND dropID  = "1966"; -- *highlanders_targe* from *Overlord_Bakgodek*
INSERT INTO mob_droplist VALUES(1966,1,1,1000,12362,150); -- *highlanders_targe* from *Overlord_Bakgodek* was *190*. It now shares a loot spot with Nightmare Sword
DELETE from mob_droplist WHERE itemID = "17649" AND dropType != 2  AND dropType != 4  AND dropID  = "1966"; -- *nightmare_sword* from *Overlord_Bakgodek*
INSERT INTO mob_droplist VALUES(1966,1,1,1000,17649,850); -- *nightmare_sword* from *Overlord_Bakgodek* was *810*. It now shares a loot spot with highlanders_targe
UPDATE mob_droplist SET itemRate = "1000" WHERE itemID = "17928" AND dropType != 2  AND dropType != 4  AND dropID  = "1966"; -- *juggernaut* from *Overlord_Bakgodek* was *280*

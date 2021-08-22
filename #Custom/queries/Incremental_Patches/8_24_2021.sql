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


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

UPDATE mob_droplist SET itemRate = "900" WHERE itemID = "12923" AND dropType != 2  AND dropType != 4  AND dropID  = "2008"; -- *jujitsu_sitabaki* from *Poisonhand_Gnadgad* was *913*
UPDATE mob_droplist SET itemRate = "100" WHERE itemID = "13728" AND dropType != 2  AND dropType != 4  AND dropID  = "2008"; -- *jujitsu_gi* from *Poisonhand_Gnadgad* was *81*
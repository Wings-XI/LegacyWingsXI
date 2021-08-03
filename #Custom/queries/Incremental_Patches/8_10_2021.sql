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

UPDATE mob_skills SET mob_skill_aoe = 4 WHERE mob_skill_name = "jettatura" AND mob_skill_id = 577; -- Jettatura should be conal aoe


INSERT IGNORE INTO mob_skill_lists VALUES ('Qultada',145,39); -- Qultada WS Spirits Within 
INSERT IGNORE INTO mob_skill_lists VALUES ('Qultada',145,34); -- Qultada WS red Lotus Blade
INSERT IGNORE INTO mob_skill_lists VALUES ('Qultada',145,33); -- Qultada WS burning blade

UPDATE mob_groups SET HP = "3500" WHERE name = "Poisonhand_Gnadgad" and zoneid = "149"; -- Correct Poionshand from 1200hp to 3500hp
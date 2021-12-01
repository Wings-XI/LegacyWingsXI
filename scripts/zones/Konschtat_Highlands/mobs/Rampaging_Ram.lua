-----------------------------------
-- Area: Konschtat Highlands
--   NM: Rampaging Ram
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 205)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.STEELFLEECE_PH, 10, 75600) -- 21 hours
end

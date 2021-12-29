-----------------------------------
-- Area: Yughott Grotto (142)
--  Mob: Orcish Grunt
-- Note: PH for Ashmaker Gotblut
-----------------------------------
local ID = require("scripts/zones/Yughott_Grotto/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ASHMAKER_GOTBLUT_PH, 10, 3600) -- 1 hour minimum
end

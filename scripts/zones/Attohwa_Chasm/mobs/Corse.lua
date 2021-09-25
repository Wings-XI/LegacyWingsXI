-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Corse
-- Note: PH for Citipati
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CITIPATI_PH, 20, 10800) -- 3 Hours
end

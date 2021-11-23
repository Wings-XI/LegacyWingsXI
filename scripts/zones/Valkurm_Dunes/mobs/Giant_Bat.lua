-----------------------------------
-- Area: Valkurm Dunes (103)
--  Mob: Giant Bat
--  PH for Golden Bat
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GOLDEN_BAT_PH, 5, 3600) -- 1 hour minimum
end

-----------------------------------
-- Area: Grauberg [S]
--  Mob: Wivre
-- Note: PH for Vasiliceratops
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.VASILICERATOPS_PH, 10, 3600, true) -- 1 hour Vasiliceratops will spawn immediately rather than waiting for PH cooldown
end

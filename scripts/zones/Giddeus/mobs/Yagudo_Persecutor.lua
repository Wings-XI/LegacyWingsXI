-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Persecutor
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.JUU_DUZU_THE_WHIRLWIND_PH, 5, 3600) -- 1 hour minimum
end

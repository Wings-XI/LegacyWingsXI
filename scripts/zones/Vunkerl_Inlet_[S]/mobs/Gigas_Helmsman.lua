-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Gigas Helmsman
-- Note: PH for Pallas
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- 1 to 5 hour cooldown.  2 PH on 5 min timers.  20% chance to pop per PH.
    -- Wiki reports 1hour 15mins to 6 hours.
    tpz.mob.phOnDespawn(mob, ID.mob.PALLAS_PH, 20, math.random(3600, 18000)) 
end

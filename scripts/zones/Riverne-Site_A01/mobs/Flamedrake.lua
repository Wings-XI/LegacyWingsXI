-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Flamedrake
-- Note: PH for Aiatar
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.AIATAR_PH, 10, 75600) -- 21 hours
end

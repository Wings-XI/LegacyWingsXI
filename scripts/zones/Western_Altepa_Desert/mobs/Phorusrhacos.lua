-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Phorusrhacos
-- Note: PH for Picolaton
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.PICOLATON_PH, 10, 5400) -- 90 minute minimum
end

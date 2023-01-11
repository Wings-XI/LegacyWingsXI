-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Marid
-- Note: Place holder Mahishasura
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/behavior_spawn_chigoe") }

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    if tpz.mob.phOnDespawn(mob, ID.mob.MAHISHASURA_PH, 5, 10800) then -- 3 hours
    elseif tpz.mob.phOnDespawn(mob, ID.mob.GRAND_MARID1_PH, 5, 1800) then
    else
        tpz.mob.phOnDespawn(mob, ID.mob.GRAND_MARID2_PH, 5, 1800)
    end
end
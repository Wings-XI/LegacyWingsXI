-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Marid
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/behavior_spawn_chigoe") }

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GRAND_MARID1_PH, 5, 1800)
    tpz.mob.phOnDespawn(mob, ID.mob.GRAND_MARID2_PH, 5, 1800)
end
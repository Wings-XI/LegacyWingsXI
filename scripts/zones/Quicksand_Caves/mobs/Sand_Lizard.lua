-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Lizard
-- Note: PH for Nussknacker
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 817, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    if mob:getWeather() == tpz.weather.SAND_STORM or mob:getWeather() == tpz.weather.DUST_STORM then
        tpz.mob.phOnDespawn(mob, ID.mob.NUSSKNACKER_PH, 5, 5400) -- 90 minutes
    end
end

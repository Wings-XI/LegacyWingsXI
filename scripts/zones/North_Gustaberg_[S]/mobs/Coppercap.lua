-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Coppercap
-- Note: PH for Gloomanita
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg_[S]/IDs")
require("scripts/globals/mobs")
require("scripts/globals/zone")
require("scripts/globals/world")
-----------------------------------

function onZoneWeatherChange(weather)
    if weather == tpz.weather.RAIN or weather == tpz.weather.SQUALL then
        mob:addMod(tpz.mod.REGEN, 10)
    end
end

function onGameHour(zone)
    local hour = VanadielHour()
    if hour < 4 or hour >= 20 then
        mob:addMod(tpz.mod.REGAIN, 100)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GLOOMANITA_PH, 10, 3600) -- 1 hour
end

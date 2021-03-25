-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Coppercap
-- Note: PH for Gloomanita
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg_[S]/IDs")
require("scripts/globals/mobs")
require("scripts/globals/world")
-----------------------------------

function onMobSpawn(mob)
    updateRegen(mob)
    updateRegain(mob)
end

function onMobFight(mob)
    updateRegen(mob)
    updateRegain(mob)
end

function onMobRoam(mob)
    updateRegen(mob)
    updateRegain(mob)
end

function updateRegen(mob)
    if mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL then
        mob:addMod(tpz.mod.REGEN, 1)
    else
        mob:setMod(tpz.mod.REGEN, 0)
    end
end

function updateRegain(mob)
    local hour = VanadielHour()
    if hour < 4 or hour >= 20 then
        mob:addMod(tpz.mod.REGAIN, 10)
    elseif hour >= 4 or hour < 20 then
        mob:setMod(tpz.mod.REGAIN, 0)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GLOOMANITA_PH, 10, 3600) -- 1 hour
end

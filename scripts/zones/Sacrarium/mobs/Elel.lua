-----------------------------------
-- Area: Sacrarium
--   NM: Elel
-----------------------------------
require("scripts/globals/world")
-----------------------------------

function onMobRoam(mob)
    if not (mob:getWeather() == tpz.weather.DARKNESS or mob:getWeather() == tpz.weather.GLOOM) then
        DespawnMob(mob:getID())
    end
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end


--[[
--rebase code
-----------------------------------
mixins = { require("scripts/globals/world") }
-----------------------------------
local entity = {}

entity.onMobRoam(mob) = function(mob)
    if not (mob:getWeather() == xi.weather.DARKNESS or mob:getWeather() == xi.weather.GLOOM) then
        DespawnMob(mob:getID())
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity
]]--

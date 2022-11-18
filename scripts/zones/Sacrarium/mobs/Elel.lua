-----------------------------------
-- Area: Sacrarium
--   NM: Elel
--  POS: -100.618 -0.600 -2.194 28
--   ID: 16891948
-----------------------------------
require("scripts/globals/world")
-----------------------------------

function onMobRoam(mob)
    if not (mob:getWeather() == tpz.weather.GLOOM or mob:getWeather() == tpz.weather.DARKNESS) then
        DespawnMob(mob:getID())
    end
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 14400))
    mob:setLocalVar("cooldown", os.time() + mob:getRespawnTime()/1000)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no darkness weather and immediate despawn
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
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 14400))
    mob:setLocalVar("cooldown", os.time() + mob:getRespawnTime()/1000)
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no darkness weather and immediate despawn
end

return entity
]]--

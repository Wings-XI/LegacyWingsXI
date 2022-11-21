-----------------------------------
-- Area: Sacrarium
--   NM: Elel
--  POS: -100.618 -0.600 -2.194 28
--   ID: 16891948
-----------------------------------
require("scripts/globals/world")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("wasKilled", 0)
end

function onMobRoam(mob)
    local hour = VanadielHour()
    local isDark = (mob:getWeather() == tpz.weather.GLOOM or mob:getWeather() == tpz.weather.DARKNESS)
    local isNighttime = (hour < 4 or hour >= 20)

    if not isDark or not isNighttime then
        DespawnMob(mob:getID())
    end
end

function onMobFight(mob, target)
end

function onMobDisengage(mob)
    local hour = VanadielHour()
    local isDark = (mob:getWeather() == tpz.weather.GLOOM or mob:getWeather() == tpz.weather.DARKNESS)
    local isNighttime = (hour < 4 or hour >= 20)

    if not isDark or not isNighttime then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        mob:setLocalVar("wasKilled", 1)
    end
end

function onMobDespawn(mob)
    if mob:getLocalVar("wasKilled") == 1 then
        mob:setRespawnTime(math.random(7200, 14400))
        mob:setLocalVar("cooldown", os.time() + math.floor(mob:getRespawnTime()/1000))
    else
        mob:setLocalVar("preservePop", 1)
    end
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no darkness weather and immediate despawn

end
-----------------------------------
-- Area: Western Altepa Desert
--   NM: King Vinegarroon
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/world")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(72, 1)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobDrawIn(mob, target)
    mob:addTP(3000)
    mob:useMobAbility(({354,722,723})[math.random(1,3)])
    mob:addTP(3000)
    mob:useMobAbility(({353,279,720})[math.random(1,3)])
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 100})
end

function onMobDisengage(mob, weather)
    if not (mob:getWeather() == tpz.weather.DUST_STORM or mob:getWeather() == tpz.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.VINEGAR_EVAPORATOR)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(75600, 86400) -- 21h to 24h
    mob:setRespawnTime(respawn)
	SetServerVariable("KVRespawn",(os.time() + respawn))
    DisallowRespawn(KingVine:getID(), true)
end

function updateRegen(mob)
    local hour = VanadielHour()
    local regen = mob:getMod(tpz.mod.REGEN)

    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00
        if regen ~= 125 then
            mob:setMod(tpz.mod.REGEN, 125)
        end
    else
        if regen ~= 250 then
            mob:setMod(tpz.mod.REGEN, 250)
        end
    end
end

function onMobSpawn(mob)
    updateRegen(mob)
end

function onMobFight(mob)
    updateRegen(mob)
end

function onMobRoam(mob)
    updateRegen(mob)

    if not (mob:getWeather() == tpz.weather.DUST_STORM or mob:getWeather() == tpz.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end
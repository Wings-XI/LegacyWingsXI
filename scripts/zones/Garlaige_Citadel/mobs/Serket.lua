-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Serket
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SERKET_BREAKER)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
    mob:addMod(tpz.mod.DEF, -20)
    mob:addMod(tpz.mod.ACC, 20)
    mob:addMod(tpz.mod.ATT, 20)
    mob:setMod(tpz.mod.REGEN, 0)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(75600, 86400)  -- 21 to 24 hours
    mob:setRespawnTime(respawn)
	SetServerVariable("SerketRespawn",(os.time() + respawn))
end;

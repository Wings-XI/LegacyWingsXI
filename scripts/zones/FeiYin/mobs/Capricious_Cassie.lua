-----------------------------------
-- Area: Fei'Yin
--   NM: Capricious Cassie
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 1800)
    --mob:addMod(tpz.mod.ATTP, 20)
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.CASSIENOVA)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(75600,86400) -- 21-24 hours
    mob:setRespawnTime(respawn)
	SetServerVariable("CapriciousCassieRespawn",(os.time() + respawn))
end

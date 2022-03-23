-----------------------------------
-- Area: Rolanberry Fields (110)
--  HNM: Simurgh
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("SimMightyStrikesThreshhold",math.random(50,65))
    mob:setLocalVar("SimMightyStrikesUsed",0)
    mob:addMod(tpz.mod.EVA, 165)
    mob:addMod(tpz.mod.ACC, 185)
    mob:addMod(tpz.mod.MACC, 100)
    mob:addMod(tpz.mod.ATT, 50)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SIMURGH_POACHER)
end

function onMobFight(mob, target)
    if mob:getLocalVar("SimMightyStrikesUsed") == 0 and mob:getHPP() < mob:getLocalVar("SimMightyStrikesThreshhold") then
        mob:useMobAbility(688)
        mob:setLocalVar("SimMightyStrikesUsed",1)
    end
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(75600, 86400) -- 21h to 24h
    mob:setRespawnTime(respawn)
	SetServerVariable("SimurghRespawn",(os.time() + respawn))
end

-----------------------------------
-- Area: Sauromugue Champaign (120)
--  HNM: Roc
-----------------------------------

mixins =
{
    require("scripts/mixins/rage")
    --require("scripts/mixins/job_special")
}
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("RocBenedictionThreshhold",math.random(50,65))
    mob:setLocalVar("RocBenedictionUsed",0)
    mob:addMod(tpz.mod.EVA, 165)
    mob:addMod(tpz.mod.ACC, 185)
    mob:addMod(tpz.mod.MACC, 125)
    mob:addMod(tpz.mod.ATT, 150)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.ROC_STAR)
end

function onMobFight(mob, target)
    if mob:getLocalVar("RocBenedictionUsed") == 0 and mob:getHPP() < mob:getLocalVar("RocBenedictionThreshhold") then
        mob:useMobAbility(689)
        mob:setLocalVar("RocBenedictionUsed",1)
    end
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21h to 24h
    mob:setRespawnTime(respawn)
	SetServerVariable("RocRespawn",(os.time() + respawn))
end

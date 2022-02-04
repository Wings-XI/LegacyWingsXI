-----------------------------------
-- Area: Beadeaux [S] (92)
-- NM: Bres
-- !pos 179.322 39.503 13.407 92
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobEngaged(mob, target)
end

function onMobSpawn(mob)

    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 8000)
    mob:setMod(tpz.mod.MOVE, 20)
    mob:addMod(tpz.mod.DELAY, 1000)
    mob:addStatusEffect(tpz.effect.FOOTWORK, 100, 0, 0)
    --mob:addMod(tpz.mod.KICK_ATTACK_RATE, 100)
    --mob:addMod(tpz.mod.EXTRA_KICK_ATTACK, 100)
    --mob:addMod(tpz.mod.KICK_DMG, 100)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.HUNDRED_FISTS, 
                duration = 60, 
                hpp = 60 ,
                endCode = function(mob)
                    mob:setLocalVar("wait", os.time() + 2)
                end
            },
        },
    })
end

function onMobFight(mob, target)
    local hpp   = mob:getHPP()
    local boost_attack = mob:getLocalVar("boost_attack")
    local nextSkill = mob:getLocalVar("nextSkill")

    if hpp <= 50 and boost_attack == 0 then
        mob:setMod(tpz.mod.ATTP, 200)
        mob:setLocalVar('boost_attack', boost_attack + 1)
    end

    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) and nextSkill <= 9 then
        local roll = math.random(1,5)
        if os.time() > mob:getLocalVar("wait") and roll == 1 then
            local skill = 1033
            mob:useMobAbility(skill)
            mob:setLocalVar("nextSkill", nextSkill + 1)
            mob:setLocalVar("wait", os.time() + 2)
        end
    end

end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(36000)  -- 10h

    --UpdateNMSpawnPoint(mob:getID())
	--local respawn = 20  -- 10h
    --mob:setRespawnTime(respawn)
	--SetServerVariable("BresRespawn",(os.time() + respawn))
end

function onMobDeath(mob, player, isKiller)
end

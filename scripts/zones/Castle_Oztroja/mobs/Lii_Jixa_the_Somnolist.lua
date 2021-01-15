-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Lii Jixa the Somnolist
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 306)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT,200)
    mob:setMod(tpz.mod.LULLABYRESTRAIT,200)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT,200)
    mob:setMod(tpz.mod.BINDRESTRAIT,200)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 5400)) -- 60 to 90 minutes
end

function onMonsterMagicPrepare(mob)
    local roll = math.random()
    
    if mob:getHPP() < 80 and roll < 0.15 then
        return 3 -- cure 3
    elseif roll < 0.4 then
        return 29 -- banish 2
    else
        return 98 -- repose
    end
end
-----------------------------------
-- Area: Ranguemont Pass
--   NM: Mucoid Mass
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:setMod(tpz.mod.BLINDRES, 75)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.BLIND)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 345)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 6000)) -- 90 to 100 minutes
end
------------------------------
-- Area: Grauberg [S]
--   NM: Scitalis
-- mob ID: 17141979
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")

------------------------------

function onMobSpawn(mob, player, isKiller)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:addMod(tpz.mod.WIND_ABSORB, 100)
    mob:addMod(tpz.mod.SLEEPRES, 95)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO, {power = math.random(120, 130), chance = 10})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 503)
end

-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Pyuu the Spatemaker
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.SLEEPRES, 20)
    mob:setMod(tpz.mod.BINDRES, 20)
    mob:setMod(tpz.mod.GRAVITYRES, 20)
    mob:setMod(tpz.mod.SILENCERES, 100)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 364)
    tpz.regime.checkRegime(player, mob, 127, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end
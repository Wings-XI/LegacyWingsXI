------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Erle
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO, {chance = 50})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 512)
end

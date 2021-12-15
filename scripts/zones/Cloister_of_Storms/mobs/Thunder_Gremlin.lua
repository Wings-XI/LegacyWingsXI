-----------------------------------
-- Area: Cloister of Storms
--  Mob: Thunder Gremlin
-- Involved in Quest: Carbuncle's Debacle
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.MP_DRAIN, {chance = 60, power = math.random(1, 40)})
end

function onMobDeath(mob, player, isKiller)
end
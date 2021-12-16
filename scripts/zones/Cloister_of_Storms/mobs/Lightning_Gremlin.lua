-----------------------------------
-- Area: Cloister of Storms
--  Mob: Lightning Gremlin
-- Involved in Quest: Carbuncle's Debacle
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobWeaponSkillPrepare(mob, target)
    local whirl = 514
    if math.random() < 0.7 then -- Heavily favors Whirl of Rage
        return whirl
    else
        return 0
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TP_DRAIN, {chance = 60, power = math.random(1, 40)})
end

function onMobDeath(mob, player, isKiller)
end
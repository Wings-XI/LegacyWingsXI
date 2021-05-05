------------------------------
-- Area: Ranguemont Pass
--   NM: Hyakume
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.CURSE)
end

function onMobFight(mob,target)
    if mob:getHPP() < 25 then
        mob:addStatusEffect(tpz.effect.DREAD_SPIKES, 10, 0, 0)
        mob:getStatusEffect(tpz.effect.DREAD_SPIKES):setFlag(tpz.effectFlag.DEATH)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 344)
end

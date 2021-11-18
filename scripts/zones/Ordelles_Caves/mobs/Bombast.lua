------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 45, 0, 0)
    mob:getStatusEffect(tpz.effect.BLAZE_SPIKES):setFlag(tpz.effectFlag.DEATH)
end

function onSpikesDamage(mob, target, damage)
    local INT_diff = mob:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    if INT_diff > 20 then
        INT_diff = 20 + (INT_diff - 20) * 0.5 -- INT above 20 is half as effective.
    end

    local dmg = (damage + INT_diff) * 2 -- INT adjustment and base damage averaged together.
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, tpz.magic.ele.FIRE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, tpz.magic.ele.FIRE, 0)
    dmg = adjustForTarget(target, dmg, tpz.magic.ele.FIRE)
    dmg = finalMagicNonSpellAdjustments(mob, target, tpz.magic.ele.FIRE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return tpz.subEffect.BLAZE_SPIKES, tpz.msg.basic.SPIKES_EFFECT_DMG, dmg
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 182)
end

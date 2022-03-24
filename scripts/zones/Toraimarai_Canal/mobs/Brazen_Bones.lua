------------------------------
-- Area: Toraimarai Canal
--   NM: Brazen Bones
------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/rage")}
------------------------------

-- TODO: 
--  - Confirm spawn coordinates
--  - Confirm ice spikes damage and undispelable
--  - Confirm enblizzard undispelable

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(tpz.effect.ICE_SPIKES, 45, 0, 0)
    mob:getStatusEffect(tpz.effect.ICE_SPIKES):setFlag(tpz.effectFlag.DEATH)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.ICEDEF, 256)
    mob:setMod(tpz.mod.ICERES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 100)
    mob:setMod(tpz.mod.BINDRES, 100)
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
    dmg = addBonusesAbility(mob, tpz.magic.ele.ICE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, tpz.magic.ele.ICE, 0)
    dmg = adjustForTarget(target, dmg, tpz.magic.ele.ICE)
    dmg = finalMagicNonSpellAdjustments(mob, target, tpz.magic.ele.ICE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return tpz.subEffect.ICE_SPIKES, tpz.msg.basic.SPIKES_EFFECT_DMG, dmg
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENBLIZZARD)
end

function onMobFight(mob, target)
    -- Double Attack rate increases as HP decreases
    local DA = (100 - mob:getHPP()) * 0.5
    if mob:getMod(tpz.mod.DOUBLE_ATTACK) ~= utils.clamp(DA, 1, 100) then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, utils.clamp(DA, 1, 100))
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 286)
end

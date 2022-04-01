---------------------------------------------
-- Divine Malison
--
-- Used by Shantotto in ASA13 Project: Shantottofication
-- Notes: Deals AOE Light elemental damage. Additional Effect: Silence, Stun, Plague
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.LIGHT, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    if (dmg > 0) then
        local resistSilence = applyResistanceAddEffect(mob, target, tpz.magic.ele.WIND, 0)
        local resistPlague = applyResistanceAddEffect(mob, target, tpz.magic.ele.FIRE, 0)
        local resistStun = applyResistanceAddEffect(mob, target, tpz.magic.ele.LIGHTNING, 0)
        if not target:hasStatusEffect(tpz.effect.SILENCE) and resistSilence >= 0.5 then
            local duration = 180 * resistSilence
            target:addStatusEffect(tpz.effect.SILENCE, 1, 0, duration)
        end
        if not target:hasStatusEffect(tpz.effect.PLAGUE) and resistPlague >= 0.5 then
            local duration = 180 * resistPlague
            target:addStatusEffect(tpz.effect.PLAGUE, 1, 0, duration)
        end
        if not target:hasStatusEffect(tpz.effect.STUN) and resistStun >= 0.5 then
            local duration = 10 * resistStun
            target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
        end
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return dmg
end

---------------------------------------------
-- Salvation Scythe
--
-- Used by Domina Shantotto in ASA13 Project: Shantottofication
-- Notes: Deals AOE Darkness elemental damage. Additional Effect: Poison, Paralyze, Slow, Bio.
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
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*3,tpz.magic.ele.DARK,dmgmod,TP_MAB_BONUS,1)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,tpz.attackType.MAGICAL,tpz.damageType.DARK,MOBPARAM_WIPE_SHADOWS)

    if (dmg > 0) then
        local resistPoison = applyResistanceAddEffect(mob, target, tpz.magic.ele.WATER, 0)
        local resistPara = applyResistanceAddEffect(mob, target, tpz.magic.ele.ICE, 0)
        local resistSlow = applyResistanceAddEffect(mob, target, tpz.magic.ele.EARTH, 0)
        local resistBio = applyResistanceAddEffect(mob, target, tpz.magic.ele.DARK, 0)
        if not target:hasStatusEffect(tpz.effect.POISON) and resistPoison >= 0.5 then
            local duration = 180 * resistPoison
            target:addStatusEffect(tpz.effect.POISON, 20, 0, duration)
        end
        if not target:hasStatusEffect(tpz.effect.PARALYSIS) and resistPara >= 0.5 then
            local duration = 180 * resistPara
            target:addStatusEffect(tpz.effect.PARALYSIS, 50, 0, duration)
        end
        if not target:hasStatusEffect(tpz.effect.SLOW) and resistSlow >= 0.5 then
            local duration = 180 * resistSlow
            target:addStatusEffect(tpz.effect.SLOW, 1000, 0, duration)
        end
        if not target:hasStatusEffect(tpz.effect.BIO) and resistBio >= 0.5 then
            local duration = 180 * resistBio
            target:addStatusEffect(tpz.effect.BIO, 9, 0, duration)
        end
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return dmg
end

---------------------------------------------
--  Typhoon Wing
--
--  Description: Deals darkness damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:hasStatusEffect(tpz.effect.INVINCIBLE) then
       return 1
    elseif (mob:AnimationSub() == 1) then
        return 1
    elseif (target:isBehind(mob, 48) == true) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typhoonMultiplier = mob:getLocalVar("savageDmgMultipliers")
    if typhoonMultiplier == 1 then
        typhoonMultiplier = 1.75
    else
        typhoonMultiplier = 4
    end

    local typeEffect = tpz.effect.BLINDNESS
    local dmgmod = typhoonMultiplier
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    MobStatusEffectMove(mob, target, typeEffect, 60, 0, 30)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    
    return dmg
end

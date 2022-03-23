---------------------------------------------
-- Bai Wing
--
-- Description: A dust storm deals Earth damage to enemies within a very wide area of effect. Additional effect: Slow
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 30' radial.
-- Notes: Used only by Ouryu and Cuelebre while flying.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() ~= 1 then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local baiwingMultiplier = mob:getLocalVar("savageDmgMultipliers")
    
    if baiwingMultiplier == 1 then
        baiwingMultiplier = 3.5
    else
        baiwingMultiplier = 5
    end

    local dmgmod = baiwingMultiplier
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
    MobStatusEffectMove(mob, target, tpz.effect.SLOW, 6000, 0, 120)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)

    return dmg
end

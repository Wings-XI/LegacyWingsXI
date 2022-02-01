---------------------------------------------
--  Impulsion
--
--  Description: Deals heavy magical damage to enemies within an area of effect. Additional effects: Petrification, Blind, and Knockback
--  Type: Magical 
--  Utsusemi/Blink absorb: Wipes Shadows
--  Note: Used by Bahamut in The Wyrmking Descends
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else       
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)

    local typeEffect1 = tpz.effect.PETRIFICATION
    local typeEffect2 = tpz.effect.BLINDNESS
    MobStatusEffectMove(mob, target, typeEffect1, 1, 0, 30)
    MobStatusEffectMove(mob, target, typeEffect2, 15, 0, 60)

    return dmg
end

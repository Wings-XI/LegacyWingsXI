---------------------------------------------
--  Torrential Torment
--  Subjects nearby targets to water torture. Additional effect: Strips all equipment.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes Shadows
--  Range: Uknown Radial
--  Notes: Used by Yovra Family
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    for i = tpz.slot.MAIN, tpz.slot.BACK do
        target:unequipItem(i)
    end
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end

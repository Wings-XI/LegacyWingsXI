---------------------------------------------
--  Mighty Snort
--
--  Deals Wind damage to targets in a fan-shaped area of effect. Additional effect: Hate reset
--  Type: Magical (Wind)
--  Only used by certain Buffalo NMs
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, tpz.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    mob:resetEnmity(target)
    return dmg
end

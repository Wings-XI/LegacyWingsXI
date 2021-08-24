-----------------------------------------
-- Meteor
-- Deals non-elemental damage to an enemy.
-- Used exclusively by Chlevnik
-----------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 4.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    return dmg

end

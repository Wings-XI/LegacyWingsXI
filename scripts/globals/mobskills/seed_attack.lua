---------------------------------------------
--  Seed Crystal's basic attack
--
--  Description: This is Seed Crystal's basic attack.
--  Type: Physical
--
--
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
    local basedmg = math.random(90, 150)
    local info = MobMagicalMove(mob, target, skill, basedmg, tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    skill:setMsg(tpz.msg.basic.HIT_DMG)

    return dmg
end

---------------------------------------------
--  Seed of Judgement
--
--  Description: Massive AoE damage (700-1300)
--  Type: Magical
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
    local dmgmod = 2
    local rnddmg = math.random(700, 1300)
    local info = MobMagicalMove(mob, target, skill, rnddmg, tpz.magic.ele.NONE, 1, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_1_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    return dmg
end

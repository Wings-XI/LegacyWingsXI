---------------------------------------------
--  Choke Breath
--
--  Description: Damages enemies in a fan-shaped area of effect. Additional effect: Paralysis & Silence
--  Type: Magical
--
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
    local typeEffectOne = tpz.effect.PARALYSIS
    local typeEffectTwo = tpz.effect.SILENCE

    MobStatusEffectMove(mob, target, typeEffectOne, 1, 0, 60)
    MobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, 60)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2.5, tpz.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    return dmg
end

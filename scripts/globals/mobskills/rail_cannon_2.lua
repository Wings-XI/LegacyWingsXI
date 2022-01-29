---------------------------------------------------
-- Rail Cannon 2 gears
-- 2 Gears: Rail Cannon is directional (fan-shaped) AoE and ignores Utsusemi
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 2.0
    local wDmgMod = 3.1
    
    -- With no innate MATT the rail cannon damage formula becomes roughly dmgmod * mob:getWeaponDmg() * wDmgMod * (1.3 to .7 depending on target mdef)
    -- With a paltry 45 int - Archaic Gears have abysmal macc vs a 75 bst and via captures this move rarely resists
    -- To compensate an additional macc bonus is being added
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*wDmgMod, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT, 0, 200)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)
    target:delHP(dmg)

    MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 30)

    return dmg
end

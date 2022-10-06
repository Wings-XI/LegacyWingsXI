-----------------------------------
--  Ice Guillotine
--
--  Description: Bites at all targets in front. Additional effect: Max HP Down.
--  Type: Physical (piercing)
--  Utsusemi/Blink absorb: 2 shadows
--  Range: Front conal (7 yalms)
--  Notes: Scylla exclusive, this skill is not used on its own and will always come after Frozen Mist.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.MAX_HP_DOWN, 50, 0, 120)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
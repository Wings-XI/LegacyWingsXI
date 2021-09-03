---------------------------------------------------
-- Tornado Edge
-- Deals wind damageVerification Needed to targets in front of the user. Additional effects: Max HP Down, Max MP Down, Max TP Down
-- Effect Reduces HP by 50%, MP by 50% and reduces max TP to 100%.
-- Each debuff assigned to one of the 3 hits. It is possible to avoid a status by having a shadow absorb part of the attack. IE: If only 1 hit lands, whichever status goes with that hit will be applied.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,tpz.attackType.PHYSICAL,tpz.damageType.BLUNT,info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.MAX_HP_DOWN, 0, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 50, 0, 30)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    return dmg
end

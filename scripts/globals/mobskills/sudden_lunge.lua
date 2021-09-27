---------------------------------------------
-- Sudden Lunge
-- Knockback damage and Stun effect. Ignores Utsusemi, reduces Ladybug's HP by 5%-15% whether it hits or not.
-- Ignores Shadows
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_IGNORE_SHADOWS)

    local typeEffect = tpz.effect.STUN
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    local currentHP = mob:getHP()
    local newHP = currentHP - (currentHP * (math.random(5,15)/100))
    mob:setHP(newHP)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
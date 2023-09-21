-----------------------------------
--  Sub-Zero Smash
--
--  Description: Additional Effect: Paralysis. Damage varies with TP.
--  Type: Physical (blunt)
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Rear conal (7 yalms)
--  Notes: This move can be used at any time, even if no one is standing behind.
-- "I Just learned this solo ,6th fight Ruszor used Sub-Zero Smash twice while I was in front of it. Learned in 6 kills total. 12/5/2012"
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    -- chance if target is not behind mob to use it anyway
    if math.random(1,10) <= 6 and not target:isBehind(mob, 48) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local dmgmod = 1
    local accmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 1.5, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.PARALYSIS, 10, 0, 100)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    if dmg > 0 and skill:getMsg() ~= 31 then
        target:tryInterruptSpell(mob, info.hitslanded)
    end

    return dmg
end
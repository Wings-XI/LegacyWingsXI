---------------------------------------------
--  Lateral Slash
--
--  Description: Laterally slashes a single target. Additional effect: Defense Down or triggers an animation with no effect - dependent on mob Family
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes: Reduces defense by 75%.  Can be removed with Monk Job Ability Counterstance.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- Dolls for "A Reputation In Ruins" quest and Galarhigg in "Purple, the new black" only use this skill for an animation
    -- Remember if you find a mob using mobskill 603 to update this line - or the skill will execute
    -- If a mob using skill 603 for animation is actually part of the tonberry families, perhaps use mobID
    if mob:getFamily() == 83 or mob:getFamily() == 84 or mob:getFamily() == 271 or mob:getFamily() == 87 then
        skill:setMsg(tpz.msg.basic.NONE)
        return 0
    end

    local numhits = 1
    local accmod = 2
    local dmgmod = 2.7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    local typeEffect = tpz.effect.DEFENSE_DOWN
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 75, 0, 60)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end

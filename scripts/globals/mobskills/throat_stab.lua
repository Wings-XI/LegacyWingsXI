---------------------------------------------
--  Throat Stab
--
--  Description: Deals damage to a single target reducing their HP to 5%. Resets enmity.  or triggers an animation with no effect - dependent on mob Family
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
--  Notes: Very short range, easily evaded by walking away from it.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
require("scripts/globals/msg")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- Dolls for "A Reputation In Ruins" quest and Galarhigg in "Purple, the new black" only use this skill for an animation
    -- Remember if you find a mob using mobskill 604 to update this line with the mob family - or the skill will execute
    -- If a mob using skill 604 for animation is actually part of the tonberry families, perhaps use mobID
    if mob:getFamily() == 83 or mob:getFamily() == 84 or mob:getFamily() == 271 or mob:getFamily() == 87 or mob:getID() == 16875778 then 
        skill:setMsg(tpz.msg.basic.NONE)
        return 0
    end
	
    local currentHP = target:getHP()
    -- remove all by 5%
    local damage = 0

    -- if have more hp then 30%, then reduce to 5%
    if (currentHP / target:getMaxHP() > 0.2) then
        damage = currentHP * .95
    else
        -- else you die
        damage = currentHP
    end
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    mob:resetEnmity(target)
    return dmg
end

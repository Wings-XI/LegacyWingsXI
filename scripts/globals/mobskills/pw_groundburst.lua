---------------------------------------------
-- Groundburst
--
-- Description: Expels a fireball on targets in an area of effect.
-- Type: Physical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: Unknown radial
-- Notes: Only used by notorious monsters, and from any Mamool Ja in besieged.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 1863) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
	if math.random()*100 < target:getGuardRate(mob) then
		skill:setMsg(tpz.msg.basic.SKILL_MISS)
		target:trySkillUp(mob, tpz.skill.GUARD, numhits)
		return 0
	end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end

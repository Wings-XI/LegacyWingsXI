---------------------------------------------
-- Radiant Sacrament
-- Description: Used at regular intervals as a ranged attack when target is out of melee range.
-- Type: Physical
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 20' maximum distance, unknown smaller radial (around target)
-- Notes: Alexander generally uses this on targets out of his melee range. Accompanied by text
-- "Offer thy worship...
-- I shall burn away...thy transgressions..."
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 5
    local dmgmod = 2
	if math.random()*100 < target:getGuardRate(mob) then
		skill:setMsg(tpz.msg.basic.SKILL_MISS)
		target:trySkillUp(mob, tpz.skill.GUARD, numhits)
		return 0
	end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    MobStatusEffectMove(mob, target, tpz.effect.MAGIC_DEF_DOWN, 20, 0, 60) -- Needs adjusted to retail values for power/duration

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end

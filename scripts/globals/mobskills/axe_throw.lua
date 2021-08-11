---------------------------------------------
--
-- axe throw (axe wielding Mamool Ja only!)
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- If animationSub is 1, mob has already lost the axe. If zero, still has axe.
    if mob:AnimationSub() == 1 then
        return 1
    else
        return 0
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
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    mob:timer(2000, function(mob) mob:AnimationSub(1) end) -- Mob loses Axe on using Axe Throw
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end

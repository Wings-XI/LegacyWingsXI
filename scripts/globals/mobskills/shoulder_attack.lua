---------------------------------------------------
-- Shoulder Attack
-- Deals damage to a single target. Additional effect: knockback
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    -- KNOCKBACK -------------------

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.4
    if mob:getID() == 17391803 then -- Overlord_Bakgodek
        accmod = 1.5
        dmgmod = 2.7
    end

    if math.random()*100 < target:getGuardRate(mob) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        target:trySkillUp(mob, tpz.skill.GUARD, numhits)
        return 0
    end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end

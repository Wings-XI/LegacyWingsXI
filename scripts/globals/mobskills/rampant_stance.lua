---------------------------------------------------
-- Rampant Stance
-- Physical area of effect damage that inflicts stun.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if  mob:AnimationSub() == 1 or mob:getLocalVar("charging") == 1 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- Dark Ixion doesn't hit himself with AoE mobskills
    if target:getPool() ~= nil and target:getPool() == 915 then
        skill:setMsg(0)
        return
    end
    local numhits = 3
    local accmod = 2
    local dmgmod = 1 

    local typeEffect = tpz.effect.STUN
    local duration = math.random(1, 3)

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, duration)
    
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    
    return dmg
end

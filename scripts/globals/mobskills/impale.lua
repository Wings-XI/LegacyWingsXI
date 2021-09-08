---------------------------------------------
--  Impale
--
--  Description: Deals damage to a single target. Additional effect: Paralysis (NM version AE applies a strong poison effect and resets enmity on target)
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow (NM version ignores shadows)
--  Range: Melee
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local shadows = info.hitslanded

    if mob:isMobType(MOBTYPE_NOTORIOUS) then
        shadows = MOBPARAM_IGNORE_SHADOWS
        typeEffect = tpz.effect.POISON
        mob:resetEnmity(target)
    end
    
    local dmg = 0
    
    if mob:getID() == 17613130 then -- cap. cassie
        local eff1 = MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 60)
        local eff2 = MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 50, 0, 60)
        local eff3 = MobStatusEffectMove(mob, target, tpz.effect.POISON, 50, 3, 60)
        
        if target:hasStatusEffect(tpz.effect.POISON) and (target:getStatusEffect(tpz.effect.POISON)):getPower() < 50 then
            target:addStatusEffect(tpz.effect.POISON, 50, 3, 60)
            eff3 = tpz.msg.basic.SKILL_ENFEEB_IS
        end
        
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB)
        if eff1 == tpz.msg.basic.SKILL_ENFEEB_IS then
            return tpz.effect.BIND
        elseif eff2 == tpz.msg.basic.SKILL_ENFEEB_IS then
            return tpz.effect.WEIGHT
        elseif eff3 == tpz.msg.basic.SKILL_ENFEEB_IS then
            return tpz.effect.POISON
        end
        
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return 0
    else
        dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, shadows)
        MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 120)
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
		if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
        return dmg
    end
    
    return dmg
end

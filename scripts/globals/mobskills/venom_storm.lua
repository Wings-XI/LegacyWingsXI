---------------------------------------------
--
-- Venom Storm
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magicburst")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON
    
    skill:setMsg(tpz.msg.basic.SKILL_MISS)
    
    local statmod = tpz.mod.INT
    local element = mob:getStatusEffectElement(typeEffect)
    local resist = applyPlayerResistance(mob,typeEffect,target,mob:getStat(statmod)-target:getStat(statmod),0,element)

    if (resist >= 0.25) then
        
        if target:hasStatusEffect(typeEffect) == true then
            target:delStatusEffect(typeEffect)
        end

        if target:addStatusEffect(typeEffect, math.random(20,30), 3, 60*resist) == true then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
        
    end
    
    return typeEffect
end

---------------------------------------------
-- Absolute Terror
-- Causes Terror, which causes the victim to be stunned for the duration of the effect, this can not be removed.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
        return 1
    elseif mob:hasStatusEffect(tpz.effect.SUPER_BUFF) then
        return 1
    elseif mob:hasStatusEffect(tpz.effect.INVINCIBLE) then
        return 1
    elseif mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    elseif mob:AnimationSub() == 1 then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local power = 30
    -- Three minutes is WAY too long, especially on Wyrms. Reduced to Wiki's definition of 'long time'. Reference: http://wiki.ffxiclopedia.org/wiki/Absolute_Terror
    local duration
    if skill:isAoE() then
        duration = math.random(10,18) -- Found video that shows 18s
    else
        duration = 10 + math.random(0,40)
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect

end

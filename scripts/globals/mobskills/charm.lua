---------------------------------------------
-- Charm
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CHARM_I
    local power = 0
    local msg = 0

    if (not target:isPC()) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return typeEffect
    end

    if mob:getID() == 16896161 then
        msg = MobStatusEffectMove(mob, target, typeEffect, power, 3, math.random(5, 10))
    else
        msg = MobStatusEffectMove(mob, target, typeEffect, power, 3, 150)
    end

    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        mob:charm(target)
        mob:resetEnmity(target)
    end
    skill:setMsg(msg)

    return typeEffect

    
end

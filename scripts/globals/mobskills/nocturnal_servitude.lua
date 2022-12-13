---------------------------------------------
-- Nocturnal Servitude
-- Charms target and transforms them into a bat.
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
    if (target:isFacing(mob)) then
        if (not target:isPC()) then
            skill:setMsg(tpz.msg.basic.SKILL_MISS)
            return typeEffect
        end

        local msg = MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
        if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
            target:addStatusEffect(tpz.effect.COSTUME_II, 256, 0, 60) 
            mob:charm(target)
            mob:resetEnmity(target)
        end
        skill:setMsg(msg)

        return typeEffect
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
end

---------------------------------------------
-- Heat Wave
-- Burns opponents in an area of effect
--
-- Note: I do not know of any mob other than Reacton that uses this skill
--       but should it ever happen, I've defaulted the damage to the same
--       damage formula used by the similar 'Cold Wave' skill.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- Reacton cannot use this skill before phase 2
    if mob:getID() == 17031599 and mob:AnimationSub() < 1 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BURN
    local potency = ( mob:getMainLvl() / 5 * 0.6 + 6 )

    -- Reacton does a 40dmg per tick
    if mob:getID() == 17031599 then
        potency = 40
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, potency, 0, 120))
    return typeEffect
end
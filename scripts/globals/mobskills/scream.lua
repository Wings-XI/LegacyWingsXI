---------------------------------------------
-- Scream
-- 15' Reduces MND of players in area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MND_DOWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 10, 3, 120))
    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.TERROR, 1, 0, math.random(5, 8))
    end

    return typeEffect
end

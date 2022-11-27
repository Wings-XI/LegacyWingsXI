---------------------------------------------
-- Souleater
-- Souleater Ability.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0, 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SOULEATER
    local power = 12
    local duration = 60

    

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    mob:addStatusEffect(tpz.effect.SOULEATER, power, 0, 60)
    return typeEffect
end
---------------------------------------------
-- Sticky Thread
-- Inflicts slow on targets in a fan-shaped area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLOW

    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        local dMND =  mob:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
        local power = utils.clamp(math.floor((dMND + 20) * 204 / 10) + 1466, 1466, 3510)
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, 120))
    else
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 140, 0, 120))
    end

    return typeEffect
end

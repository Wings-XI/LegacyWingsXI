---------------------------------------------
-- Cocoon
-- Enhances defense.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_BOOST
    local zone = mob:getZone()
    local power = 50
    
    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        power = 300
    end

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, 60))

    return typeEffect
end

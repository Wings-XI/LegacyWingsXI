---------------------------------------------
-- Scissor Guard
-- Enhances defense 100%.
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
    local power = 100

    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        skill:setMsg(MobBuffMove(mob, typeEffect, power * 2, 0, 20))
        local effect = mob:getStatusEffect(tpz.effect.DEFENSE_BOOST)
        effect:unsetFlag(tpz.effectFlag.DISPELABLE)
        mob:addMod(tpz.mod.DMGPHYS, -500)
        effect:addMod(tpz.mod.DMGPHYS, -500)
    else
        skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, 20))
    end

    return typeEffect
end

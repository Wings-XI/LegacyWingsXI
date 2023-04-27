---------------------------------------------
-- Geist Wall
--
-- Description: Dispels one effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-- Notes:
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
    local count = 1
    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        count = 3
    end

    local dispel = target:dispelStatusEffect()

    if dispel == tpz.effect.NONE then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
        while count > 1 do
            target:dispelStatusEffect()
            count = count - 1
        end
    end

    return dispel
end

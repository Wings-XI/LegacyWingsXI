---------------------------------------------
-- Disorienting Waul
--
-- Description: Amnesia targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-- Notes: Applies Amnesia to all targets in AOE
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getID() == 17121576 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.AMNESIA
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60))

    return typeEffect
end

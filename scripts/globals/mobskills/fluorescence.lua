---------------------------------------------
--  Fluorescence
--  Description: Emits radiation to boost next attack.
--  Type: Enhancing
--  Range: Self
--  Notes: Used by Yovra Family
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 12
    local duration = 60

    local typeEffect = tpz.effect.BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end
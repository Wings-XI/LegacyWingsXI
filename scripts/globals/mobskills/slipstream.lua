---------------------------------------------
--  Slipstream
--  Family: Bat Trio
--  Description: Reduces accuracy of targets in area of effect
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Radius
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------


function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ACCURACY_DOWN
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 40, 0, 120))

    return typeEffect
end

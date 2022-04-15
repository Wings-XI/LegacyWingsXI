---------------------------------------------
--  Cacodemonia
--
--  Description: AoE Curse
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown Radial (Using 15' as an estimate)
--  Notes: Used by some versions of Diabolos, but not all.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if target:hasStatusEffect(tpz.effect.CURSE_I) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CURSE_I

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 40, 0, 360))

    return typeEffect
end

---------------------------------------------
-- Doom
-- Used by some Yagudo NMs in Dynamis
-- Description: Inflicts Doom to target.  The doom effect is removed when the NM dies.
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/settings")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM
    target:addStatusEffect(typeEffect, 10, 3, 30)

    return typeEffect
end

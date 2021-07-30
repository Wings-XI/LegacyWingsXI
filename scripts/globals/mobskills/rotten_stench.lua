---------------------------------------------------
-- Rotten Stench
-- Reduces accuracy and magical accuracy in an area of effect.
-- Duration: Two minutes
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ACCURACY_DOWN

    local msg = MobStatusEffectMove(mob, target, typeEffect, 50, 0, 120)
    skill:setMsg(msg)

    MobStatusEffectMove(mob, target, tpz.effect.MAGIC_ACC_DOWN, 50, 0, 120)

    return typeEffect
end

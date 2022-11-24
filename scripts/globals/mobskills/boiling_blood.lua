---------------------------------------------
-- Boiling Blood
-- Boiling Blood Ability.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BOILING_BLOOD
    skill:setMsg(MobBuffMove(mob, typeEffect, 50, 0, 60))
    return tpz.effect.BERSERK
end
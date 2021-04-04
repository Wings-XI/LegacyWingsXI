---------------------------------------------
-- Immortal Mind
-- Enhances Magic Attack
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobBuffMove(mob, tpz.effect.MAGIC_ATK_BOOST, 20, 0, 180))

    return tpz.effect.MAGIC_ATK_BOOST
end

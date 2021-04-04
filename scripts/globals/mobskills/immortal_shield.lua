---------------------------------------------
-- Immortal Shield
-- Description: Grants a Magic Shield to the user.
-- Note: missing proper rottating shield animation for status buff
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    skill:setMsg(MobBuffMove(mob, tpz.effect.MAGIC_SHIELD, 4, 0, 900)) -- lasted 15 mins

    return tpz.effect.MAGIC_SHIELD
end

---------------------------------------------
-- Hundred Fists
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local duration = 30

    MobBuffMove(mob, tpz.effect.HUNDRED_FISTS, 1, 0, duration)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.HUNDRED_FISTS
end

---------------------------------------------
-- Valkeng's Dance
-- Dummy Skill that makes Valkeng/Ob perform a dance animation.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end

---------------------------------------------
-- Xenoglossia
-- Prepares next spell for instant casting.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- Being silenced does not stop this skill, but does prevent casting of the spell associated
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("Xenoglossia", 1)
    skill:setMsg(tpz.msg.basic.NONE)
end

-----------------------------------
-- Zdei Charging Animation
-- Charging animation used for Zdei "Optic Induration"
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

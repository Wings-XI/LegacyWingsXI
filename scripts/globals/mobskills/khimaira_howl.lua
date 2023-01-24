---------------------------------------------
-- Khimaira Howl
-- Description: Animation Only, used when Khim Roams or Tyger's Special Abilities
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
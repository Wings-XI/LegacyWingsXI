---------------------------------------------
--  Lightning Spear
--
--  Description: Wide Cone Attack lightning damage (600-1500) and powerful Amnesia.
--  Type: Magical
--  Notes: Will pick a random person on the hate list for this attack.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/utils")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 1 or mob:getLocalVar("charging") == 1 then
        return 1
    else
        return 0
    end
end


function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0 -- cosmetic move only
end
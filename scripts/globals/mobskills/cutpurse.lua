---------------------------------------------
--  Cutpurse
--  Description: Unequips a random piece of equipment.
--  Type: Enfeebling
--  Ignore Shadows, Single target
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    target:unequipItem(math.random(tpz.slot.MAIN, tpz.slot.BACK))
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

---------------------------------------------
-- Regain TP
--
-- Description: Regain TP for party members within area of effect.
--
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local tp = 3000 - target:getTP()

    skill:setMsg(tpz.msg.basic.AOE_INCREASE_TP)

    target:addTP(tp)

    return 3000
end

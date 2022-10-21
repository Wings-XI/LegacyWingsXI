---------------------------------------------
-- Perfect Dodge
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

    if mob:getID() == 16941057 then
        duration = 30
    end

    MobBuffMove(mob, tpz.effect.PERFECT_DODGE, 1, 0, duration)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.PERFECT_DODGE
end

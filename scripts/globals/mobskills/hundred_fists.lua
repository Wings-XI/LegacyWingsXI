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

    if mob:getID() == 16941057 and mob:getLocalVar("hundredfists") == 0 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return
    end

    local duration = 30

    if mob:getID() == 16941057 then
        duration = 45
    end

    MobBuffMove(mob, tpz.effect.HUNDRED_FISTS, 1, 0, duration)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.HUNDRED_FISTS
end

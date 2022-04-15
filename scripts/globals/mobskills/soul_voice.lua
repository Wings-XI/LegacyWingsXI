---------------------------------------------
-- Soul Voice
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    if mob:getID() == 16941057 and mob:getLocalVar("soulvoice") == 0 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return
    end

    local duration = 180

    if mob:getID() == 16941057 then
        duration = 45
    end

    MobBuffMove(mob, tpz.effect.SOUL_VOICE, 1, 0, duration)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.SOUL_VOICE
end

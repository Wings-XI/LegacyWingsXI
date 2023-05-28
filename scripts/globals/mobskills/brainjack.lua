---------------------------------------------------
-- BrainJack
-- Charms a player and inflicts a 25/tick dot while charmed
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CHARM_I
    local power = 0
    local duration = 90

    if (not target:isPC()) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return typeEffect
    elseif mob:getFamily() == 316 then -- Pandemonium Warden
        duration = 30
    end

    local msg = MobStatusEffectMove(mob, target, typeEffect, power, 3, duration)
    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        mob:charm(target)
        target:addStatusEffectEx(tpz.effect.BRAINJACK, 0, 25, 3, duration)
        mob:resetEnmity(target)
    end
    skill:setMsg(msg)

    return typeEffect
end

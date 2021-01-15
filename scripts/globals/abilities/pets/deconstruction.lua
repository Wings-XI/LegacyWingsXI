---------------------------------------------------
-- Deconstruction
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/summon")
---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    return 0,0
end

function onPetAbility(target, pet, skill, master)
    skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    local effectid = pet:stealStatusEffect(target)
    local effect = pet:getStatusEffect(effectid)
    if effect ~= nil then
        pet:setLocalVar("ChronoshiftStatusID",effect:getType())
        pet:setLocalVar("ChronoshiftStatusPower",effect:getPower())
        pet:setLocalVar("ChronoshiftStatusTick",effect:getTick())
        pet:setLocalVar("ChronoshiftStatusDuration",math.floor(effect:getTimeRemaining() / 1000))
        pet:delStatusEffectSilent(effectid)
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
        return effectid
    end
    return 0
end

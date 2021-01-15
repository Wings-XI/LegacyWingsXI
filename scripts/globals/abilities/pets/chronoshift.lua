---------------------------------------------------
-- Chronoshift
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
    local effect = pet:getLocalVar("ChronoshiftStatusID")
    local power = pet:getLocalVar("ChronoshiftStatusPower")
    local tick = pet:getLocalVar("ChronoshiftStatusTick")
    local duration = pet:getLocalVar("ChronoshiftStatusDuration")
    pet:setLocalVar("ChronoshiftStatusID",0)
    pet:setLocalVar("ChronoshiftStatusPower",0)
    pet:setLocalVar("ChronoshiftStatusTick",0)
    pet:setLocalVar("ChronoshiftStatusDuration",0)
    if effect ~= nil and target:addStatusEffect(effect,power,tick,duration) then
        skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
        return effect
    end
    
    return 0
end

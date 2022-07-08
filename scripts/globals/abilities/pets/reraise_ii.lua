---------------------------------------------
-- Reraise II
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    if not target:isAlive() then
        return 87,0
    end
    return 0,0
end

function onPetAbility(target, pet, skill)
    local mpCost = 80
    if (not target:isPC()) or not (target:addStatusEffect(tpz.effect.RERAISE, 2, 0, 3600)) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(-mpCost) 
    return tpz.effect.RERAISE
end

---------------------------------------------
-- Raise II
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    -- no restrition on being in party
    if target:isAlive() then
        return 87,0
    end
    return 0,0
end

function onPetAbility(target, pet, skill)
    local mpCost = 160
    if (not target:isPC()) or (target:isAlive()) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    skill:setMsg(0)
    target:sendRaise(2)
    pet:getMaster():addMP(-mpCost)
    return 0
end

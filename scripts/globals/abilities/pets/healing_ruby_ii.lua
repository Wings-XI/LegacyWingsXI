---------------------------------------------
-- Healing Ruby II
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 124
    local base = 28 + pet:getMainLvl()*4 + skill:getTP()/20

    if (target:getHP()+base > target:getMaxHP()) then
        base = target:getMaxHP() - target:getHP() --cap it
    end
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    target:addHP(base)

    pet:getMaster():addMP(-mpCost)
    return base
end

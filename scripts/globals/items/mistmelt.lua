-----------------------------------------
-- ID: 5265 
-- Item: Mistmelt
-- Item Effect: Used to bring Ouryu down from the sky 
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")

function onItemCheck(target, param, player)
    local result = 0
	local id = target:getID()

	if id ~= 16904202 and id ~= 16900314 then -- ouryu
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = tpz.msg.basic.TOO_FAR_AWAY
    end

    return result
end

function onItemUse(target)
    if target:AnimationSub() == 1 then 
        target:AnimationSub(2)
        target:SetMobSkillAttack(0)
        target:delStatusEffect(tpz.effect.TOO_HIGH)
        target:setLocalVar("changeTime", target:getBattleTime())   
    end
end

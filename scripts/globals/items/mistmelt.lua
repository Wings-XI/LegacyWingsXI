-----------------------------------------
-- ID: 5265 
-- Item: Mistmelt
-- Item Effect: Used to bring Ouryu down from the sky 
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")
require("scripts/globals/zone")

function onItemCheck(target, param, player)
    local result = 0
    local zone = target:getZoneID()

    if target:checkDistance(player) > 10 then
        result = tpz.msg.basic.TOO_FAR_AWAY
    elseif
        target:getName() ~= "Ouryu" or
        (zone ~= tpz.zone.RIVERNE_SITE_A01 and zone ~= tpz.zone.MONARCH_LINN)
    then
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE
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

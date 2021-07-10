-----------------------------------------
-- ID: 15834
-- Item: Blind Ring
-- Item Effect: Enchantment Blind
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target, param, player)
    local result = 0
    if (target:checkDistance(player) > 10) then
        result = tpz.msg.basic.TOO_FAR_AWAY
    end
    return result
end

function onItemUse(target, item, player)
    local chance = 70
    if target:hasImmunity(64) or math.random(0, 100) >= chance then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    else
        target:delStatusEffect(tpz.effect.BLINDNESS)
        if (not target:hasStatusEffect(tpz.effect.BLINDNESS)) then
            target:addStatusEffect(tpz.effect.BLINDNESS, 10, 0, 30)
        end
    end
    target:updateClaim(player)
end
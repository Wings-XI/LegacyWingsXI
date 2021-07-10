-----------------------------------------
-- ID: 15175
-- Item: Reviler's Helm
-- Item Effect: Provoke
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target, param, player, item)
    local result = 0
    if (target:checkDistance(player) > 18) then
        result = tpz.msg.basic.TOO_FAR_AWAY
    end
    return result
end

function onItemUse(target, item, player)
    target:addEnmity(player, 0, 1800)
    target:updateClaim(player)
end
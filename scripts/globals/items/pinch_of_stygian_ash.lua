-----------------------------------------
-- ID: 19210
-- Item: stygian_ash
-- Notes: used to claim Dark Ixion
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onAdditionalEffect(player, target, damage)
    target:setLocalVar("StygianLanded", 1)
end

-----------------------------------------
-- ID: 28540
-- Warp Ring
--  Transports the user to their Home Point
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    --target:addStatusEffectEx(tpz.effect.TELEPORT,0,tpz.teleport.id.WARP,0,1)
    target:PrintToPlayer("Warp Ring is an out of era item which should not be obtainable or usable on Wings. If you have received the item by mistake please contact a GM.")
end

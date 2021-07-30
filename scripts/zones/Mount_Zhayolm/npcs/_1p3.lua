-----------------------------------
-- Area: Mount Zhayolm
-- Door: Runic Seal
-- !pos 703 -18 382 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/assault")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onAssaultTrigger(player, npc, 203, tpz.ki.LEBROS_ASSAULT_ORDERS, 2)
end

function onEventUpdate(player, csid, option, target)
    onAssaultUpdate(player, csid, option, target, tpz.ki.LEBROS_ASSAULT_ORDERS, 63)
end

function onEventFinish(player, csid, option, target)
    if csid == 208 or (csid == 203 and option == 4) then
        player:setPos(0, 0, 0, 0, 63)
    end
end

function onInstanceCreated(player, target, instance)
    onAssaultCreated(player, target, instance, 208, tpz.ki.LEBROS_ASSAULT_ORDERS)
end

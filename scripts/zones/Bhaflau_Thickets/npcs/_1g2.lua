-----------------------------------
-- Area: Bhaflau Thickets
-- Door: Runic Seal
-- !pos -180 -6.8 -833 52
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/assault")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onAssaultTrigger(player, npc, 505, tpz.ki.MAMOOL_JA_ASSAULT_ORDERS, 1)
end

function onEventUpdate(player, csid, option, target)
    onAssaultUpdate(player, csid, option, target, tpz.ki.MAMOOL_JA_ASSAULT_ORDERS, 66)
end

function onEventFinish(player, csid, option, target)
    if csid == 505 and option == 4 then
        player:setPos(0, 0, 0, 0, 66)
    end
end

function onInstanceCreated(player, target, instance)
    onAssaultCreated(player, target, instance, 108, tpz.ki.MAMOOL_JA_ASSAULT_ORDERS)
end

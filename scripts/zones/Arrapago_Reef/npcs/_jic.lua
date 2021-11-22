-----------------------------------
-- Area: Arrapago Reef
-- Door: Runic Seal
-- !pos 36 -10 620 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/assault")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onAssaultTrigger(player, npc, 219, tpz.ki.ILRUSI_ASSAULT_ORDERS, 4)
end

function onEventUpdate(player, csid, option, target)
    onAssaultUpdate(player, csid, option, target, tpz.ki.ILRUSI_ASSAULT_ORDERS, 55)
end

function onEventFinish(player, csid, option, target)
    if (csid == 108 or (csid == 219 and option == 4)) then
        player:setPos(0, 0, 0, 0, 55)
    end
end

function onInstanceCreated(player, target, instance)
    onAssaultCreated(player, target, instance, 108, tpz.ki.ILRUSI_ASSAULT_ORDERS)
end

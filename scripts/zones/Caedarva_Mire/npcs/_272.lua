-----------------------------------
-- Area: Caedarva Mire
-- Door: Runic Seal
-- !pos 486 -23 -500 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/assault")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onAssaultTrigger(player, npc, 140, tpz.ki.LEUJAOAM_ASSAULT_ORDERS, 0)
end

function onEventUpdate(player, csid, option, target)
    onAssaultUpdate(player, csid, option, target, tpz.ki.LEUJAOAM_ASSAULT_ORDERS, 69)
end

function onEventFinish(player, csid, option, target)
    if csid == 140 and option == 4 then
        player:setPos(0, 0, 0, 0, 69)
    end
end

function onInstanceCreated(player, target, instance)
    onAssaultCreated(player, target, instance, 130, tpz.ki.LEUJAOAM_ASSAULT_ORDERS)
end

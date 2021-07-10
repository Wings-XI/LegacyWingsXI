-----------------------------------
-- Area: Lebros Cavern
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onTriggerExitRune(player, npc, 2)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    onEventFinishExitRune(player, csid, option, LEBROS_ASSAULT_POINT, ID.text, tpz.zone.MOUNT_ZHAYOLM)
end

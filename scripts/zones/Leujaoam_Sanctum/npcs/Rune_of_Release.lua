-----------------------------------
-- Area: Leujaoam Sanctum
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onTriggerExitRune(player, npc, 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    onEventFinishExitRune(player, csid, option, LEUJAOAM_ASSAULT_POINT, ID.text, tpz.zone.CAEDARVA_MIRE)
end

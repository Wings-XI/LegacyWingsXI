-----------------------------------
-- Area: Ilrusi Atoll
--  NPC: Rune of Release
-- !pos 412 -9 54 55
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onTriggerExitRune(player, npc, 3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    onEventFinishExitRune(player, csid, option, PERIQIA_ASSAULT_POINT, ID.text, tpz.zone.CAEDARVA_MIRE)
end
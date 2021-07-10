-----------------------------------
-- Area: Mamool Ja Training Grounds
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onTriggerExitRune(player, npc, 1)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    onEventFinishExitRune(player, csid, option, MAMOOL_ASSAULT_POINT, ID.text, tpz.zone.BHAFLAU_THICKETS)
end

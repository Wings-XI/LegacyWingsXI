-----------------------------------
-- Area: Ilrusi Atoll
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onTriggerExitRune(player, npc, 4)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    onEventFinishExitRune(player, csid, option, ILRUSI_ASSAULT_POINT, ID.text, tpz.zone.ARRAPAGO_REEF)
end

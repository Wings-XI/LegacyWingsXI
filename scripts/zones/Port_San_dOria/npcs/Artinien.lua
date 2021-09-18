-----------------------------------
-- Area: Port San d'Oria
--  NPC: Artinien
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_ARTINIEN)
    else
        player:startEvent(588)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

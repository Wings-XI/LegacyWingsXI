-----------------------------------
-- Area: Bastok Markets
--  NPC: Emrys
-- Standard Info NPC
-----------------------------------
require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(115)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

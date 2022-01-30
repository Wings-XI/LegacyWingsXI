-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Poudoruchant
--  Item Depository
-------------------------------------

require('scripts/globals/item_depository')

function onTrade(player, npc, trade)
    itemDepoOnTrade(player, npc, trade)
end

function onTrigger(player, npc)
    itemDepoOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    itemDepoOnEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    itemDepoOnEventFinish(player, csid, option)
end

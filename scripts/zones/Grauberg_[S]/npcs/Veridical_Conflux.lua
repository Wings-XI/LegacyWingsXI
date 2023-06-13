-----------------------------------
-- Area: Grauberg [S]
--  NPC: Veridical Conflux
-- !pos -142 -6.75 582 89
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Grauberg_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(29)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 29 and option == 99 then
        player:setPos(-700, 0, -441.3, 192, 182) -- send to walk of echoes base of steps
    end
end

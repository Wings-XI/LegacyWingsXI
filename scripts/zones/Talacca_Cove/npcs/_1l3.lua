-----------------------------------
-- Area: Talacca_Cove
-- NPC:  Iron Gate (BCNM arena 3)
-- !pos 220.000 -49.400 120.000
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/bcnm")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if EventTriggerBCNM(player, npc) then
        return
    end
end

function onEventUpdate(player, csid, option)
    local res = EventUpdateBCNM(player, csid, option)
    return res
end

function onEventFinish(player, csid, option)
    if EventFinishBCNM(player, csid, option) then
        return
    end
end
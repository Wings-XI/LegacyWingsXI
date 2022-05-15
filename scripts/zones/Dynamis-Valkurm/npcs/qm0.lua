-----------------------------------
-- Area: Dynamis-Valkrum
--  NPC: ??? (qm0)
-- Note: Removes SJ Restriction
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onTrade(player, npc, trade)
    dynamis.qmOnTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local zoneId = npc:getZoneID()
    SetServerVariable(string.format("DynamisSJRestriction_%s", zoneId), 1)
    dynamis.sjQMOnTrigger(player, npc)
end
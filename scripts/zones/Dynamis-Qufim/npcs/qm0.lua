-----------------------------------
-- Area: Dynamis-Qufim
--  NPC: ??? (qm0)
-- Note: Removes SJ Restriction
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onTrade(player, npc, trade)
    dynamis.qmOnTrade(player, npc, trade)
end

function onTrigger(player, npc)
    dynamis.sjQMOnTrigger(player, npc)
end

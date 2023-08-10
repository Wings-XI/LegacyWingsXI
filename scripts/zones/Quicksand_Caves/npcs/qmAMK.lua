-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm1
-- Note: A Moogle Kupo d'Etat mission 9 qm
-- !pos -604.353 -7.297 -660.176 208
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/events/amkhelpers")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.qmAMKOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

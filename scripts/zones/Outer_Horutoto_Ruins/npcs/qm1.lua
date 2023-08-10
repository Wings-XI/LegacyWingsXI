-----------------------------------
-- Area: Outer Horutoto Ruins
--  NPC: ???
-- Involved In Mission: AMK - An Errand! The Professor's Price
-- !pos 420.0 -11.5 746.5 194
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrigger(player, npc)
    amkHelpers.cardianOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    amkHelpers.cardianOnEventFinish(player, csid, option)
end

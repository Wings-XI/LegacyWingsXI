-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 267 0 -582
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/zones/Mamool_Ja_Training_Grounds/globals/zoneUtil")
require("scripts/globals/status")
-----------------------------------

onTrade = function(player, npc, trade)
end

onTrigger = function(player, npc)
    imperialAgent_PotHatch(player, npc, 269, -582, 124)
end

onEventUpdate = function(player, csid, option)
end

onEventFinish = function(player, csid, option)
end

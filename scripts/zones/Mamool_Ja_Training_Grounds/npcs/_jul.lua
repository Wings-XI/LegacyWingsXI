-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 183 0 -581
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/zones/Mamool_Ja_Training_Grounds/globals/zoneUtil")
require("scripts/globals/status")
-----------------------------------

onTrade = function(player, npc, trade)
end

onTrigger = function(player, npc)
    imperialAgent_PotHatch(player, npc, 184, -583, 185)
end

onEventUpdate = function(player, csid, option)
end

onEventFinish = function(player, csid, option)
end

-----------------------------------
--
-- Zone: The_Ashu_Talif
--
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    player:addTempItem(5349)

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option, target)
end

function onEventFinish(player, csid, option)
    
end

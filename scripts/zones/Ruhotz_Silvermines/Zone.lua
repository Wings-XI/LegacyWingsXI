-----------------------------------
--
-- Zone: Ruhotz_Silvermines
--
-----------------------------------
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if prevZone == 89 and player:getCharVar("SeeingBloodRed") == 3 then

    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

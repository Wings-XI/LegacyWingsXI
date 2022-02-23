-----------------------------------
--
-- Zone: Reisenjima_Henge (292)
--
-----------------------------------
local ID = require("scripts/zones/Reisenjima_Henge/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    --if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        --player:setPos(?, ?, ?, ?)
    --end

    return cs
end

function onConquestUpdate(zone, updatetype)
    -- Disabled: Can't pinpoint the DAT files for this zone
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
--
-- Zone: Residential_Area
--
-----------------------------------
local ID = require("scripts/zones/Residential_Area/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    player:eraseStatusEffect(true)
    player:setPos(0, 0, 0, 192)

    return cs
end

function onConquestUpdate(zone, updatetype)
    -- Disabled: Mog Houses actually use message offsets of the parent zone
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

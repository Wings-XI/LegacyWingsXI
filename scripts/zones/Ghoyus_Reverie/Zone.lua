-----------------------------------
--
-- Zone: Ghoyus_Reverie
--
-----------------------------------
local ID = require("scripts/zones/Ghoyus_Reverie/IDs")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(45, -185.23, 5, 264.43, 0, 0, 0)
end

function onInstanceZoneIn(player, instance)
end

function onZoneIn(player, prevZone)
    local cs = -1

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    --printf("onUpdate CSID: %u", csid)
    --printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    if csid == 10001 then -- A Manifest Problem
        player:setPos(-136.89, -68.25, 101.99, 0, 96) -- Send back to Fort_Karugo-Narugo_[S] on failure or non-mission completion
    elseif csid == 10000 then
        player:setPos(332.595, -4.816, -16.181, 90, 95) -- Send to West_Sarutabaruta_[S] on success and mission completion
    end
end
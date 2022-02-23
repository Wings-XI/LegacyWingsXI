-----------------------------------
--
-- Zone: Ghoyus_Reverie
--
-----------------------------------
local ID = require("scripts/zones/Ghoyus_Reverie/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -185.23, 5, 264.43, 0, 0, 0)
end

function onInstanceZoneIn(player, instance)
end

function onZoneIn(player, prevZone)
    local cs = -1

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    --printf("onUpdate CSID: %u", csid)
    --printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
end
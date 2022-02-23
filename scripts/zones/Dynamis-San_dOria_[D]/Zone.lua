-----------------------------------
--
-- Zone: Dynamis-San_dOria [D]
--
-----------------------------------
local ID = require("scripts/zones/Dynamis-San_dOria_[D]/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
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
end

function onEventFinish(player, csid, option)
end

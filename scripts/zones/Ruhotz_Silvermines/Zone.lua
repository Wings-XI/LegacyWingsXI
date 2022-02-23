-----------------------------------
--
-- Zone: Ruhotz_Silvermines
--
-----------------------------------
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    return cs
end

function onInstanceZoneIn(player, instance)
    if (instance:getID() == 90) then
        local lightInTheDarknessProgress = player:getCharVar("LightInTheDarkness")
        if (lightInTheDarknessProgress == 5 or lightInTheDarknessProgress == 8) then
            player:startEvent(4)
        end
    end
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

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

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10000 or csid == 10001 then -- SCH AF3 battle
        player:setPos(0, 0, 0, 0, 89) -- Send back to Grauberg [S]
    end
end

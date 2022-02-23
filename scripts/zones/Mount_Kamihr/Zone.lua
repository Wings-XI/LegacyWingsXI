-----------------------------------
--
-- Zone: Mount Kamihr
--
-----------------------------------
local ID = require("scripts/zones/Mount_Kamihr/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        -- player:setPos(x, y, z, r)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    -- Disabled: Maybe doesn't have conquest messages in DATs.
    -- tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

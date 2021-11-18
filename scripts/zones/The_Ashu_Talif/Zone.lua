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

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(11.5, -22, 5, 60)
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option, target)
end

function onEventFinish(player, csid, option)
    
end

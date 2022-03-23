-----------------------------------
--
-- Zone: Nyzul_Isle
--
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onInstanceZoneIn(player, instance)
    local cs = -1

    local pos = player:getPos()
    if (pos.x == 0 and pos.y == 0 and pos.z == 0) then
        player:setPos(player:getInstance():getEntryPos())
    end
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS) then
        cs = 51
    end

    player:addTempItem(5348)

    -- Nyzul Isle Investigation
    if (instance:getID() == 51) then
        player:setCharVar("assaultEntered", 6)
    end

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

function onInstanceLoadFailed()
    return 72
end

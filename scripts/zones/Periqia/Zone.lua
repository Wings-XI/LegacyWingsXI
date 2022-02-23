-----------------------------------
--
-- Zone: Periqia
--
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/conquest")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
end

function onInstanceZoneIn(player, instance)
    local cs = -1
    local pos = player:getPos()

    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    if player:getInstance() ~= nil then
        player:setCharVar("assaultEntered", 4)
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
    assaultOnEventFinish(player, csid, 102, tpz.zone.CAEDARVA_MIRE)
end

function onInstanceLoadFailed()
    return tpz.zone.CAEDARVA_MIRE
end
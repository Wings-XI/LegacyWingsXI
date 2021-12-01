-----------------------------------
--
-- Zone: Upper_Jeuno (244)
--
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
    if isStarlightEnabled() ~= 0 then
        zone:setMusicBackgroundDay(239)
        zone:setMusicBackgroundNight(239)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- COP mission 1-1
    if player:getCurrentMission(COP) == tpz.mission.id.cop.THE_RITES_OF_LIFE and player:getCharVar("PromathiaStatus") == 0 then
        cs = 2
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(46.2, -5, -78, 172)
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
    if csid == 2 then
        player:setCharVar("PromathiaStatus", 1)
    end
end

-----------------------------------
--
-- Zone: Pashhow_Marshlands_[S] (90)
--
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
require("scripts/globals/status")
require("scripts/globals/quests")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    
    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS) == QUEST_ACCEPTED then
        local lightInTheDarknessProgress = player:getCharVar("LightInTheDarkness")
        if prevZone == tpz.zone.GRAUBERG_S then
            if lightInTheDarknessProgress == 4 then
                cs = 901
            end
        elseif prevZone == tpz.zone.RUHOTZ_SILVERMINES then
            if lightInTheDarknessProgress == 9 then
                cs = 902
            end
        end
    end

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(547.841, 23.192, 696.323, 134)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onZoneWeatherChange(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS_OFFSET + 1) -- Indescript Markings (PANTS)
    if npc then
        if weather == tpz.weather.RAIN or weather == tpz.weather.THUNDER then
            npc:setStatus(tpz.status.DISAPPEAR)
        else
            npc:setStatus(tpz.status.NORMAL)
        end
    end

    npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS_OFFSET + 2) -- Indescript Markings (BODY)
    if npc then
        if weather == tpz.weather.RAIN then
            npc:setStatus(tpz.status.DISAPPEAR)
        else
            npc:setStatus(tpz.status.NORMAL)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 901) then
        player:setCharVar("LightInTheDarkness", 5)
    elseif (csid == 902) then
        player:setCharVar("LightInTheDarkness", 10)
    end
end

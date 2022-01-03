-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: Shahayl
-- Type: Assault
-- ID: 17072276 - Index 148
-- !pos 145.787 0 31.166 72
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local toauMission = player:getCurrentMission(TOAU)

    -- Assault --
    if (toauMission >= tpz.mission.id.toau.PRESIDENT_SALAHEEM) then
        local imperialStanding = player:getCurrency("imperial_standing")
        local floorProgressNyzulInvestigation = 0 -- ToDo get floorProgress and add 1, expcept for 100 (subtract 4)
        local floorProgressNyzulUncharted = 0
        local nyzulTokens = player:getAssaultPoint(NYZUL_ISLE_ASSAULT_POINT)
        
        if (player:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) and player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) == false) then
            player:startEvent(412, 50, nyzulTokens, floorProgressNyzulInvestigation, imperialStanding, floorProgressNyzulUncharted)
            return
        end
    end

    -- default -- 
    player:startEvent(413)
    
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- ASSAULT --
    if (csid == 412 and option == 1) then
        player:delCurrency("imperial_standing", 50)
        player:addKeyItem(tpz.ki.ASSAULT_ARMBAND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ASSAULT_ARMBAND)
    end
end
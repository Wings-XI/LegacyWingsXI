-----------------------------------
-- Area: Norg
-- NPC: Andrause
-- A Shantotto Ascencion NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

local mobList =
{
    {"Bigclaw", "Bigclaw"},
    {"Brook Sahagin", "BrookSahagin"},
    {"Riparian Sahagin", "RiparianSahagin"},
    {"Rivulet Sahagin", "RivuletSahagin"},
    {"Royal Leech", "RoyalLeech"},
    {"Undead Bats", "UndeadBats"},
    {"Grotto Pugil", "GrottoPugil"},
    {"Sea Bonze", "SeaBonze"},
    {"Blubber Eyes", "BlubberEyes"},
    {"Bog Sahagin", "BogSahagin"},
    {"Marsh Sahagin", "MarshSahagin"},
    {"Rock Crab", "RockCrab"},
    {"Razorjaw Pugil", "RazorjawPugil"},
    {"Sahagin Parasite", "SahaginParasitd"},
    {"Swamp Sahagin", "SwampSahagin"},
    {"Devil Manta", "DevilManta"},
    {"Dire Bat", "DireBat"},
    {"Lagoon Sahagin", "LagoonSahagin"},
    {"Delta Sahagin", "DeltaSahagin"},
    {"Coastal Sahagin", "CoastalSahagin"},
    {"Mousse", "Mousse"},
    {"Robber Crab", "RobberCrab"},
    {"Shore Sahagin", "ShoreSahagin"},
}

function onTrade(player, npc, trade)
    local mobOne = player:getCharVar("ASA_MobOne")
    if mobOne ~= 0 and npcUtil.tradeHasExactly(trade, 2477) then -- Trading Soul Plate
        local mobTwo = player:getCharVar("ASA_MobTwo")
        local mobThree = player:getCharVar("ASA_MobThree")
        local platesTraded = player:getCharVar("ASA_Plates")
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()

        for value, data in pairs(mobList) do
            if data[2] == plateData.name then
                player:setLocalVar("ASA_Found", value)
            end
        end

        local foundMob = player:getLocalVar("ASA_Found")
        if foundMob == mobOne or foundMob == mobTwo or foundMob == mobThree then
            if foundMob == mobOne then
                player:setCharVar("ASA_MobOne", 99)
            elseif foundMob == mobTwo then
                player:setCharVar("ASA_MobTwo", 99)
            elseif foundMob == mobThree then
                player:setCharVar("ASA_MobThree", 99)
            end

            if platesTraded == 0 then
                player:startEvent(241)
                player:setCharVar("ASA_Plates", 1)
                player:confirmTrade()
            elseif platesTraded == 1 then
                player:startEvent(241)
                player:setCharVar("ASA_Plates", 2)
                player:confirmTrade()
            elseif platesTraded == 2 then
                player:startEvent(241)
                player:setCharVar("ASA_Plates", 3)
                player:confirmTrade()
            end
        else
            player:startEvent(242)
        end
    end
end

function onTrigger(player, npc)
    local mobOne = player:getCharVar("ASA_MobOne")
    local platesTraded = player:getCharVar("ASA_Plates")

    if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I or (player:getCurrentMission(ASA) >= tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and not player:hasKeyItem(tpz.ki.BLACK_BOOK)) then
        if mobOne == 0 then
            -- Select mobs for player to get pictures of
            mobOne = math.random(1,23)
            local mobTwo = math.random(1,23)
            while mobTwo == mobOne do
                mobTwo = math.random(1,23)
            end
            local mobThree = math.random(1,23)
            while mobThree == mobOne or mobThree == mobTwo do
                mobThree = math.random(1,23)
            end
            player:setCharVar("ASA_MobOne", mobOne)
            player:setCharVar("ASA_MobTwo", mobTwo)
            player:setCharVar("ASA_MobThree", mobThree)

            if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I then
                player:startEvent(237)
            else
                player:startEvent(237, 0)
            end
        elseif mobOne ~= 0 and platesTraded == 0 then
            player:startEvent(238, 3)
        elseif mobOne ~= 0 and platesTraded == 1 then
            player:startEvent(238, 2)
        elseif mobOne ~= 0 and platesTraded == 2 then
            player:startEvent(238, 1)
        end
    elseif player:hasKeyItem(tpz.ki.BLACK_BOOK) then
        player:startEvent(240)
    else -- Player isn't on ACP Mission
        player:startEvent(239)
    end
end

function onEventUpdate(player, csid, option)
    local mobOne = player:getCharVar("ASA_MobOne")
    local mobTwo = player:getCharVar("ASA_MobTwo")
    local mobThree = player:getCharVar("ASA_MobThree")
    local pickupReady = player:getCharVar("[ASA]Soulplate") < os.time()
    local platesTraded = player:getCharVar("ASA_Plates")

    -- event 237
    -- option 2 = yes, ill do it
    -- option 5 = buy the camera, doesnt appear to be a "not enough gil dialogue"
    --player:PrintToPlayer(string.format( "onEventUpdate CSID %s OPTION %s", csid, option))
    if (csid == 237 and option == 4) then
        player:updateEvent(18721, 18722, 2477)
    elseif (csid == 237 and option == 1) then
        player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1], mobList[mobThree][1], '', 49284, 524420, 0, 0, 0, 0, 0, 0)
    elseif (csid == 237 and option == 6) then
        -- Param 0 = allowed to buy a camera, >0 = "im out of stock"
        -- param 3 = x .:(You have x) (maybe number of blank plates?)
        player:updateEvent(0, 18721, 18722, player:getGil())
    elseif (csid == 237 and option == 5) then
        player:setLocalVar("AndrauseBuy", 1)
    end

    -- 99 = Player completed trade
    if (csid == 238 and option == 6) then
        if platesTraded == 0 then
            player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1], mobList[mobThree][1])
        elseif platesTraded == 1 then
            if mobOne == 99 then
                player:updateEventString(mobList[mobTwo][1], mobList[mobThree][1])
            elseif mobTwo == 99 then
                player:updateEventString(mobList[mobOne][1], mobList[mobThree][1])
            elseif mobThree == 99 then
                player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1])
            end
        elseif platesTraded == 2 then
            if mobOne == 99 and mobTwo == 99 then
                player:updateEventString(mobList[mobThree][1])
            elseif mobTwo == 99 and mobThree == 99 then
                player:updateEventString(mobList[mobOne][1])
            elseif mobOne == 99 and mobThree == 99 then
                player:updateEventString(mobList[mobTwo][1])
            end
        end
        if pickupReady then
            player:updateEvent(0, 18721, 18722, player:getGil())
        end
    elseif (csid == 238 and option == 4) then
        player:updateEvent(18721, 18722)
    elseif (csid == 238 and option == 5) then
        player:setLocalVar("AndrauseBuy", 1)
    end

    if csid == 241 then
        local foundMob = player:getLocalVar("ASA_Found")
        if platesTraded == 1 then
            if mobOne == 99 then
                player:updateEvent(0, 3)
                player:updateEventString(mobList[mobOne][1], mobList[mobTwo][1], mobList[mobThree][1])
            elseif mobTwo == 99 then
                player:updateEvent(0, 3)
                player:updateEventString(mobList[mobTwo][1], mobList[mobOne][1], mobList[mobThree][1])
            elseif mobThree == 99 then
                player:updateEvent(0, 3)
                player:updateEventString(mobList[mobThree][1], mobList[mobOne][1], mobList[mobTwo][1])
            end
        elseif platesTraded == 2 then
            if mobOne == 99 and mobTwo == 99 then
                player:updateEvent(0, 2)
                player:updateEventString(mobList[foundMob][1],mobList[mobThree][1])
            elseif mobTwo == 99 and mobThree == 99 then
                player:updateEvent(0, 2)
                player:updateEventString(mobList[foundMob][1],mobList[mobOne][1])
            elseif mobOne == 99 and mobThree == 99 then
                player:updateEvent(0, 2)
                player:updateEventString(mobList[foundMob][1],mobList[mobTwo][1])
            end
        elseif platesTraded == 3 then
            player:updateEvent(0, 1)
            player:updateEventString(mobList[foundMob][1])
        end
    end
end

function onEventFinish(player, csid, option)
    if ( csid == 237 or csid == 238 ) and player:getLocalVar("AndrauseBuy") == 1 then
        -- check if we got the room and gils
        local slotsNeeded = 1 + ( not player:hasItem(18721) and 1 or 0 )
        if player:getFreeSlotsCount() < slotsNeeded then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED2)
        elseif player:getGil() < 800 then
            player:messageSpecial(ID.text.YOU_DO_NOT_HAVE_ENOUGH_GIL)
        else
            -- complete the trade
            player:delGil(800)
            if slotsNeeded == 2 then
                player:addItem(18721)       -- Soultrapper
                player:messageSpecial(ID.text.ITEM_OBTAINED, 18721)
            end
            player:addItem(18722, 12)       -- Soul Plates
            player:messageSpecial(ID.text.YOU_OBTAIN, 18722, 12)

            -- next buy after jst midnight
            player:setCharVar("[ASA]Soulplate", JstMidnight())
        end

        -- trade has either completed or failed, reset this var
        player:setLocalVar("AndrauseBuy", 0)
    elseif csid == 241 and player:getCharVar("ASA_Plates") == 3 then
        player:addKeyItem(tpz.ki.BLACK_BOOK)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLACK_BOOK)
        player:setCharVar("ASA_MobOne", 0)
        player:setCharVar("ASA_MobTwo", 0)
        player:setCharVar("ASA_MobThree", 0)
        player:setCharVar("ASA_Plates", 0)

        if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I then
            player:completeMission(ASA, tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
            player:addMission(ASA, tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)
        end
    end
end
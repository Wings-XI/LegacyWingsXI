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
    "Bigclaw",
    "Brook Sahagin",
    "Riparian Sahagin",
    "Rivulet Sahagin",
    "Royal Leech",
    "Undead Bats",
    "Grotto Pugil",
    "Sea Bonze",
    "Grotto Pugil",
    "Blubber Eyes",
    "Bog Sahagin",
    "Marsh Sahagin",
    "Rock Crab",
    "Razorjaw Pugil",
    "Sahagin Parasite",
    "Swamp Sahagin",
    "Devil Manta",
    "Dire Bat",
    "Lagoon Sahagin",
    "Delta Sahagin",
    "Coastal Sahagin",
    "Mousse",
    "Robber Crab",
    "Shore Sahagin"
}

function onTrade(player, npc, trade)
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I and npcUtil.tradeHas(trade, 2477) then -- Trading Soul Plate
        local mobOne = player:getCharVar("ASA_MobOne")
        local mobTwo = player:getCharVar("ASA_MobTwo")
        local mobThree = player:getCharVar("ASA_MobThree")
        local platesTraded = player:getCharVar("ASA_Plates")
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()

        if plateData.name == mobList[mobOne] or plateData.name == mobList[mobTwo] or plateData.name == mobList[mobThree] then
            if platesTraded == 0 then
                player:startEvent(241)
                player:setCharVar("ASA_Plates", 1)
            elseif platesTraded == 1 then
                player:startEvent(241)
                player:setCharVar("ASA_Plates", 2)
            elseif platesTraded == 2 then
                player:startEvent(241)
            end
        else
            player:startEvent(242)
        end
    end
end

function onTrigger(player, npc)
    local andrause = player:getCharVar("AndrauseStage")
    local mobOne = player:getCharVar("ASA_MobOne")

    if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I and andrause == 0 then
        if mobOne == 0 then
            -- Selct mobs for player to get pictures of
            mobOne = math.random(1,24)
            local mobTwo = math.random(1,24)
            while mobTwo == mobOne do
                mobTwo = math.random(1,24)
            end
            local mobThree = math.random(1,24)
            while mobThree == mobOne or mobThree == mobTwo do
                mobTwo = math.random(1,24)
            end
            player:setCharVar("ASA_MobOne", mobOne)
            player:setCharVar("ASA_MobTwo", mobTwo)
            player:setCharVar("ASA_MobThree", mobThree)
        end

        player:startEvent(237, 18721, 18722)
        -- player:startEvent(241)
    else -- Player isn't on ACP Mission
        player:startEvent(239)
    end
end

function onEventUpdate(player, csid, option)
    -- local mobOne = player:getCharVar("ASA_MobOne")
    -- local mobTwo = player:getCharVar("ASA_MobTwo")
    -- local mobThree = player:getCharVar("ASA_MobThree")

    -- print(option)
    -- if csid == 237 and option == 2 then
    --     player:updateEvent(18721, 18722, 570558701, 1216690211, -2138766590, 436539533, 4)
    -- elseif csid == 237 and option == 1 then
    --     -- player:updateEventString(mobList[mobOne], mobList[mobTwo], mobList[mobThree], '', 49284, 524420, 0, 0, 0, 0, 0, 0)
    --     player:updateEvent(252, 18722, 2477, 570558701, 1216690211, -1474100478, 33890344, 0)
    --     player:setCharVar("ASA_Plates", 0)
    -- elseif csid == 237 and option == 4 then
    --     player:updateEvent(18721, 18722, 2477, 570558701, 1216690211, -1474100478, 33890344, 0)
    -- -- elseif csid == 237 and option == 6 then
    -- --     player:updateEvent(18721, 18722, 757853, 1216690211, -1474100478, 33890344, 0)
    -- -- elseif csid == 237 and option == 5 then
    -- --     player:updateEvent(18722, 12, -1471806718, 570558701, 1216690211, 1612907266, 1241907437, 0)
    -- end
end

function onEventFinish(player, csid, option)
    if csid == 241 then
        player:addKeyItem(tpz.ki.BLACK_BOOK)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLACK_BOOK)
        player:completeMission(ASA, tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
        player:addMission(ASA, tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)
    end
end

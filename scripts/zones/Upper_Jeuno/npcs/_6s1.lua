-----------------------------------
-- Area: Upper Jeuno
--  NPC: Marble Bridge Eatery (Door)
-- !pos -96.6 -0.2 92.3 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------

local ring =
{
    15543, -- Rajas Ring
    15544, -- Sattva Ring
    15545  -- Tamas Ring
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local status = player:getCharVar("PromathiaStatus")
    local mission = player:getCurrentMission(COP)

    if (mission == tpz.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG and status == 1) then
        player:startEvent(10011)
    elseif (mission == tpz.mission.id.cop.FLAMES_IN_THE_DARKNESS and status == 3) then
        player:startEvent(10012)
    elseif (mission == tpz.mission.id.cop.DAWN and status == 4) then
        player:startEvent(129)
    elseif ((mission == tpz.mission.id.cop.DAWN and status > 4) or player:hasCompletedMission(COP, tpz.mission.id.cop.DAWN)) then
        local hasRing = false

        for key, value in pairs(ring) do
            if (player:hasItem(value)) then
                hasRing = true
            end
        end

        if not (hasRing) then
            local currentDay = tonumber(os.date("%j"))
            local ringsTaken = player:getCharVar("COP-ringsTakenbr")
            local dateObtained = player:getCharVar("COP-lastRingday")
            local playerHasWaited28days = false

            if (currentDay - dateObtained) > 28) then
                playerHasWaited28days = true -- player has waited 28 days
            elseif ((currentDay < dateObtained) and (currentDay + (365 - dateObtained) > 28)) then 
                playerHasWaited28days = true -- wrapped around the year change
            end

            if (ringsTaken == 0) then
                player:startEvent(84, ring[1], ring[2], ring[3])
            elseif (ringsTaken == 1) then -- First time you throw away, no wait
                player:startEvent(204, ring[1], ring[2], ring[3])
            elseif (ringsTaken > 1 and (playerHasWaited28days) then -- Wait time is >= 28 days, not 26
                player:startEvent(204, ring[1], ring[2], ring[3])
            else
                MarbleEateryDoorCheck(player)
            end
        end
    else
        MarbleEateryDoorCheck(player)
    end
end

function MarbleEateryDoorCheck(player)
    local dayofthemonth = VanadielDayOfTheMonth()
    local nation = player:getNation()
    local job = player:getMainJob()
    local race = player:getRace()
    local gender = player:getGender()

    -- Rotation is based on https://ffxiclopedia.fandom.com/wiki/Marble_Bridge_Eatery removed by 3 days to match up with http://www.mithrapride.org/vana_time/
    -- Check Nations
    if dayofthemonth == 1 and nation == tpz.nation.SANDORIA then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 2 and nation == tpz.nation.BASTOK then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 3 and nation == tpz.nation.WINDURST then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 4 and job == tpz.job.WAR then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 5 and job == tpz.job.MNK then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 6 and job == tpz.job.WHM then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 7 and job == tpz.job.BLM then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 8 and job == tpz.job.RDM then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 9 and job == tpz.job.THF then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 10 and job == tpz.job.PLD then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 11 and job == tpz.job.DRK then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 12 and job == tpz.job.BST then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 13 and job == tpz.job.BRD then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 14 and job == tpz.job.RNG then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 15 and job == tpz.job.SAM then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 16 and job == tpz.job.NIN then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 17 and job == tpz.job.DRG then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 18 and job == tpz.job.SMN then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 19 and job == tpz.job.BLU then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 20 and job == tpz.job.COR then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 21 and job == tpz.job.PUP then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 22 and job == tpz.job.DNC then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 23 and job == tpz.job.SCH then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 24 and race == (tpz.race.HUME_F or tpz.race.HUME_M) then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 25 and race == (tpz.race.ELVAAN_F or tpz.race.ELVAAN_M) then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 26 and race == (tpz.race.TARU_F or tpz.race.TARU_M) then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 27 and race == (tpz.race.MITHRA) then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 28 and race == (tpz.race.GALKA) then
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 29 and gender == 0 then -- Ladies
        player:startEvent(124, (dayofthemonth - 1), 1)
    elseif dayofthemonth == 29 and gender == 1 then -- Gents
        player:startEvent(124, (dayofthemonth - 1), 1)
    else
        player:startEvent(124, (dayofthemonth - 1), 0)
    end
end

function onEventUpdate(player, csid, option)
    if ((csid == 84 or csid == 204) and option == 4) then
        player:updateEvent(ring[1], ring[2], ring[3])
    end
end

function onEventFinish(player, csid, option)
    if (csid == 10011) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (csid == 10012) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.FLAMES_IN_THE_DARKNESS)
        player:addMission(COP, tpz.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
    elseif (csid == 129) then
        player:setCharVar("PromathiaStatus", 5)
    elseif ((csid == 84 or csid == 204) and option >= 5 and option <= 7) then
        if (player:getFreeSlotsCount() ~= 0) then
            local currentDay = tonumber(os.date("%j"))
            local ringsTaken = player:getCharVar("COP-ringsTakenbr")
            player:addItem(ring[option - 4])
            player:messageSpecial(ID.text.ITEM_OBTAINED, ring[option - 4])
            player:setCharVar("COP-ringsTakenbr", ringsTaken + 1)
            player:setCharVar("COP-lastRingday", currentDay)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ring[option - 4])
        end
    end
end

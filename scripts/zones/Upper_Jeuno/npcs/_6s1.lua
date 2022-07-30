-----------------------------------
-- Area: Upper Jeuno
--  NPC: Marble Bridge Eatery (Door)
-- !pos -96.6 -0.2 92.3 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------

-- Eatery Schedule
-- Based on https://ffxiclopedia.fandom.com/wiki/Marble_Bridge_Eatery
-- To match with http://www.mithrapride.org/vana_time/
local eaterySchedule =
{
    [1] = function(player) return player:getNation() == tpz.nation.SANDORIA end,
    [2] = function(player) return player:getNation() == tpz.nation.BASTOK end,
    [3] = function(player) return player:getNation() == tpz.nation.WINDURST end,
    [4] = function(player) return player:getMainJob() == tpz.job.WAR end,
    [5] = function(player) return player:getMainJob() == tpz.job.MNK end,
    [6] = function(player) return player:getMainJob() == tpz.job.WHM end,
    [7] = function(player) return player:getMainJob() == tpz.job.BLM end,
    [8] = function(player) return player:getMainJob() == tpz.job.RDM end,
    [9] = function(player) return player:getMainJob() == tpz.job.THF end,
    [10] = function(player) return player:getMainJob() == tpz.job.PLD end,
    [11] = function(player) return player:getMainJob() == tpz.job.DRK end,
    [12] = function(player) return player:getMainJob() == tpz.job.BST end,
    [13] = function(player) return player:getMainJob() == tpz.job.BRD end,
    [14] = function(player) return player:getMainJob() == tpz.job.RNG end,
    [15] = function(player) return player:getMainJob() == tpz.job.SAM end,
    [16] = function(player) return player:getMainJob() == tpz.job.NIN end,
    [17] = function(player) return player:getMainJob() == tpz.job.DRG end,
    [18] = function(player) return player:getMainJob() == tpz.job.SMN end,
    [19] = function(player) return player:getMainJob() == tpz.job.BLU end,
    [20] = function(player) return player:getMainJob() == tpz.job.COR end,
    [21] = function(player) return player:getMainJob() == tpz.job.PUP end,
    [22] = function(player) return player:getMainJob() == tpz.job.DNC end,
    [23] = function(player) return player:getMainJob() == tpz.job.SCH end,
    [24] = function(player) return player:getMainJob() == tpz.job.GEO end,
    [25] = function(player) return player:getMainJob() == tpz.job.RUN end,
    [26] = function(player) return player:getRace() == tpz.race.HUME_F or player:getRace() == tpz.race.HUME_M end,
    [27] = function(player) return player:getRace() == tpz.race.ELVAAN_F or player:getRace() == tpz.race.ELVAAN_M end,
    [28] = function(player) return player:getRace() == tpz.race.TARU_F or player:getRace() == tpz.race.TARU_M end,
    [29] = function(player) return player:getRace() == tpz.race.MITHRA end,
    [30] = function(player) return player:getRace() == tpz.race.GALKA end,
    [31] = function(player) return player:getGender() == 1 end, -- Gents
    [32] = function(player) return player:getGender() == 0 end, -- Ladies
}

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

            if ((currentDay - dateObtained) > 28) then
                playerHasWaited28days = true -- player has waited 28 days
            elseif ((currentDay < dateObtained) and (currentDay + (365 - dateObtained) > 28)) then 
                playerHasWaited28days = true -- wrapped around the year change
            end

            if (ringsTaken == 0) then
                player:startEvent(84, ring[1], ring[2], ring[3])
            elseif (ringsTaken == 1) then -- First time you throw away, no wait
                player:startEvent(204, ring[1], ring[2], ring[3])
            elseif (ringsTaken > 1 and (playerHasWaited28days)) then -- Wait time is >= 28 days, not 26
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
    --local index = ( VanadielDayAbsolute() - 1 ) % #eaterySchedule + 1
    -- since we're skipping GEO and RUN days, we'll offset by 2
    local index = ( VanadielDayAbsolute() - 1 ) % ( #eaterySchedule - 2 ) + 1
    -- and correct schedule index
    if index > 23 then
        index = index + 2
    end

    -- using our callback function to see if we meet reqs
    local pass = eaterySchedule[index](player)
    player:startEvent(124, index - 1, ( pass and 1 or 0 ))
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

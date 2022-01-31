-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Nadeey
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

--[[
    Custom TOAU_CUSTOM_RING_REACQUISITION logic
    - TOAU_RING_REACQ_STATUS 0   -   Quest not started (or quest complete)
    - TOAU_RING_REACQ_STATUS 1   -   Iniital discussion with Nadeey, waiting on payment
    - TOAU_RING_REACQ_STATUS 2   -   Payment recieved, waiting for Nashmeira's Plea re-run
    - TOAU_RING_REACQ_STATUS 3   -   Nashmeira's Plea win
    - TOAU_RING_REACQ_STATUS 4   -   Ring reacquisition CS seen, but did not choose a ring
    - TOAU_RING_REACQ_STATUS 0   -   Was given a ring - 28 day wait var gets set
]]

local BALRAHNS_RING = 15807
local ULTHALAMS_RING = 15808
local JALZAHNS_RING = 15809

function onTrade(player, npc, trade)
    if (TOAU_CUSTOM_RING_REACQUISITION == 1 and (player:getCharVar("TOAU_RING_REACQ_STATUS") == 1)) then
        if (npcUtil.tradeHasExactly(trade, {{2187, 10}})) then -- 10 Imperial Gold Pieces
            player:confirmTrade() -- take the coins
            player:setCharVar("TOAU_RING_REACQ_STATUS", 2)
            local line4 = string.format("Nadeey : Please %s, ensure the safety of Aht Urhgan again and heed Nashmeira's Plea.", player:getName())
            player:PrintToPlayer("Nadeey : Yes, this should cover their expenses.  Although it may take some time for the search to complete...", 0xD)
            player:PrintToPlayer("Nadeey : Perhaps while we wait, you could handle a small investigation for the princess and I?", 0xD)
            player:PrintToPlayer("Nadeey : I have heard that enemies who were thought vanquished in the Alzadaal Undersea Ruins stir once more.", 0xD)
            player:PrintToPlayer(line4, 0xD)
            player:PrintToPlayer("Nadeey : May the wisdom of Walahra safely guide your steps...", 0xD)
        end
    end
end

function onTrigger(player, npc)
    
    if (TOAU_CUSTOM_RING_REACQUISITION == 1) then
        local eternalMercenaryComplete = player:hasCompletedMission(TOAU, tpz.mission.id.toau.ETERNAL_MERCENARY)
        local hasBalrahnsRing = player:hasItem(BALRAHNS_RING)
        local hasUlthalamsRing = player:hasItem(ULTHALAMS_RING)
        local hasJalzahnsRing = player:hasItem(JALZAHNS_RING)
        local playerHasToauRing = hasBalrahnsRing or hasUlthalamsRing or hasJalzahnsRing
        local currentDay = tonumber(os.date("%j")) -- gives the literal day of the year, 1-365 or 366 I guess in leap year
        local dayRingLastObtained = player:getCharVar("TOAU_RING_REACQ_WAIT")
        local playerHasWaited28days = false
        local playerToauRingRacqStatus = player:getCharVar("TOAU_RING_REACQ_STATUS")

        if (dayRingLastObtained == 0) then
            playerHasWaited28days = true -- never got a re-acquired ring
        elseif ((currentDay - dayRingLastObtained) > 28) then
            playerHasWaited28days = true -- player has waited 28 days
        elseif ((currentDay < dayRingLastObtained) and (currentDay + (365 - dayRingLastObtained) > 28)) then 
            playerHasWaited28days = true -- wrapped around the year change
        end

        if (eternalMercenaryComplete and (not playerHasToauRing) and playerHasWaited28days and (playerToauRingRacqStatus == 0)) then
            local line2 = string.format("Nadeey : Oh %s, you appear quite upset! What troubles you?", player:getName())
            player:PrintToPlayer("Nadeey : Welcome to Walahra Temple. Our doors are always open to those seeking knowledge.", 0xD)
            player:PrintToPlayer(line2, 0xD)
            player:PrintToPlayer("Nadeey : Ah, you have \"misplaced\" the ring entrsusted to you by Nashmeira. I see.", 0xD)
            player:PrintToPlayer("Nadeey : Fear not, I know exactly whom I can send in search of this \"lost\" ring...", 0xD)
            player:PrintToPlayer("Nadeey : I think a fee of say, 10 Imperial Gold Pieces should suffice for their services.", 0xD)
            player:setCharVar("TOAU_RING_REACQ_STATUS", 1)
        elseif (playerToauRingRacqStatus == 1) then
            -- remind the player, 10 Imperial Gold Pieces
            player:PrintToPlayer("Nadeey : If you wish for your \"lost\" ring to be found, procure 10 Imperial Gold Pieces for me.", 0xD)
            player:PrintToPlayer("Nadeey : Consider it payment for the two who shall search all of Aht Urhgan.", 0xD)
            player:PrintToPlayer("Nadeey : May the wisdom of Walahra safely guide your steps...", 0xD)
        elseif (playerToauRingRacqStatus == 2) then
            -- remind the player, investigate Alzadaal Undersea Ruins
            player:PrintToPlayer("Nadeey : The search for your \"lost\" ring continues...", 0xD)
            player:PrintToPlayer("Nadeey : Perhaps to pass the time, you might wish to visit the Alzadaal Undersea Ruins and answer Nashmeira's Plea.", 0xD)
            player:PrintToPlayer("Nadeey : May the wisdom of Walahra safely guide your steps...", 0xD)
        elseif (playerToauRingRacqStatus == 3) then
            -- initate the ring CS 961
            player:startEvent(961, BALRAHNS_RING, ULTHALAMS_RING, JALZAHNS_RING, 0, 0, 0, 0, 0, 0)
        elseif (playerToauRingRacqStatus == 4) then
            player:startEvent(962, BALRAHNS_RING, ULTHALAMS_RING, JALZAHNS_RING, 0, 0, 0, 0, 0, 0)
        else
            -- default dialogue
            player:startEvent(251)        
        end

        return
    end

    player:startEvent(251)

end

function onEventUpdate(player, csid, option)
    if (csid == 961 or csid == 962) then
        player:updateEvent(BALRAHNS_RING, ULTHALAMS_RING, JALZAHNS_RING)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 961 and option == 0) then
        -- player couldnt decide.
        -- cs 962 - option 99 is also no ring selected however this has no effect
        player:setCharVar("TOAU_RING_REACQ_STATUS", 4)
    elseif ((csid == 961 or csid == 962) and option == 1) then
        -- 1 is BALRAHNS_RING
        if npcUtil.giveItem(player, BALRAHNS_RING) then
            player:setCharVar("TOAU_RING_REACQ_STATUS", 0)
            player:setCharVar("TOAU_RING_REACQ_WAIT", tonumber(os.date("%j")))
        end
    elseif ((csid == 961 or csid == 962) and option == 2) then
        -- 2 is ULTHALAMS_RING
        if npcUtil.giveItem(player, ULTHALAMS_RING) then
            player:setCharVar("TOAU_RING_REACQ_STATUS", 0)
            player:setCharVar("TOAU_RING_REACQ_WAIT", tonumber(os.date("%j")))
        end
    elseif ((csid == 961 or csid == 962) and option == 3) then
        -- 3 is JALZAHNS_RING
        if npcUtil.giveItem(player, JALZAHNS_RING) then
            player:setCharVar("TOAU_RING_REACQ_STATUS", 0)
            player:setCharVar("TOAU_RING_REACQ_WAIT", tonumber(os.date("%j")))
        end
    end
end

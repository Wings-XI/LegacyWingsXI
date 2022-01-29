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
    - TOAU_RING_REACQ_STAUS 0   -   Quest not started (or quest complete)
    - TOAU_RING_REACQ_STAUS 1   -   Iniital discussion with Nadeey, waiting on payment
    - TOAU_RING_REACQ_STAUS 2   -   Payment recieved, waiting for Alex re-run
    - TOAU_RING_REACQ_STAUS 3   -   Alex Win
    - TOAU_RING_REACQ_STAUS 4   -   Ring reacquisition CS seen, but did not choose a ring
    - TOAU_RING_REACQ_STAUS 0   -   Was given a ring - conquest tally var gets set
]]

local BALRAHNS_RING = 15807
local ULTHALAMS_RING = 15808
local JALZAHNS_RING = 15809

function onTrade(player, npc, trade)
    if (TOAU_CUSTOM_RING_REACQUISITION == 1 and (player:getCharVar("TOAU_RING_REACQ_STAUS") == 1)) then
        if (npcUtil.tradeHasExactly(trade, {{2187, 10}})) then -- 10 Imperial Gold Pieces
            player:confirmTrade() -- take the coins
            player:setCharVar("TOAU_RING_REACQ_STATUS", 2)
            local line4 = string.format("Nadeey : Please %s, esnure the safety of Aht Urhgan one again, and heed Nashmeira's Plea.", player:getName())
            player:PrintToPlayer("Nadeey : Yes, this should cover their expenses.  Although it may take some time for their search to complete...", 0xD)
            player:PrintToPlayer("Nadeey : Perhaps while we wait, you could handle a small investigation for the Princess and I?", 0xD)
            player:PrintToPlayer("Nadeey : I have heard that enemenies who were thought vanquished in the Alzadaal Undersea Ruins stir once more.", 0xD)
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
        local playerHasWaitedConquest = getConquestTally() ~= player:getCharVar("TOAU_RING_REACQ_WAIT")
        local playerToauRingRacqStatus = player:getCharVar("TOAU_RING_REACQ_STATUS")

        if (eternalMercenaryComplete and (not playerHasToauRing) and playerHasWaitedConquest and (playerToauRingRacqStatus == 0)) then
            local line2 = string.format("Nadeey : Oh %s, you appear quite upset! What troubles you?", player:getName())
            player:PrintToPlayer("Nadeey : Welcome to Walahra Temple. Our doors are always open to those seeking knowledge.", 0xD)
            player:PrintToPlayer(line2, 0xD)
            player:PrintToPlayer("Nadeey : Ah, you have \"misplaced\" the ring entrsusted to you by Nashmeira. I see.", 0xD)
            player:PrintToPlayer("Nadeey : Fear not, I know exactly whom I can send in search of this \"lost\" ring...", 0xD)
            player:PrintToPlayer("Nadeey : I think a fee of say, 10 Imperial Gold Pieces should suffice for their services.", 0xD)
            --player:setCharVar("TOAU_RING_REACQ_STATUS", 1)
        elseif (playerToauRingRacqStatus == 1) then
            -- remind the player, 10 Imperial Gold Pieces
            player:PrintToPlayer("Nadeey : If you wish for your \"lost\" ring to be found, procure 10 Imperial Gold Pieces for me.", 0xD)
            player:PrintToPlayer("Nadeey : Consider it payment for the two who shall search all of Aht Urhgan.", 0xD)
            player:PrintToPlayer("Nadeey : May the wisdom of Walahra safely guide your steps...", 0xD)
        elseif (playerToauRingRacqStatus == 2) then
            -- remind the player, investigate Alzadaal Undersea Ruins
            player:PrintToPlayer("Nadeey : The search for your \"lost\" ring continues...", 0xD)
            player:PrintToPlayer("Nadeey : Perhaps to pass the time, you might wish to visit the Alzadaal Undersea Ruins and look for some old foes from your past.", 0xD)
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
    local string = string.format("onEventUpdate csid %s option %s", csid, option)
    player:PrintToPlayer(string, 0xD)
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
            player:setCharVar("TOAU_RING_REACQ_WAIT", getConquestTally())
        end
    elseif ((csid == 961 or csid == 962) and option == 2) then
        -- 2 is ULTHALAMS_RING
        if npcUtil.giveItem(player, ULTHALAMS_RING) then
            player:setCharVar("TOAU_RING_REACQ_STATUS", 0)
            player:setCharVar("TOAU_RING_REACQ_WAIT", getConquestTally())
        end
    elseif ((csid == 961 or csid == 962) and option == 3) then
        -- 3 is JALZAHNS_RING
        if npcUtil.giveItem(player, JALZAHNS_RING) then
            player:setCharVar("TOAU_RING_REACQ_STATUS", 0)
            player:setCharVar("TOAU_RING_REACQ_WAIT", getConquestTally())
        end
    end
end

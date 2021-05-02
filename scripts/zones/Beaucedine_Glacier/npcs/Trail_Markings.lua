-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Trail Markings
-- Dynamis Registration and Entry
-- !pos -284 -39 -422 111
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
-----------------------------------

local npcEnabled = false
local csRegisterGlass = 118 -- The time and destination for your foray into Dynamis will be recorded on your hourglass (registering a Perpet from a Timeless)
local csEntry = 119 -- You just traded the perpetual and the msg says "You will now be warped to dynamis" "Ready!"
local csShroudedSand = nil -- cs with cornelia where you acquire the KI Vial of Shrouded Sand
local csWin = 134 -- cs after you get win, for example in cities it more or less says "Go win the other cities and then go to Beaucedine"

function onTrade(player, npc, trade)
    if npcEnabled == false then return end
    if player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) == false then return end
    if player:getMainLvl() < dynamis.min_lvl then
        player:messageSpecial(ID.text.PLAYERS_HAVE_NOT_REACHED_LEVEL, dynamis.min_lvl)
        return
    end
    
    local playerZoneID = player:getZoneID()
    local remaining = GetDynaTimeRemaining(dynamis.entryInfo[playerZoneID].enterPos[5])
    local hasEntered = player:getCharVar(dynamis.entryInfo[playerZoneID].hasEnteredVar)
    local timeSinceLastDynaReservation = player:timeSinceLastDynaReservation()
    
    if npcUtil.tradeHasExactly(trade, dynamis.timeless) then -- timeless hourglass, attempting to trade for a perpetual hourglass
        if remaining > 0 then
            player:messageSpecial(ID.text.ANOTHER_GROUP, dynamis.entryInfo[playerZoneID].csBit)
        elseif timeSinceLastDynaReservation < 71 then
            player:messageSpecial(ID.text.YOU_CANNOT_ENTER_DYNAMIS, 71-timeSinceLastDynaReservation, dynamis.entryInfo[playerZoneID].csBit)
        else
            player:startEvent(csRegisterGlass,dynamis.entryInfo[playerZoneID].csBit,hasEntered == 1 and 0 or 1,dynamis.reservation_cancel,dynamis.reentry_days,dynamis.maxchars,tpz.ki.VIAL_OF_SHROUDED_SAND,dynamis.timeless,dynamis.perpetual)
        end
    elseif npcUtil.tradeHasExactly(trade, dynamis.perpetual) then -- perpetual hourglass, attempting to enter a registered instance or start a new one
        local hgValid = player:checkHourglassValid(trade:getItem(0), dynamis.entryInfo[playerZoneID].enterPos[5])
        if hgValid > 0 then -- 0 = can't enter (wrong glass or didn't wait 71 hours since last dynamis), 1 = entering, 2 = re-entering (weakness)
            player:prepareDynamisEntry(trade:getItem(0), hgValid) -- save the hourglass's params to the character while they are viewing the cs
            player:startEvent(csEntry,dynamis.entryInfo[playerZoneID].csBit,hasEntered == 1 and 0 or 1,dynamis.reservation_cancel,dynamis.reentry_days,dynamis.maxchars,tpz.ki.VIAL_OF_SHROUDED_SAND,dynamis.timeless,dynamis.perpetual)
        elseif timeSinceLastDynaReservation < 71 then
            player:messageSpecial(ID.text.YOU_CANNOT_ENTER_DYNAMIS, 71-timeSinceLastDynaReservation, dynamis.entryInfo[playerZoneID].csBit)
        elseif remaining > 0 then
            player:messageSpecial(ID.text.ANOTHER_GROUP, dynamis.entryInfo[playerZoneID].csBit)
        end
    end
    
end

function onTrigger(player, npc)
    if npcEnabled == false then return end
    local playerZoneID = player:getZoneID()
    if csShroudedSand ~= nil and player:getCharVar("HasSeenXarcabardDynamisCS") == 1 and player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) == false then
        player:startEvent(csShroudedSand)
    elseif csWin ~= nil and player:hasKeyItem(dynamis.entryInfo[playerZoneID].winKI) and player:getCharVar(dynamis.entryInfo[playerZoneID].hasSeenWinCSVar) == 0 then
        player:startEvent(csWin)
    else
        player:messageSpecial(ID.text.DYNA_NPC_DEFAULT_MESSAGE)
    end
end

function onEventUpdate(player, csid, option)
    if npcEnabled == false then return end
    local playerZoneID = player:getZoneID()
    if csid == csRegisterGlass then -- trade out timeless hourglass for a perpetual hourglass
        player:release()
        if player:registerHourglass(dynamis.entryInfo[playerZoneID].enterPos[5]) == true then
            player:confirmTrade()
            player:messageSpecial(ID.text.INFORMATION_RECORDED, dynamis.perpetual)
            player:messageSpecial(ID.text.ITEM_OBTAINED, dynamis.perpetual)
        end
    end
end

function onEventFinish(player, csid, option)
    if npcEnabled == false then return end
    local playerZoneID = player:getZoneID()
    if csid == csEntry then -- enter dynamis
        if player:registerDynamis() == false then
            player:PrintToPlayer("The Dynamis instance has reached its maximum capacity of 64 registrants.",29)
        else
            local entryPos = dynamis.entryInfo[playerZoneID].enterPos
            if entryPos == nil then return end
            player:setCharVar(dynamis.entryInfo[playerZoneID].hasEnteredVar, 1)
            player:setPos(entryPos[1], entryPos[2], entryPos[3], entryPos[4], entryPos[5])
        end
    elseif csid == csShroudedSand then -- get shrouded sand
        npcUtil.giveKeyItem(player, tpz.ki.VIAL_OF_SHROUDED_SAND)
    elseif csid == csWin then -- just saw win cs
        player:setCharVar(dynamis.entryInfo[playerZoneID].hasSeenWinCSVar, 1)
    end
end

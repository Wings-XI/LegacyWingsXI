-----------------------------------
-- Area: Arrapago Reef
--  NPC: Cutter
-- The ship for The Black Coffin Battle (TOAU-15)
-- !pos -462 -2 -394 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/instance")
-----------------------------------

-- ToDo - move this logic to instance.lua via a shared function.  The caller can provide the player and the zone/npc
-- Having a "bit" set hides an option - althrough the param is an int
NONE                    = 1     -- 1th bit (1) hides "None"
DEBUG                   = 2     -- 2nd bit (2) hides what appears to be a jumbled debug string which attempts to start an assault
BLACK_COFFIN            = 4     -- 3rd bit (4) hides "The Black Coffin""
AGAINST_ALL_ODDS        = 8     -- 4th bit (8) hides "Against All Odds"
SCOUTING_THE_ASHU_TALIF = 16    -- 5th bit (16) hides "Scouting the Ashu Talif"
ROYAL_PAINTER           = 32    -- 6th bit (32) hides "Royal Painter Escort"
TARGETING_CAPTAIN       = 64    -- 7th bit (64) hides "Targeting the Captain"

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local allInstances = DEBUG + BLACK_COFFIN + AGAINST_ALL_ODDS + SCOUTING_THE_ASHU_TALIF + ROYAL_PAINTER + TARGETING_CAPTAIN -- intentionally excluding the NONE option
    local availableInstances = allInstances

    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_BLACK_COFFIN and player:hasKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN) then
        availableInstances = bit.bxor(availableInstances, BLACK_COFFIN)
    end

    if player:hasKeyItem(tpz.ki.LIFE_FLOAT) and player:getCharVar("AgainstAllOdds") == 2 then
        availableInstances = bit.bxor(availableInstances, AGAINST_ALL_ODDS)
    elseif player:getCharVar("AgainstAllOdds") == 3 then
        -- onZoneIn handles re-issue of cutscene
        player:setPos(0, 0, 0, 0, 54)
    end

    --if player:getCharVar("Halshaob_Quest") == 2 then
    if VerfyInstanceForPlayer(player, 55, true) then
        availableInstances = bit.bxor(availableInstances, SCOUTING_THE_ASHU_TALIF)
    end

    if availableInstances < allInstances then
        player:startEvent(221, 54, availableInstances, 0, 99, 6, 0)
    else
        player:messageSpecial(ID.text.YOU_NO_REQS)
    end
end

function onEventUpdate(player, csid, option, target)
    if (csid == 221) then
        local party = player:getParty()
        if (option == 524288) then -- 524288 - BLACK_COFFIN
            if (party ~= nil) then
                for i, v in ipairs(party) do
                    if not (v:hasKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN) or v:hasCompletedMission(TOAU, tpz.mission.id.toau.THE_BLACK_COFFIN)) then
                        player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                        player:instanceEntry(target, 1)
                        return
                    elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
            player:createInstance(53, 60)
        elseif (option == 786432) then -- 786432 - AGAINST_ALL_ODDS
            if (party ~= nil) then
                for i, v in ipairs(party) do
                    if v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
            player:createInstance(54, 60)
        elseif option == 1048576 then -- SCOUTING_THE_ASHU_TALIF
            if (party ~= nil) then
                for i, v in ipairs(party) do
                    -- if v:getCharVar("Halshaob_Quest") ~= 2 then
                    if not VerfyInstanceForPlayer(v, 55, false) then
                        player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                        player:instanceEntry(target, 1)
                        return
                    elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                        player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                        player:instanceEntry(target, 1)
                        return
                    end
                end
            end
            player:createInstance(55, 60)
        end
        -- Future options
        -- option 1310720 - ROYAL_PAINTER
        -- option 1572864 - TARGETING_CAPTAIN
    end
end

function onEventFinish(player, csid, option)
    if (csid == 221 and option == 4) then
        player:setPos(0, 0, 0, 0, 60)
    end
end

function onInstanceCreated(player, target, instance)
    if (instance) then
        player:setInstance(instance)
        player:instanceEntry(target, 4)

        local party = player:getParty()
        if (party ~= nil) then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:startEvent(222, 6)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end

-----------------------------------
--  Area: Attohwa Chasm
--  NPC:  Loose sand
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")

local jewelTimer
jewelTimer = function(player)
    if
        not player or
        not player:hasKeyItem(tpz.ki.MIMEO_JEWEL)
    then
        return
    end
    
    local messageOffset = player:getLocalVar("MimeoOffset")
    
    if messageOffset == 5 then
        player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + 5, tpz.ki.MIMEO_JEWEL)
        player:delKeyItem(tpz.ki.MIMEO_JEWEL)
        player:setLocalVar("MimeoOffset", 0)
    elseif messageOffset >= 0 and messageOffset < 5 then
        player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + messageOffset, tpz.ki.MIMEO_JEWEL)
        player:setLocalVar("MimeoOffset", messageOffset + 1)
        player:timer(6 * 60 * 1000, function(player)
            jewelTimer(player)
        end)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local missionStatus = player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")

    if player:checkDistance(npc) < 0.5 then
        if
            copCurrentMission == tpz.mission.id.cop.THE_ROAD_FORKS and
            (missionStatus == 7 or missionStatus == 8)
        then
            if
                not GetMobByID(ID.mob.LIOUMERE):isSpawned() and
                player:getCharVar("LioumereKilled") ~= 1
            then
                SpawnMob(ID.mob.LIOUMERE):updateClaim(player)
            elseif
                player:getCharVar("LioumereKilled") == 1 and
                not player:hasKeyItem(tpz.ki.MIMEO_JEWEL)
            then
                player:addKeyItem(tpz.ki.MIMEO_JEWEL)
                player:setLocalVar("MimeoOffset", 0)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MIMEO_JEWEL)
                jewelTimer(player)
            else
                player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
            end
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    else
        player:messageSpecial(ID.text.MOVE_CLOSER)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

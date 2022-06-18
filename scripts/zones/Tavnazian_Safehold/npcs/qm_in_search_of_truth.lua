-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: ??? (qm_in_search_of_the_truth_first)
-- QM for Quest: In Search Of The Truth 
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local npcID = npc:getID()
    if player:getCharVar("InSearchOfTheTruthStatus") == 3 and player:getCharVar("InSearchOfTheTruthDone") ~= 1 then
        if npcID == ID.npc.QM_IN_SEARCH_OF_TRUTH_BASE then
            if player:getCharVar(string.format("InSearchOfTheTruthQM_%d", npcID)) ~= 1 then
                player:addKeyItem(tpz.ki.SHADED_CRUSE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHADED_CRUSE)
                player:setCharVar(string.format("InSearchOfTheTruthQM_%d", npcID), 1)
            else
                player:messageSpecial(ID.text.TRAIL_OF_WATER)
            end
        elseif player:getCharVar(string.format("InSearchOfTheTruthQM_%d", npcID-1)) == 1 then
            player:setCharVar(string.format("InSearchOfTheTruthQM_%d", npcID), 1)
            if npcID == ID.npc.QM_IN_SEARCH_OF_TRUTH_BASE+4 then
                player:startEvent(558)
            else
                player:messageSpecial(ID.text.TRAIL_OF_WATER)
            end
        else
            player:messageSpecial(ID.text.TRAIL_OF_WATER)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventFinish(player, csid, option)
    if csid == 558 then
        player:setCharVar("InSearchOfTheTruthDone", 1)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.IN_SEARCH_OF_THE_TRUTH)
        player:delKeyItem(tpz.ki.SHADED_CRUSE)
    end
end


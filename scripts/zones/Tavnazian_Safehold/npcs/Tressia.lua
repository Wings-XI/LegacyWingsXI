-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Tressia
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local truthStatus = player:getCharVar("InSearchOfTheTruthStatus")
    local truthInitialNPCs = player:getCharVar("InSearchOfTheTruthNPC_1") + player:getCharVar("InSearchOfTheTruthNPC_2") + player:getCharVar("InSearchOfTheTruthNPC_3") + player:getCharVar("InSearchOfTheTruthNPC_4") 
    local truthMidNPCs = player:getCharVar("InSearchOfTheTruthNPC_5") + player:getCharVar("InSearchOfTheTruthNPC_6")
    local truthDone = player:getCharVar("InSearchOfTheTruthDone")

    if player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.IN_SEARCH_OF_THE_TRUTH) == QUEST_AVAILABLE then
        player:startEvent(544)
    elseif truthStatus == 1 then
        if truthInitialNPCs == 4 then
            player:startEvent(557)
        else
            player:startEvent(556)
        end
    elseif truthStatus == 2 and truthMidNPCs == 2 then
        player:startEvent(565)
    elseif truthStatus == 3 and truthDone == 1 then
        player:startEvent(562)
    else
        player:startEvent(310)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 544 then
        player:setCharVar("InSearchOfTheTruthStatus", 1)
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.IN_SEARCH_OF_THE_TRUTH)
    elseif csid == 557 and option == 1 then
        player:setCharVar("InSearchOfTheTruthStatus", 2)
    elseif csid == 565 and option == 1 then
        player:setCharVar("InSearchOfTheTruthStatus", 3)
    elseif csid == 562 then
        player:setCharVar("InSearchOfTheTruthReward", 1)
    end
end

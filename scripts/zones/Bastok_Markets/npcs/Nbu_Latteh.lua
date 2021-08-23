-----------------------------------
-- Area: Bastok Markets
--  NPC: Nbu Latteh
-- Starts & Finishes Quest: Mom, The Adventurer?
-- Starts Quest: The Signpost Marks the Spot
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pFame = player:getFameLevel(BASTOK)
    local momTheAdventurer = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MOM_THE_ADVENTURER)
    local signPostMarksTheSpot = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT)
    local questStatus = player:getCharVar("MomTheAdventurer_Event")

    if (player:needToZone()) then
        player:startEvent(127) -- chat about my work
    elseif momTheAdventurer == QUEST_AVAILABLE then
        -- Allow player to start quest regardless of fame
        player:startEvent(230)
    elseif (momTheAdventurer >= QUEST_ACCEPTED and questStatus == 2) then
        -- Quest is accepted or completed, and questStatus indicates it's in progress (if repeated)
        if (player:seenKeyItem(tpz.ki.LETTER_FROM_ROH_LATTEH)) then
            player:startEvent(234)
        elseif (player:hasKeyItem(tpz.ki.LETTER_FROM_ROH_LATTEH)) then
            player:startEvent(233)
        else
            player:startEvent(231)
        end
    elseif (pFame >= 2 and signPostMarksTheSpot == QUEST_AVAILABLE and momTheAdventurer == QUEST_COMPLETED and questStatus == 0) then
        -- If player can start next quest, do that.
        -- Note: momTheAdventurer must be completed AND questStatus must be 0 to handle the case where the quest is repeated at fame 1 and the players fame increases to 2 after accepting
        player:startEvent(235)
    elseif (pFame < 2 and momTheAdventurer ~= QUEST_ACCEPTED and questStatus == 0) then
        -- Player may repeat until they reach fame level 2, at which point they will be offered "The Signpost Marks the Spot"
        player:startEvent(230)
    else
        player:startEvent(127)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 230 and option == 0) then
        if (player:getFreeSlotsCount(0) > 0) then
            player:setCharVar("MomTheAdventurer_Event", 1)
            player:addItem(4096)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4096) -- Fire Crystal
            if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MOM_THE_ADVENTURER) == QUEST_AVAILABLE) then
                player:addQuest(BASTOK, tpz.quest.id.bastok.MOM_THE_ADVENTURER)
            end
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4096)
        end
    elseif (csid == 233 or csid == 234) then
        if (player:seenKeyItem(tpz.ki.LETTER_FROM_ROH_LATTEH)) then
            gilReward = 100
        else
            gilReward = 200
        end
        player:needToZone(true)
        player:delKeyItem(tpz.ki.LETTER_FROM_ROH_LATTEH)
        player:addTitle(tpz.title.RINGBEARER)
        player:addGil(GIL_RATE*gilReward)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*gilReward)
        player:setCharVar("MomTheAdventurer_Event", 0)

        if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MOM_THE_ADVENTURER) == QUEST_ACCEPTED) then
            player:addFame(BASTOK, 20)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.MOM_THE_ADVENTURER)
        else
            player:addFame(BASTOK, 8)
        end
    elseif (csid == 235 and option == 0) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT)
        player:setCharVar("MomTheAdventurer_Event", 0)
    end

end

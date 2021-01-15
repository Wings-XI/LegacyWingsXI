-----------------------------------
-- Area: Metalworks
--  NPC: Romualdo
-- !pos 135.035 -18.474 -37.419 237
-- Involved in Quest: Stamp Hunt, Message on the Winds, Faded Promises
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)
    local FadedPromises = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FADED_PROMISES)
    local Winds = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.MESSAGE_ON_THE_WINDS)
    local WindsVar = player:getCharVar("Quest[7][1]Prog")

    if (StampHunt == QUEST_ACCEPTED and not utils.mask.getBit(player:getCharVar("StampHunt_Mask"), 4)) then
        player:startEvent(726)
    elseif (FadedPromises == QUEST_AVAILABLE and player:getMainJob() == tpz.job.NIN and player:getMainLvl() >= 20 and player:getFameLevel(NORG) >= 4) then
        player:startEvent(802)
    elseif ENABLE_WOTG == 1 and Winds == QUEST_AVAILABLE and player:getMainLvl() >= 20 and WindsVar <= 1 then
        player:startEvent(952) -- Start quest, not in log yet
    elseif Winds == QUEST_COMPLETED and player:getCharVar("WindsPostCS") == 1 then
        player:startEvent(953)
    else
        player:startEvent(705)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 726) then
        player:setCharVar("StampHunt_Mask", utils.mask.setBit(player:getCharVar("StampHunt_Mask"), 4, true))
    elseif csid == 802 then
        player:addQuest(BASTOK, tpz.quest.id.bastok.FADED_PROMISES)
        player:setCharVar("FadedPromises", 1)
    elseif csid == 952 then
   		player:setCharVar("Quest[7][1]Prog", 1)
    elseif csid == 953 then
        player:setCharVar("WindsPostCS", 2)
    end

end

-----------------------------------
-- Area: Port Windurst (240)
-- NPC: Kuriodo-Moido
-- Involved In Quest: Making Amends, Wonder Wands,
-- Starts and Finishes: Making Amens!, Orastery Woes
-- !pos -112.5 -4.2 102.9 240
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------

local wsQuest = tpz.wsquest.black_halo

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local makingAmends = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_AMENDS) --First quest in series
    local makingAmens = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_AMENS) --Second quest in series
    local wonderWands = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDER_WANDS) --Third and final quest in series
    local pfame = player:getFameLevel(WINDURST)
    local needToZone = player:needToZone()
    local brokenWand = player:hasKeyItem(tpz.ki.BROKEN_WAND)

    if player:getCurrentMission(ASA) == tpz.mission.id.asa.THAT_WHICH_CURDLES_BLOOD and player:getLocalVar("asa-seen") == 0 then
        player:setLocalVar("asa-seen", 1)
        local kit = player:getCharVar("ASA_kit")
        local potion = 0

        if kit == 2779 then potion = 4157
        elseif kit == 2780 then potion = 4163
        elseif kit == 2781 then potion = 4161
        elseif kit == 2782 then potion = 4162
        end

        player:startEvent(858, kit, 1134, 0, 2778, potion, 4099)
    elseif wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (makingAmends == QUEST_ACCEPTED) then -- MAKING AMENDS: During Quest
        player:startEvent(276)
    elseif (makingAmends == QUEST_COMPLETED and makingAmens ~= QUEST_COMPLETED and wonderWands ~= QUEST_COMPLETED and needToZone) then -- MAKING AMENDS: After Quest
        player:startEvent(279)
    elseif (makingAmends == QUEST_COMPLETED and makingAmens == QUEST_AVAILABLE) then
        if (pfame >=4 and not needToZone) then
            player:startEvent(280) -- Start Making Amens! if prerequisites are met
        else
            player:startEvent(279) -- MAKING AMENDS: After Quest
        end
    elseif (makingAmens == QUEST_ACCEPTED and not brokenWand) then -- Reminder for Making Amens!
        player:startEvent(283)
    elseif (makingAmens == QUEST_ACCEPTED and brokenWand) then -- Complete Making Amens!
        player:startEvent(284, GIL_RATE*6000)
    elseif (makingAmens == QUEST_COMPLETED) then
        if (wonderWands == QUEST_ACCEPTED) then -- During Wonder Wands dialogue
            player:startEvent(261)
        elseif (wonderWands == QUEST_COMPLETED) then -- Post Wonder Wands dialogue
            player:startEvent(266)
        else
            player:startEvent(286, 0, 937) -- Post Making Amens! dialogue (before Wonder Wands)
        end
    else
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(225)   -- Standard Conversation
        else
            player:startEvent(226)   -- Standard Conversation
        end
    end
end

function onEventFinish(player, csid, option)
    if csid ~= 858 then player:setLocalVar("asa-seen", 0) end -- "You will need to talk to Kuroido-Moido twice if the mission That Which Curdles Blood is active."
    if (csid == 280) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.MAKING_AMENS)
    elseif (csid == 284) then
        player:needToZone(true)
        player:delKeyItem(tpz.ki.BROKEN_WAND)
        player:addTitle(tpz.title.HAKKURURINKURUS_BENEFACTOR)
        player:addGil(GIL_RATE*6000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*6000)
        player:addFame(WINDURST, 150)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.MAKING_AMENS)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.BLACK_HALO_LEARNED)
    end
end

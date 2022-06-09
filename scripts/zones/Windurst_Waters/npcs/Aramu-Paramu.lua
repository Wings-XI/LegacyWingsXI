-----------------------------------
-- Area: Windurst Waters
--  NPC: Aramu-Paramu
-- Involved In Quest: Wondering Minstrel
-- !pos -63 -4 27 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    wonderingstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDERING_MINSTREL)
    if wonderingstatus == QUEST_ACCEPTED then
        player:startEvent(683) -- WONDERING_MINSTREL: Quest Accepted "i'm worried about Jatan-Paratan..."
    elseif wonderingstatus == QUEST_COMPLETED then
        player:startEvent(684) -- WONDERING_MINSTREL: Quest After "we all have our own problems, such is the spice of life..."
    else
        -- pick a random standard conversation? he has four but the wiki doesn't mention the conditions for them
        local choice = math.random(0,3)
        player:startEvent(605+choice)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

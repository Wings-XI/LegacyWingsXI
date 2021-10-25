-----------------------------------
-- Area: Windurst Waters
--  NPC: Kirarara
-- Involved in Quest: Making the Grade
-- !pos 132 -7 172 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(447) -- During Making the GRADE
    else
        player:startEvent(425)  -- Standard conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

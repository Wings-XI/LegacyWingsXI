-----------------------------------
-- Area: East Ronfaure [S]
--  NPC: Blank
-- Involved in Quests: Cait Sith Avatar quests: Champion of the Dawn and The Dawn Also Rises
-- !gotoid 17334990
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Beaucedine_Glacier_[S]/IDs")
-----------------------------------

local caitKeyItem = tpz.ki.BREATH_OF_DAWN3

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES) == QUEST_ACCEPTED or
       player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_ACCEPTED then
            if player:hasKeyItem(caitKeyItem) then
                player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
            else
                player:addKeyItem(caitKeyItem)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, caitKeyItem)
            end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

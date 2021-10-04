-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Kuu Mohzolhi
-- Starts and Finishes Quest: Growing Flowers
-- !pos -123 0 80 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)

    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GROWING_FLOWERS) == (QUEST_ACCEPTED or QUEST_COMPLETED) then
        
        local count = trade:getItemCount()
        local gil = trade:getGil()
        local GrowingFlowers = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GROWING_FLOWERS)

        if (trade:getItemCount() == 1 and trade:getGil() == 0) then
            if (trade:hasItemQty(958, 1)) then -- Marguerite
                itemQuality = 2
            elseif (trade:hasItemQty((1742 or 1743 or 1744 or 1745), 1)) then -- Presents Trade
                itemQuality = 3
            elseif (trade:hasItemQty((4215 or 4216 or 4217 or 4218 or 4167 or 4168 or 4169), 1)) then -- Fireworks Trade
                itemQuality = 3
            else
                itemQuality = 1
            end
        end

        if (itemQuality == 2) then
            if (GrowingFlowers == QUEST_COMPLETED) then
                player:startEvent(605, 0, 231, 4)
            else
                player:startEvent(605, 0, 231, 2)
            end
        elseif (itemQuality == 1) then
            if (GrowingFlowers == QUEST_ACCEPTED) then
                player:startEvent(605, 0, 231, 3)
            else
                player:startEvent(605, 0, 231, 1)
            end
        elseif (itemQuality == 3) then
            onStarlightSmilebringersTrade(player, trade, npc)
        else
            player:startEvent(605, 0, 231, 0)
        end
    end

    onStarlightSmilebringersTrade(player, trade, npc)

end

function onTrigger(player, npc)
    player:startEvent(605, 0, 231, 10)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 605 and option == 1002) then
        player:tradeComplete()
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.GROWING_FLOWERS)
        player:addFame(SANDORIA, 120)
        player:moghouseFlag(1)
        player:messageSpecial(ID.text.MOGHOUSE_EXIT)
    elseif (csid == 605 and option == 10) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.GROWING_FLOWERS)
    end
end

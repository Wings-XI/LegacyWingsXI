-----------------------------------
-- Area: Windurst Walls
--  NPC: Ojha Rhawash
-- Starts and Finishes Quest: Flower Child
-- !pos -209 0 -134 239

-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/events/starlight_festivals")
----------------------------------

function onTrade(player, npc, trade)

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD) == (QUEST_ACCEPTED or QUEST_COMPLETED) then

        local count = trade:getItemCount()
        local gil = trade:getGil()
        local FlowerChild = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD)

        if (trade:getItemCount() == 1 and trade:getGil() == 0) then
            if (trade:hasItemQty(956, 1)) then  -- Lilac
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
            if (FlowerChild == QUEST_COMPLETED) then
                player:startEvent(10000, 0, 239, 4)
            else
                player:startEvent(10000, 0, 239, 2)
            end
        elseif (itemQuality == 1) then
            if (FlowerChild == QUEST_COMPLETED) then
                player:startEvent(10000, 0, 239, 5)
            elseif (FlowerChild == QUEST_ACCEPTED) then
                player:startEvent(10000, 0, 239, 3)
            else
                player:startEvent(10000, 0, 239, 1)
            end
        elseif (itemQuality == 3) then
            onStarlightSmilebringersTrade(player, npc, trade)
        else
            player:startEvent(10000, 0, 239, 0)
        end
    end

    onStarlightSmilebringersTrade(player, trade, npc)
    
end

function onTrigger(player, npc)
    player:startEvent(10000, 0, 239, 10)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 10000 and option == 3002) then
        player:tradeComplete()
        player:completeQuest(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD)
        player:addFame(WINDURST, 120)
        player:moghouseFlag(4)
        player:messageSpecial(ID.text.MOGHOUSE_EXIT)
    elseif (csid == 10000 and option == 10) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD)
    end
end

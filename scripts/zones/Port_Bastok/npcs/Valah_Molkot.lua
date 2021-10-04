-----------------------------------
-- Area: Port Bastok
--  NPC: Valah Molkot
-- Starts and Finishes Quest: A Lady's Heart
-- !pos 59 8 -221 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/keyitems")
-----------------------------------


function onTrade(player, npc, trade)

    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART) == (QUEST_ACCEPTED or QUEST_COMPLETED) then
        local count = trade:getItemCount()
        local gil = trade:getGil()
        local ALadysHeart = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)

        if (trade:getItemCount() == 1 and trade:getGil() == 0) then
            if (trade:hasItemQty(957, 1)) then -- Amaryllis
                itemQuality = 2
            elseif (trade:hasItemQty((1742 or 1743 or 1744 or 1745), 1)) then -- Presents Trade
                itemQuality = 3
            elseif (trade:hasItemQty((4215 or 4216 or 4217 or 4218 or 4167 or 4168 or 4169), 1)) then -- Fireworks Trade
                itemQuality = 3
            else
                itemQuality = 1
            end
        end

        ALadysHeart = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)

        if (itemQuality == 2) then
            if (ALadysHeart == QUEST_COMPLETED) then
                player:startEvent(160, 0, 236, 4)
            else
                player:startEvent(160, 0, 236, 2)
            end
        elseif (itemQuality == 1) then
            if (ALadysHeart == QUEST_COMPLETED) then
                player:startEvent(160, 0, 236, 5)
            elseif (ALadysHeart == QUEST_ACCEPTED) then
                player:startEvent(160, 0, 236, 3)
            else
                player:startEvent(160, 0, 236, 1)
            end
        elseif (itemQuality == 3) then
            onStarlightSmilebringersTrade(player, npc, trade)
        else
            player:startEvent(160, 0, 236, 0)
        end
    end

    onStarlightSmilebringersTrade(player, trade, npc)

end

function onTrigger(player, npc)
    player:startEvent(160, 0, 236, 10)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 160 and option == 2002) then
        player:tradeComplete()
        player:completeQuest(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)
        player:addFame(BASTOK, 120)
        player:moghouseFlag(2)
        player:messageSpecial(ID.text.MOGHOUSE_EXIT)
    elseif (csid == 160 and option == 10) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)
    end
end

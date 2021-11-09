-----------------------------------
-- Area: Uleguerand Range
--  NPC: Chamnaet Spring
--  Receive Chamnaet Ice upon trading Cotton Pouch
-- !pos -305.240 3.605 17.977
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    -- Trade Cotton Pouch
    if (trade:hasItemQty(1779, 1) and trade:getItemCount() == 1) and Anniversary_Event_2021 == 1 then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1780) -- Chamnaet Ice
        else
            player:tradeComplete()
            player:addItem(1780)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1780) -- Chamnaet Ice
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("AnnyEvent2020") == 10 and player:getCharVar("AnnyEvent2020_spring") == 0 then
        if player:getFreeSlotsCount() > 0 and player:hasItem(1540) == false then
            player:setCharVar("AnnyEvent2020_spring", 1)
            player:addItem(1540)
            player:PrintToPlayer("You notice an object deep within the spring..", 0xD)
            player:messageSpecial((ID.text.ITEM_OBTAINED), 1540)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1540)
        end
    end
end

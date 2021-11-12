-----------------------------------
-- Area: Bastok Markets
--  NPC: Reet
-- Adventurer's Assistant
-- !pos -237 -12 -41 235
-------------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(6)
    end
end

function onTrigger(player, npc)
    if player:getCharVar("AnnyEvent2020") == 0 and player:getNation() == 1 and Anniversary_Event_2021 == 1 then
        if player:getFreeSlotsCount() > 0 and player:hasItem(536) == false then
            player:setCharVar("AnnyEvent2020", 1)
            player:PrintToPlayer("Reet : Oh its you! Its been quite awhile since i've seen you.", 0xD)
            player:PrintToPlayer("Reet : You seem to have some a long way since then, I have something for you.", 0xD)
            player:PrintToPlayer("Reet : The mage who is always full of herself has been looking for this...", 0xD)
            player:addItem(536)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 536)
            player:PrintToPlayer("Reet : Come back after sorting that mess of an inventory...", 0xD)
        end
    else
        player:startEvent(5)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 6) then
        player:tradeComplete()
        player:addGil(GIL_RATE*50)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end
end

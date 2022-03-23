-----------------------------------
-- Area: Windurst Woods
--  NPC: Jack of Spades
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
local ID = require("scripts/zones/Windurst_Woods/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 536) then -- adventurer coupon
        player:startEvent(10010, GIL_RATE * 50)
    end
end

function onTrigger(player, npc)
    if player:getCharVar("AnnyEvent2020") == 0 and player:getNation() == 2 and Anniversary_Event_2021 == 1 then
        if player:getFreeSlotsCount() > 0 and player:hasItem(536) == false then
            player:setCharVar("AnnyEvent2020", 1)
            player:PrintToPlayer("Jack of Spades : Oh its you! Its been quite awhile since i've seen you.", 0xD)
            player:PrintToPlayer("Jack of Spades : You seem to have some a long way since then, I have something for you.", 0xD)
            player:PrintToPlayer("Jack of Spades : The mage who is always full of herself has been looking for this...", 0xD)
            player:addItem(536)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 536)
            player:PrintToPlayer("Jack of Spades : Come back after sorting that mess of an inventory...", 0xD)
        end
    else
        player:startEvent(10009, 0, 4)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10010 then
        player:confirmTrade()
        player:addGil(GIL_RATE * 50)
    end
end
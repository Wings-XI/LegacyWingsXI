-----------------------------------
-- Area: Al Zahbi
--  NPC: Zazarg
-- Type: Stoneserpent General
-- !pos -41.675 -8 104.452 48
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("AnnyEvent2020") == 9 and Anniversary_Event_2021 == 1 then
        if trade:hasItemQty(840, 1) and trade:getItemCount() == 1 then
            player:tradeComplete()
            player:setCharVar("AnnyEvent2020", 10)
            player:PrintToPlayer("Zazarg : Isn't the Empire grand? Its been awhile since we've stopped to look around.. And enjoy the sights.", 0xD)
            player:PrintToPlayer("Zazarg : Thanks for bringing this, Only a few more stops..", 0xD)
            player:PrintToPlayer("Zazarg : Journey to the tops of two mountains, and bring the rewards to the creation of the enemy on a far island..", 0xD)
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(268)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

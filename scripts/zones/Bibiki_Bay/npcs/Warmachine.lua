-----------------------------------
-- Area: Bibiki Bay
--  NPC: Warmachine
-- !pos -345.236 -3.188 -976.563 4
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/missions")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("AnnyEvent2020") == 10 and player:getCharVar("AnnyEvent2020_spring") == 1 and player:getCharVar("AnnyEvent2020_cradle") == 1 and Anniversary_Event_2021 == 1 then
        if trade:hasItemQty(1537, 1) and trade:hasItemQty(1540, 1) and trade:getItemCount() == 2 then
            player:tradeComplete()
            player:setCharVar("AnnyEvent2020", 11)
            player:PrintToPlayer("Warmachine : Items... Recieved..........", 0xD)
            player:PrintToPlayer("Warmachine : Dispensing... Orders....", 0xD)
            player:PrintToPlayer("Warmachine : Travel to the great kings, and the lands they inhabit..", 0xD)
            player:PrintToPlayer("Warmachine : Bring thy rewards.. To an ally behind enemy lines...", 0xD)
        end
    end
end

function onTrigger(player, npc)

local ColoredDrop = 4258+math.random(0, 7)

    -- COP mission
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Louverance_s_Path") == 2) then
        player:setCharVar("COP_Louverance_s_Path", 3) -- set variable before starting cs in case it doesn't register after completion
        player:startEvent(33)
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("COP_3-taru_story")== 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ColoredDrop)
        else
            player:setCharVar("ColoredDrop", ColoredDrop)
            player:startEvent(43)
        end
    -- standard dialog
    else

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 33) then
        player:setCharVar("COP_Louverance_s_Path", 3)
    elseif (csid == 43) then
        local ColoredDropID=player:getCharVar("ColoredDrop")
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, ColoredDropID)
        else
            player:addItem(ColoredDropID)
            player:messageSpecial(ID.text.ITEM_OBTAINED, ColoredDropID)
            player:setCharVar("COP_3-taru_story", 2)
            player:setCharVar("ColoredDrop", 0)
        end
    end

end

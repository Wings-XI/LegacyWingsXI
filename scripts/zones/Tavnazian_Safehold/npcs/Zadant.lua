-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Zadant
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthStatus") == 1  and player:getCharVar("InSearchOfTheTruthNPC_2") ~= 1 then
        player:startEvent(551)
    else
        player:startEvent(326)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 551 then
        player:setCharVar("InSearchOfTheTruthNPC_2", 1)
    end
end

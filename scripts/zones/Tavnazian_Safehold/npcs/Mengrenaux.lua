-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Mengrenaux
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthStatus") == 2 and player:getCharVar("InSearchOfTheTruthNPC_6") ~= 1 then
        player:startEvent(560)
    else
        player:startEvent(270)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 560 then
        player:setCharVar("InSearchOfTheTruthNPC_6", 1)
    end
end

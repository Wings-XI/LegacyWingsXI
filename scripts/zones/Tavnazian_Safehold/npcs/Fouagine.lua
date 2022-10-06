-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Fouagine
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthStatus") == 1  and player:getCharVar("InSearchOfTheTruthNPC_3") ~= 1 then
        player:startEvent(553)
    else
        player:startEvent(338)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 553 then
        player:setCharVar("InSearchOfTheTruthNPC_3", 1)
    end
end

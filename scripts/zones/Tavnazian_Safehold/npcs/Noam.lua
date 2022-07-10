-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Noam
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthStatus") == 1  and player:getCharVar("InSearchOfTheTruthNPC_4") ~= 1 then
        player:startEvent(555)
    else
        player:startEvent(363)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 555 then
        player:setCharVar("InSearchOfTheTruthNPC_4", 1)
    end
end

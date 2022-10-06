-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Raminey
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthStatus") == 1  and player:getCharVar("InSearchOfTheTruthNPC_1") ~= 1 then
        player:startEvent(549)
    else
        player:startEvent(159)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 549 then
        player:setCharVar("InSearchOfTheTruthNPC_1", 1)
    end
end

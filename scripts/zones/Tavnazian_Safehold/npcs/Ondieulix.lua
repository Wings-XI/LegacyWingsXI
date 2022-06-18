-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ondieulix
-- Standard Info NPC
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("InSearchOfTheTruthReward") == 1 then
        player:startEvent(559)
    else
        player:startEvent(285)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 559 then
        if npcUtil.giveItem(player, 15470) then
            player:setCharVar("InSearchOfTheTruthReward", 0)
        end
    end
end

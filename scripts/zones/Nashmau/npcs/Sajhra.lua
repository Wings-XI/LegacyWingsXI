-----------------------------------
-- Area: Nashmau
--  NPC: Sajhra
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")

    if(PuppetmasterBluesProgress == 5) then
        player:startEvent(291) -- Iruki-Waraki and Ellie reunite
    else
        player:startEvent(220)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 291) then
        player:setCharVar("PuppetmasterBluesProgress", 6)
    end
end

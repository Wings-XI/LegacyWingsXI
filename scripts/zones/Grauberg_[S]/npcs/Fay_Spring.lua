-----------------------------------
-- Area: Grauberg [S]
--  NPC: Fay Spring
--  Quest - Witchfire Glen
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 2525) then 
        player:tradeComplete()
        -- Increase global server amity
        local amity = GetServerVariable("PixieAmity")
        if amity < 255 then
            amity = amity + 10
            SetServerVariable("PixieAmity", utils.clamp(amity, -255, 255))
        end
        local hate = player:getCharVar("PIXIE_HATE")
		hate = hate - 5
		player:setPixieHate(utils.clamp(hate, 0, 60))
        player:startEvent(501, 0, 0, 0, 2)
        darkixion.onTradeFaySpring(player, npc)
    end
end

function onTrigger(player, npc)
    player:startEvent(501, 0, 0, 0, 1)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

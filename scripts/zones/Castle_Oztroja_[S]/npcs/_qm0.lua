-----------------------------------
-- Area: Castle Oztroja S
--  NPC: _qm0 (???)
-- Involved in Quest: The Lost Book
-- !pos -140.572, 0.054, -9.223
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local lostBookProgress = player:getCharVar("TheLostBookProgress")

    if lostBookProgress == 4 and not player:hasKeyItem(tpz.ki.LYNX_PELT) then
        player:addKeyItem(tpz.ki.LYNX_PELT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LYNX_PELT)    
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

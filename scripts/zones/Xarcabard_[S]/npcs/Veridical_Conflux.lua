-----------------------------------
-- Area: Xarcabard [S]
--  NPC: Veridical Conflux
-- !pos 239 -8 -247 137
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Xarcabard_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.KUPOFRIEDS_MEDALLION) == false then
        player:addKeyItem(tpz.ki.KUPOFRIEDS_MEDALLION)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.KUPOFRIEDS_MEDALLION)
    else
        player:startEvent(44)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 44 and option == 99 then
        player:setPos(-420, 13.5, -32, 192, 182) -- send to walk of echoes
    end
end

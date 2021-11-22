-----------------------------------
-- Area:  Bibiki Bay
-- NPC:   ??? (qm1)
-- Notes: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1823) and npcUtil.popFromQM(player, npc, ID.mob.SHEN) then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

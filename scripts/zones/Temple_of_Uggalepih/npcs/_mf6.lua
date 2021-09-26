-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: _mf8 (Granite Door)
-- Note: Opens with Uggalepih Key
-- !pos -208 -1.89 -20
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1136) then -- Uggalepih Key
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, 1136)
        npc:openDoor(6.5)
    end
end

function onTrigger(player, npc)
    if player:getXPos() >= -208 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, 1136)
    else
        npc:openDoor(11) -- retail timed
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

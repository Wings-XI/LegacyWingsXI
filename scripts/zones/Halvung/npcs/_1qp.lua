-----------------------------------
-- Area: Halvung
--  NPC: Decorative Bronze Gate (_1qp)
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2221) and -- HALVUNG_SHAKUDO_KEY
        npcUtil.tradeHas(trade, 2222) and -- HALVUNG_BRONZE_KEY
        npcUtil.tradeHas(trade, 2223) then -- HALVUNG_BRASS_KEY
            player:confirmTrade()
            npc:openDoor()
            player:messageSpecial(ID.text.KEY_BREAKS, 2221, 2222, 2223)
    end
end

function onTrigger(player, npc)
    if player:getZPos() <= 79.75 and npc:getAnimation() == tpz.anim.CLOSE_DOOR then --from inside the door
        npc:openDoor()
    else
        player:messageSpecial(ID.text.WIDE_TRENCH)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

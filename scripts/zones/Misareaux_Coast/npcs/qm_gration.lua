-----------------------------------
-- Area: Misareaux_Coast
--  NPC: ??? (Spawn Gration)
-- !pos 113.563 -16.302 38.912 25
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    local shieldChance = 0
    if npcUtil.tradeHas(trade, 12359) then -- Hickory Shield
        shieldChance = 500
        npc:setLocalVar("shield", 1)
    elseif npcUtil.tradeHas(trade, 12370) then -- Picaroon's Shield
        shieldChance = 1000
        npc:setLocalVar("shield", 2)
    end

    if shieldChance > 0 and npcUtil.popFromQM(player, npc, ID.mob.GRATION) then
        player:confirmTrade()
        SetDropRate(1218, 12360, shieldChance)
        if npc:getLocalVar("shield") == 1 then
            player:messageSpecial(ID.text.SNATCHED_AWAY, 12359)
        else
            player:messageSpecial(ID.text.SNATCHED_AWAY, 12370)
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SHATTERED_SHIELD)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

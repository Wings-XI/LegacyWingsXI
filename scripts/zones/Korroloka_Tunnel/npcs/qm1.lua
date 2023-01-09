-----------------------------------
-- Area: Korroloka Tunnel
--  NPC: ??? (qm1) - Morion Worm spawn
-- !pos 254.652 -6.039 20.878 173
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/zones/Korroloka_Tunnel/globals")
require("scripts/globals/npc_util")
-----------------------------------

function onSpawn(npc)
    KORROLOKA_TUNNEL.moveMorionWormQM()
end

function onTrade(player, npc, trade)
    if
        npc:getStatus() ~= tpz.status.DISAPPEAR and
        npcUtil.tradeHas(trade, 643) and -- Iron Ore
        npcUtil.popFromQM(player, npc, ID.mob.MORION_WORM, {radius=1, hide=0})
    then
        player:confirmTrade()
        npc:setStatus(tpz.status.DISAPPEAR)
        npc:updateNPCHideTime(math.random(600, 900))
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.MORION_WORM_1)
end

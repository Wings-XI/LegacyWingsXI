-----------------------------------
-- Area: Port Windurst
--  NPC: Mov Lingyoh
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    126.616, -3.173, 169.402,
    122.378, -3.703, 168.924,
    115.305, -4.065, 168.054,
    107.949, -4.679, 166.991,
    99.219, -4.403, 165.724,
    98.697, -4.245, 165.362,
    98.102, -3.970, 164.525,
    89.491, -4.000, 149.337,
    98.102, -3.970, 164.525,
    98.697, -4.245, 165.362,
    99.219, -4.403, 165.724,
    107.949, -4.679, 166.991,
    115.305, -4.065, 168.054,
    122.378, -3.703, 168.924,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(345)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

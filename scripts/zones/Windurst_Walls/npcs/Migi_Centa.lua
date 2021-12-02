-----------------------------------
-- Area: Windurst Walls
--  NPC: Migi Centa
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    47.213, -10.000, 20.012,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
    52.357, -9.728, 31.661,
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
    player:startEvent(324)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

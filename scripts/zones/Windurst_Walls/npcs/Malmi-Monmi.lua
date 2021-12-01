-----------------------------------
-- Area: Windurst Walls
--  NPC: Malmi-Monmi
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -101.174, -5.450, 148.387,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -103.634, -5.478, 146.359,
    -101.140, -5.559, 148.788, 
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
end

function onTrigger(player, npc)
    player:startEvent(295)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

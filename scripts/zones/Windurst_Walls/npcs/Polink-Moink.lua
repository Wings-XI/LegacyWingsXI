-----------------------------------
-- Area: Windurst Walls
--  NPC: Polink-Moink
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.473, -6.670, -36.168,
    -3.526, -6.822, -34.548,
    -3.605, -6.951, -32.150,
    -3.696, -6.876, -29.409,
    -3.820, -6.919, -25.643,
    -3.935, -7.808, -22.173,
    -4.101, -8.952, -17.130,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -3.577, -8.340, -8.364,
    -4.101, -8.952, -17.130,
    -3.935, -7.808, -22.173,
    -3.820, -6.919, -25.643,
    -3.696, -6.876, -29.409,
    -3.605, -6.951, -32.150,
    -3.526, -6.822, -34.548,
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
    player:startEvent(302)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

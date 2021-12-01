-----------------------------------
-- Area: Windurst Walls
--  NPC: Juna Moshal
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
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -0.478, -10.000, 284.884,
    -3.823, -10.002, 288.595,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -3.424, -10.000, 288.970,
    -0.298, -10.000, 284.675,
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
    player:startEvent(327)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

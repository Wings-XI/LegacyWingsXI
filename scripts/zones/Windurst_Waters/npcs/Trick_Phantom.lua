-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Phantom
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    2, -1, 18,
    -2, -1, 37,
    -54, -3, 40,
    -78, -3, 63,
    -81, -5, 86,
    -52, -5, 86,
    -56, -3, 64,
    -68, -3, 52,
    -40, -3, 38,
    -40, -5, 86,
    -9, -5, 86,
    -3, -1, 71,
    -7, -1, 27,
}

function onSpawn (npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onTrade(player, npc, trade)
    onHalloweenTrade(player, npc, trade)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TRICK_OR_TREAT)
end

-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -309, -12, -77,
    -306, -12, -86,
    -323, -15, -86,
    -328, -15 , -75,
    -317, -15, -67,
    -329, -15, -59,
    -321, -15, -51,
    -262, -12, -46,
    -253, -12, -70,
    -272, -12, -95,
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
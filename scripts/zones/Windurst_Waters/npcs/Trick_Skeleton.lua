-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Skeleton
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -58, -1, -161,
    -59, -2, -199,
    -52, -1, -162,
    -51, -2, -118,
    -35, -2, -102,
    -3, -2, -135,
    -3, -4, -179,
    -44, -1, -180,
}

function onSpawn (npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TRICK_OR_TREAT)
end
-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Wight
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    37, -4, -175,
    17, -4, -179,
    -48, -1, -179,
    -62, -1, -166,
    -11, -1, -160,
    -108, -1, -156,
    -88, -1, -158,
    -70, -1, -162,
    -49, -1, -167,
    -49, -1, -181,
    -42, -1, -179,
    17, -4, -180,
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
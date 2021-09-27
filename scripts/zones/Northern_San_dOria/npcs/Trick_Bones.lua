-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -181, 0, 99,
    -152, 0, 105,
    -149, 0, 125,
    -123, 0, 140,
    -124, 0, 182,
    -136, 0, 190,
    -162, 0, 190,
    -168, 0, 195,
    -170, 0, 240,
     172, 0, 256,
    -150, 0, 278,
    -174, 0, 253,
    -167, 0, 189,
    -176, 0, 177,
    -174, 0, 132,
    -152, 0, 123,
    -152, 0, 104,
    -181, 0, 99, 
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
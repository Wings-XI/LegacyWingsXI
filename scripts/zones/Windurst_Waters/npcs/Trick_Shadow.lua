-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Shadow
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
-- Local Path Table for (x,y,z)-- 
local path =
{
    185, 0, -21,
    142, 0 , -16,
    162, -1, 9,
    130, -2, 34,
    105, -2, 70,
    124, -2, 98,
    124, -2, 112,
    157, -2, 136,
    150, -2, 126,
    140, -2, 128,
    124, -2, 112,
    124, -2, 98,
    105, -2, 70,
    130, -2, 34,
    162, -1, 9,
    162, 0, -3,
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
-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -245, -12, -53,
    -278, -12, -36,
    -320, -15, -51, 
    -330, -15, -57,
    -329, -15, -79,
    -281, -12, -96,
    -254, -9, -122,
    -221, -6, -113,
    -193, -6, -81,
    -202, -6, -67,
    -242, -6, -74,
    -243, -12, -59,
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
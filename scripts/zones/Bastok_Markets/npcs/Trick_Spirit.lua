-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -305, -10, -113,
    -299, -10, -121,
    -308, -10, -131,
    -293, -15, -146,
    -308, -10, -131,
    -326, -10, -147,
    -310, -15, -164,
    -326, -10, -147,
    -358, -10, -178,
    -305, -10, -124,
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
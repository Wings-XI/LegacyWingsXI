-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Phantom
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -340, -10, -187,
    -352, -10, -174,
    -335, -10, -153,
    -290, -10, -109,
    -266, -10, -108,
    -295, -10, -115,
    -347, -10, -165,
    -364, -10, -160,
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

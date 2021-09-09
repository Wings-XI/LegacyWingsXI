-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Shadow
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
-- Local Path Table for (x,y,z)-- 
local path =
{
    -221, -8, 34,
    -243, -4, 34,
    -252, -1, 41,
    -458, -1, 51,
    -224, -2, 65,
    -188, -4, 60,
    -195, -4, 89,
    -257, 0, 66,
    -246, -3, 29,
    -176, -8, 30,
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
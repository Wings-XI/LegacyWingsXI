-----------------------------------
-- Area: Windurst Woods
--  NPC: Patsaa Maehoc
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.RUN
local path =
{
    0.665, -4.250, 53.641,
    0.665, -4.250, 53.641,
    0.665, -4.250, 53.641,
    0.665, -4.250, 53.641,
    -5.685, -4.250, 53.831,
    -10.590, -4.250, 53.978,
    -12.900, -4.250, 54.047,
    -12.900, -4.250, 54.047,
    -12.900, -4.250, 54.047,
    -12.900, -4.250, 54.047,
    -10.590, -4.250, 53.978,
    -5.685, -4.250, 53.831,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(427)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

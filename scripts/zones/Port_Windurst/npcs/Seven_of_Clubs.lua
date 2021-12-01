-----------------------------------
-- Area: Port Windurst
--  NPC: Seven of Clubs
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -16.732, -6.000, 150.484,
    -25.016, -6.000, 149.974,
    -30.5551, -6.000, 149.359,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -30.553, -6.000, 149.635,
    -25.016, -6.000, 149.974,
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
end

function onTrigger(player, npc)
    player:startEvent(220)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

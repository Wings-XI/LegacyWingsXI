-----------------------------------
-- Area: Windurst Walls
--  NPC: Komomo
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.RUN
local path =
{
    -185.998, -2.596, 150.789,
    -186.428, -2.565, 150.094,
    -186.996, -2.554, 150.019,
    -187.910, -2.547, 150.332,
    -188.308, -2.561, 151.251,
    -187.576, -2.560, 151.772,
    -186.621, -2.589, 151.791,
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
    player:startEvent(290)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

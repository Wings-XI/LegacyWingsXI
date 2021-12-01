-----------------------------------
-- Area: Windurst Woods
--  NPC: Orahi-Karapahi
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    63.612, -4.250, 102.695,
    63.612, -4.250, 102.695,
    63.612, -4.250, 102.695,
    63.612, -4.250, 102.695,
    60.000, -4.250, 103.188,
    58.772, -4.250, 103.357,
    58.772, -4.250, 103.357,
    58.772, -4.250, 103.357,
    58.772, -4.250, 103.357,
    60.000, -4.250, 103.188,
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
    player:startEvent(413)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

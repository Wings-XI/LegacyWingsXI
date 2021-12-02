-----------------------------------
-- Area: Windurst Waters
--  NPC: Shataru-Potaru
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    150.716, -2.500, 130.594,
    150.995, -2.500, 130.387,
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
    player:startEvent(585)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

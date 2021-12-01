-----------------------------------
-- Area: Windurst Woods
--  NPC: Seno Zarhin
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -31.412, 2.667, -46.021,
    -36.695, 2.906, -49.078,
    -37.131, 2.847, -49.978,
    -37.214, 2.836, -50.277,
    -38.365, 2.991, -55.456,
    -37.214, 2.836, -50.277,
    -37.131, 2.847, -49.978,
    -36.695, 2.906, -49.078,
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
    player:startEvent(417)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

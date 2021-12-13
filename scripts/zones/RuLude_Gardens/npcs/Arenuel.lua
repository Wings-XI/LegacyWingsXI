-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Arenuel
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.953, 1.996, 59.933, -- Force turn.
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    35.713, 1.996, 70.939, -- Force turn.
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    36.041, 1.996, 62.952, -- Force Turn.
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    35.953, 1.996, 59.933, -- Force turn.
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    35.713, 1.996, 70.939, -- Force turn.
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
    player:startEvent(120)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

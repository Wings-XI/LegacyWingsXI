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
    35.853, 1.996, 70.939, -- 1
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    36.089, 1.996, 59.933, -- 7
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    36.089, 1.996, 59.933,
    35.853, 1.996, 70.939, -- 13
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    35.853, 1.996, 70.939,
    36.317, 1.996, 62.952, -- 19
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.317, 1.996, 62.952,
    36.089, 1.996, 59.993, -- 25
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
    36.089, 1.996, 59.993,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) or npc:atPoint(tpz.path.get(path, 13)) then
        npc:setPos(35.853, 1.996, 70.939, 0)
    elseif npc:atPoint(tpz.path.get(path, 7)) then
        npc:setPos(36.089, 1.996, 59.933, 0)
    elseif npc:atPoint(tpz.path.get(path, 19)) then
        npc:setPos(36.317, 1.996, 62.952, 0)
    elseif npc:atPoint(tpz.path.get(path, 25)) then
        npc:setPos(36.089, 1.996, 59.993, 0)
    end
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

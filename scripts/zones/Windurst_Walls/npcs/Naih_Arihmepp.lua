-----------------------------------
-- Area: Windurst Walls
--  NPC: Naih Arihmepp
-- Type: Standard NPC
-- !pos -64.578 -13.465 202.147 239
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -63.660, -12.500, 204.874, -- 1
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.873, -- 6
    -63.660, -12.500, 204.873,
    -63.660, -12.500, 204.873,
    -63.660, -12.500, 204.873,
    -63.660, -12.500, 204.873,
    -67.755, -12.348, 192.724, -- 11
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.723,-- 18
    -67.755, -12.348, 192.723,
    -67.755, -12.348, 192.723,
    -67.755, -12.348, 192.723,
    -67.755, -12.348, 192.724, -- 22
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-63.660, -12.500, 204.874, 204)
    elseif npc:atPoint(tpz.path.get(path, 6)) then
        npc:setPos(-63.660, -12.500, 204.873, 10)
    elseif npc:atPoint(tpz.path.get(path, 11)) then
        npc:setPos(-67.755, -12.348, 192.724, 79)
    elseif npc:atPoint(tpz.path.get(path, 18)) then
        npc:setPos(-67.755, -12.348, 192.723, 6)
    elseif npc:atPoint(tpz.path.get(path, 22)) then
        npc:setPos(-67.755, -12.348, 192.724, 97)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 9)) then
        player:startEvent(500)
    else
        player:startEvent(326)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 500) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 9, true))
    end

end

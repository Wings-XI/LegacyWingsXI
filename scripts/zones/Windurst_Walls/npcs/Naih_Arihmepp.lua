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
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.937, -12.500, 204.913, -- Force turn.
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -63.660, -12.500, 204.874,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.895, -12.344, 192.732, -- Force turn.
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.755, -12.348, 192.724,
    -67.699, -12.350, 192.853, -- Force turn.
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

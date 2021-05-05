-----------------------------------
-- Area: Sacrarium
--  NPC: qm9 (???)
-- Invlved in quest: Secrets of Ovens Lost quest
-- !pos 11.720 -3.999 -99.957
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

local points =
{
    [1]  = { 11.720, -3.999, -99.957 }, -- H-11 on a shelf -- good
    [2]  = { 108.300, -3.999, -99.957 }, -- F-11 on a shelf
    [3]  = { 108.300, -3.999, 99.957 }, -- H-5 on a shelf
    [4]  = { 11.720, -3.999, 99.957 } -- F-5 on a shelf -- good
}

function onTrade(player, npc, trade)
end


function onTrigger(player, npc)
    if ((player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == QUEST_ACCEPTED or player:getCharVar("SecretsOfOvensLostRepeat") == 1) and not player:hasKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TAVNAZIAN_COOKBOOK)
        player:addKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onTimeTrigger(npc, triggerID)
    local currentPoint = npc:getLocalVar("currentPoint")
    local nextPoint = currentPoint + 1;

    if nextPoint == 5 then
        nextPoint = 1
    end
    
    local nextPointLoc = points[nextPoint]
    npc:setLocalVar("currentPoint", nextPoint)
    
    npcUtil.queueMove(npc, nextPointLoc, 1000)
end

function onSpawn(npc)
    npc:setLocalVar("currentPoint", 1)
end

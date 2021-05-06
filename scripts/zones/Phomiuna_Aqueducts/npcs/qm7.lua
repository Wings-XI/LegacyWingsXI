-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm7 (???)
-- Invlved in quest: Secrets of Ovens Lost quest
-- !pos 83.219 -25.047 8.010
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

local points =
{
    [1]  = { 83.219, -25.047, 8.010 }, -- J-9 on some vases
    [2]  = { -62.6, -26.000, 107.965 }, -- F-7 on a shelf
    [3]  = { -47.454, -26.000, 11.535 }, -- F-9 on a shelf
    [4]  = { 84.827, -26.000, 108.299 } -- J-7 on a shelf
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

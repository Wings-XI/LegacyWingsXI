-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Jonette
--  Involved in Quest: Secrets of Ovens Lost
--  !pos -69.956 -11.252 9.193
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCharVar("SecretsOfOvenLostDespCS") == 1) then
        player:startEvent(506) -- First time quest CS
    elseif (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)) then
        player:startEvent(508) -- First time completion
    elseif (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == QUEST_COMPLETED and player:getCharVar("SecretsOfOvensLostReset") ~= getConquestTally() and  player:getCharVar("SecretsOfOvensLostRepeat") ~= 1) then
        player:startEvent(507) -- Repeatable quest start
    elseif (player:getCharVar("SecretsOfOvensLostRepeat") == 1 and not player:hasKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)) then
        player:startEvent(507) -- Remind player to go get a cookbook 
    elseif (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == QUEST_COMPLETED and player:hasKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)) then
        player:startEvent(508) -- Repeatable quest completion
    else
        player:startEvent(365) -- Default
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 506 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST)
        player:setCharVar("SecretsOfOvenLostDespCS", 0) -- clear the var - not needed anymore
    elseif csid == 507 then
        player:setCharVar("SecretsOfOvensLostRepeat", 1)
    elseif csid == 508 then
        if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST) == QUEST_ACCEPTED then
            if npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.SECRETS_OF_OVENS_LOST, {item = 4247}) then
                player:setCharVar("SecretsOfOvensLostReset", getConquestTally())
                player:delKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)
            end
        else
            if(npcUtil.giveItem(player, 4247)) then
                player:setCharVar("SecretsOfOvensLostReset", getConquestTally())
                player:setCharVar("SecretsOfOvensLostRepeat", 0)
                player:delKeyItem(tpz.ki.TAVNAZIAN_COOKBOOK)
            end
        end
    end
end

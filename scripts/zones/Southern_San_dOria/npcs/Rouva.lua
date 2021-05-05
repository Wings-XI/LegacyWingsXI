-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rouva
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- Involved in Quest: Spice Gals
-- !pos -17 2 10 230
-------------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 2)) then
        player:startEvent(808) -- Wildcat CS
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_AVAILABLE and player:hasCompletedMission(COP, tpz.mission.id.cop.ANCIENT_VOWS)) then
        player:startEvent(724) -- First time quest CS
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.RIVERNEWORT)) then
        player:startEvent(725) -- First time completion CS
    elseif ((player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_ACCEPTED or player:getCharVar("SpiceGalsRepeat") == 1) and not player:hasKeyItem(tpz.ki.RIVERNEWORT)) then
        player:startEvent(728) -- Reminds player to go get the herb
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_COMPLETED and player:getCharVar("SpiceGalsReset") ~= getConquestTally() and  player:getCharVar("SpiceGalsRepeat") ~= 1) then
        player:startEvent(726) -- Repeatable quest start
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS) == QUEST_COMPLETED and player:hasKeyItem(tpz.ki.RIVERNEWORT)) then
        player:startEvent(727) -- Repeatable quest completion
    else
        player:startEvent(664) -- Default Dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 808) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 2, true))
    elseif csid == 724 then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.SPICE_GALS)
    elseif csid == 725 then
        if npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.SPICE_GALS, {item = 4247}) then
            player:setCharVar("SpiceGalsReset", getConquestTally())
            player:delKeyItem(tpz.ki.RIVERNEWORT)
        end
    elseif csid == 726 then
        player:setCharVar("SpiceGalsRepeat", 1)
    elseif csid == 727 then
        if(npcUtil.giveItem(player, 4247)) then
            player:setCharVar("SpiceGalsReset", getConquestTally())
            player:setCharVar("SpiceGalsRepeat", 0)
            player:delKeyItem(tpz.ki.RIVERNEWORT)
        end
    end

end

-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Engelhart
-- Quest NPC
-- pos -79 -4 -125
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BETTER_PART_OF_VALOR) == QUEST_ACCEPTED) then
        if (player:getCharVar("BetterPartOfValProg") == 0) then
            player:startEvent(116)
        elseif (player:getCharVar("BetterPartOfValProg") == 4) then
            player:startEvent(118)
        else
            player:startEvent(117)
        end
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BETTER_PART_OF_VALOR) == QUEST_COMPLETED and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_AVAILABLE and
            playerNeedsToZoneOrWaitADay(player) == false) then
            player:startEvent(120)
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED) then
        if (player:getCharVar("FiresOfDiscProg") < 2) then
            player:startEvent(121)
        elseif (player:getCharVar("FiresOfDiscProg") == 2) then
            player:startEvent(124)
        elseif (player:getCharVar("FiresOfDiscProg") == 3) then
            player:startEvent(125)
        elseif (player:getCharVar("FiresOfDiscProg") == 4) then
            player:startEvent(126)
        elseif (player:getCharVar("FiresOfDiscProg") == 5) then
            player:startEvent(127)
        elseif (player:getCharVar("FiresOfDiscProg") == 6) then
            player:startEvent(164)
        end
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS) == QUEST_ACCEPTED) then
        player:startEvent(18)
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.BURDEN_OF_SUSPICION) == QUEST_ACCEPTED) then
        if (player:getCharVar("BurdenOfSuspicion") == 1) then
            player:startEvent(32)
        else
            player:startEvent(33)
        end
    else
        player:startEvent(104)
    end

end

function onEventUpdate(player, csid, option)
end

function playerNeedsToZoneOrWaitADay(player)
    if (player:needToZone() == true or player:getCharVar("WotG_Bastok_DayWait") == VanadielDayOfTheYear()) then
        return true
    else
        return false
    end
end

function onEventFinish(player, csid, option)
    if (csid == 116) then
        player:setCharVar("BetterPartOfValProg", 1)
        player:delKeyItem(tpz.ki.CLUMP_OF_ANIMAL_HAIR)
    elseif (csid == 118) then
        player:delKeyItem(tpz.ki.XHIFHUT)
        player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.BETTER_PART_OF_VALOR)
        player:addKeyItem(tpz.ki.WARNING_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WARNING_LETTER)
        player:addGil(GIL_RATE*10000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000)
        player:setCharVar("BetterPartOfValProg", 0)
        player:needToZone(true)
        player:setCharVar("WotG_Bastok_DayWait", VanadielDayOfTheYear())
    elseif (csid == 120) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT)
        player:delKeyItem(tpz.ki.WARNING_LETTER)
    elseif (csid == 124) then
        player:setCharVar("FiresOfDiscProg", 3)
    elseif (csid == 126) then
        player:setCharVar("FiresOfDiscProg", 5)
    elseif (csid == 164) then
        player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT)
        player:addGil(GIL_RATE*10000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000)
        player:setCharVar("FiresOfDiscProg", 0)
        player:needToZone(true)
        player:setCharVar("WotG_Bastok_DayWait", VanadielDayOfTheYear())
    elseif (csid == 32) then
        player:setCharVar("BurdenOfSuspicion", 2)
    end
end

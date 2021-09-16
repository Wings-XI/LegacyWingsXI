----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Blatherix
-- Type: Quest
-- !pos -309.6 -12 -44
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    local lightInTheDarknessProgress = player:getCharVar("LightInTheDarkness")
    if (lightInTheDarknessProgress == 3) and (npcUtil.tradeHasExactly(trade, {{"gil", 5000}}) or npcUtil.tradeHasExactly(trade, {{4495, 30}})) then
        player:startEvent(23)
    elseif (lightInTheDarknessProgress == 7) and (npcUtil.tradeHasExactly(trade, {{"gil", 1000}}) or npcUtil.tradeHasExactly(trade, {{4495, 10}})) then
        player:startEvent(23)
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS) == QUEST_ACCEPTED) then
        local lightInTheDarknessProgress = player:getCharVar("LightInTheDarkness")
        if (lightInTheDarknessProgress == 2) then
            player:startEvent(21)
        elseif (lightInTheDarknessProgress == 3) then
            player:startEvent(22)
        elseif (lightInTheDarknessProgress == 6) then
            player:startEvent(25)
        elseif (lightInTheDarknessProgress == 7) then
            player:startEvent(26)
        elseif (lightInTheDarknessProgress == 4 or lightInTheDarknessProgress == 8) then
            player:startEvent(24)
        end
    else
        player:startEvent(29)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 21) then
        player:setCharVar("LightInTheDarkness", 3)
    elseif (csid == 25) then
        player:setCharVar("LightInTheDarkness", 7)
    elseif (csid == 23) then
        player:confirmTrade()
        player:addKeyItem(tpz.ki.MINE_SHAFT_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MINE_SHAFT_KEY)
        if (player:getCharVar("LightInTheDarkness") == 3) then
            player:setCharVar("LightInTheDarkness", 4)
        else
            player:setCharVar("LightInTheDarkness", 8) -- using 8 here to avoid a re-trigger of the Pashow S CS
        end
    end
end
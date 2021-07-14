-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Romaa Mihgo
-- Type: Standard NPC
-- !pos -1.967 -3 -26.337 94
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("ManifestProblem") == 5 then
        -- Player had full inventory
        player:startEvent(154)
    else
        player:startEvent(324)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 154 then
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM, {item=5708, title=tpz.title.FRIEND_OF_LEHKO_HABHOKA, var="ManifestProblem"})
    end
end

-----------------------------------
-- Area: Grauberg [S]
--  NPC: Sparkling Lights
--  Quest - SCH AF3
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrigger(player, npc)

    local seeingBloodRed = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.SEEING_BLOOD_RED)
    local seeingBloodRedProgress = player:getCharVar("SeeingBloodRed")

    if seeingBloodRed == QUEST_ACCEPTED and seeingBloodRedProgress == 2 then
        player:startEvent(14)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventFinish(player, csid, option)
    if csid == 14 then
        player:setCharVar("SeeingBloodRed", 3)
    end
end
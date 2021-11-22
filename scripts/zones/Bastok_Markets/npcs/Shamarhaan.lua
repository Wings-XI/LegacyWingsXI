-----------------------------------
-- Area: Bastok Markets
--  NPC: Shamarhaan
-- Type: Quest Starter
-- Involved in quest: No Strings Attached
-- !pos -285.382 -13.021 -84.743 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local NoStringsAttached = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED)
    local NoStringsAttachedProgress = player:getCharVar("NoStringsAttachedProgress")
    local PuppetmasterBlues = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")

    if (player:getMainLvl() >= ADVANCED_JOB_LEVEL and NoStringsAttached == QUEST_AVAILABLE) then
        player:startEvent(434) -- initial cs to start the quest, go and see Iruki-Waraki at Whitegate
    elseif (NoStringsAttachedProgress == 1) then
        player:startEvent(435) -- reminder to go see Iruki-Waraki at Whitegate
    elseif (PuppetmasterBluesProgress == 1) then
        player:startEvent(437) -- cs - asks player to help Iruki-Waraki
    elseif (PuppetmasterBluesProgress == 2) then
        player:startEvent(438) -- reminds players to get a toggle switch and go to Talacca Cove
    elseif (PuppetmasterBluesProgress == 3) then
        player:startEvent(439) -- cs - Post Talacca Cove win, sends player to Iruki-Waraki
    elseif (PuppetmasterBluesProgress == 4) then
        player:startEvent(440) -- reminds player to go to Iruki-Waraki
    elseif (NoStringsAttached == QUEST_COMPLETED) then
        player:startEvent(436) -- encourages you
    else
        player:startEvent(433) -- acts indifferent to you
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 434) then
        player:setCharVar("NoStringsAttachedProgress", 1)
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED)
    elseif (csid == 437) then -- No matter what the player chooses, this CS returns option 0
        player:setCharVar("PuppetmasterBluesProgress", 2)
        player:addKeyItem(tpz.ki.VALKENGS_MEMORY_CHIP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VALKENGS_MEMORY_CHIP)
    elseif (csid == 439) then
        player:setCharVar("PuppetmasterBluesProgress", 4)
    end
end

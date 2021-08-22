-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Justinius
-- Involved in mission : COP2-3
-- !pos 76 -34 68 26
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------

-- Cache COP missions for later reference
local copMissions = tpz.mission.id.cop

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissionStatus = player:getCharVar("PromathiaStatus")
    local uninvitedGuests =  player:getCharVar("UninvitedGuestsStatus")

    -- COP 2-3
    if copCurrentMission == copMissions.DISTANT_BELIEFS and copMissionStatus == 3 then
        player:startEvent(113)
    -- COP 2-4
    elseif copCurrentMission == copMissions.AN_ETERNAL_MELODY and copMissionStatus == 1 then
        player:startEvent(127) -- optional dialogue
    -- COP 4-1
    elseif copCurrentMission == copMissions.SHELTERING_DOUBT and copMissionStatus == 2 then
        player:startEvent(109)
    -- COP 4-2
    elseif copCurrentMission == copMissions.THE_SAVAGE then
        if copMissionStatus == 2 then
            player:startEvent(110) -- finish mission
        else
            player:startEvent(130) -- optional dialogue
        end
    elseif player:hasCompletedMission(COP, tpz.mission.id.cop.THE_SAVAGE) and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS) == QUEST_AVAILABLE then
        player:startEvent(570) -- Intial Uninvited Quest CS
    elseif uninvitedGuests == 1 then
        if not player:hasKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT) then
            player:addKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        end
        player:startEvent(571) -- Reminds player to go to Monarch Linn
    elseif uninvitedGuests == 2 then 
        player:startEvent(572) -- Uninvited Guests Victory
    elseif uninvitedGuests == 3 or (uninvitedGuests == 4 and player:getCharVar("UninvitedGuestsReset")) == getConquestTally() then
        player:startEvent(575) -- Uninvited Guests Failure - mocks player until conquest tally
    elseif uninvitedGuests == 4 and player:getCharVar("UninvitedGuestsReset") ~= getConquestTally() then
        player:startEvent(574) -- Reissues permit post failure
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS) == QUEST_COMPLETED and player:getCharVar("UninvitedGuestsReset") ~= getConquestTally() then
        player:startEvent(573) -- Repeatable Init CS
    else
        player:startEvent(123)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 113 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, copMissions.DISTANT_BELIEFS)
        player:addMission(COP, copMissions.AN_ETERNAL_MELODY)
    elseif csid == 109 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 110 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, copMissions.THE_SAVAGE)
        player:addMission(COP, copMissions.THE_SECRETS_OF_WORSHIP)
        player:addTitle(tpz.title.NAGMOLADAS_UNDERLING)
    elseif csid == 570 and option == 1 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS)
        player:addKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:setCharVar("UninvitedGuestsStatus", 1) -- accepted
    elseif csid == 572 then
        -- Determine Reward (or check if a reward is pending)
        local rewardId = player:getCharVar("UninvitedGuestsReward") -- Done to prevent ppl holding the r/ex xp page and forcing a recalculation
        if rewardId == 0 then
            rewardId = generateUninvitedGuestsReward(player)
        end

        -- Complete Quest if Active
        if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS) == QUEST_ACCEPTED then
            if rewardId == 1 then
                if npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS, {gil = 10000, title=tpz.title.MONARCH_LINN_PATROL_GUARD, var = {"UninvitedGuestsStatus", "UninvitedGuestsReward"}}) then
                    updateUninvitedGuests(player, false)
                end
            else
                if npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS, {item = rewardId, title=tpz.title.MONARCH_LINN_PATROL_GUARD, var = {"UninvitedGuestsStatus", "UninvitedGuestsReward"}}) then
                    updateUninvitedGuests(player, false)
                end
            end
        else
            if(rewardId == 1) then -- special case for Gil
                if npcUtil.giveCurrency(player, "gil", 10000) then
                    updateUninvitedGuests(player, true)
                end
            elseif npcUtil.giveItem(player, rewardId) then
                updateUninvitedGuests(player, true)
            end
        end
    elseif csid == 574 or (csid == 573 and option == 1) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:addKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:setCharVar("UninvitedGuestsStatus", 1) -- accepted
    elseif csid == 575 then
        if player:getCharVar("UninvitedGuestsStatus") == 3 then
            updateUninvitedGuests(player, false)
            player:setCharVar("UninvitedGuestsStatus", 4) -- Player has failed and must wait until conquest to retry
        end
    end

end

function updateUninvitedGuests(player, clearVars)
    player:setCharVar("UninvitedGuestsReset", getConquestTally())
    if clearVars then
        player:setCharVar("UninvitedGuestsStatus", 0)
        player:setCharVar("UninvitedGuestsReward", 0)
    end
end

function generateUninvitedGuestsReward(player)
    -- Reward info taken from https://ffxiclopedia.fandom.com/wiki/Uninvited_Guests
    -- Moved any value with a 0 to 0.1
    -- Reduced Miratete's Memoirs from 57.7% to 50.9% to align total reward percentage to 100%
    local rewardId 
    local roll = math.random(1000) -- Since we need tenths of a percent - use 1000

    -- this is overly verbose and ineffcient, could be refactored to a mob loot pool which works like MeeDeggi/Quu and silently killed
    if roll <= 509 then
        rewardId = 4247 -- Miratete's Memoirs
    elseif roll <= 543 then
        rewardId = 4550 -- Bream Risotto
    elseif roll <= 573 then
        rewardId = 1132 -- Raxa
    elseif roll <= 601 then
        rewardId = 5144 -- Crimson Jelly
    elseif roll <= 629 then
        rewardId = 4279 -- Tavnazian Salad
    elseif roll <= 657 then
        rewardId = 678 -- Aluminum Ore
    elseif roll <= 683 then
        rewardId = 5142 -- Bison Steak
    elseif roll <= 710 then
        rewardId = 4544 -- Mushroom Stew
    elseif roll <= 737 then
        rewardId = 1766 -- Tiger Eye
    elseif roll <= 762 then
        rewardId = 1841 -- Unicorn Horn
    elseif roll <= 784 then
        rewardId = 61 -- Armoire
    elseif roll <= 806 then
        rewardId = 1602 -- Mannequin Body
    elseif roll <= 828 then
        rewardId = 4434 -- Mushroom Risotto
    elseif roll <= 847 then
        rewardId = 1603 -- Mannequin Hands
    elseif roll <= 864 then
        rewardId = 1770 -- Oversized Fang
    elseif roll <= 880 then
        rewardId = 1771 -- Dragon Bone
    elseif roll <= 896 then
        rewardId = 690 -- Elm Log
    elseif roll <= 910 then
        rewardId = 1604 -- Mannequin Legs
    elseif roll <= 923 then
        rewardId = 1605 -- Mannequin Feet
    elseif roll <= 934 then
        rewardId = 646 -- Adaman Ore
    elseif roll <= 943 then
        rewardId = 860 -- Behemoth Hide
    elseif roll <= 952 then
        rewardId = 1765 -- Habu Skin
    elseif roll <= 960 then
        rewardId = 1842 -- Cloud Evoker
    elseif roll <= 966 then
        rewardId = 1601 -- Mannequin Head
    elseif roll <= 972 then
        rewardId = 739 -- Orichalcum  Ore
    elseif roll <= 978 then
        rewardId = 5158 -- Vermillion Jelly
    elseif roll <= 981 then
        rewardId = 5185 -- Leremieu Salad
    elseif roll <= 983 then
        rewardId = 908 -- Adamantoise Shell
    elseif roll <= 985 then
        rewardId = 1312 -- Angel Skin
    elseif roll <= 987 then
        rewardId = 4486 -- Dragon Heart
    elseif roll <= 989 then
        rewardId = 5157 -- Marbled Steak
    elseif roll <= 991 then
        rewardId = 4268 -- Sea Spray Risotto
    elseif roll <= 993 then
        rewardId = 1313 -- Siren's Hair
    elseif roll <= 995 then
        rewardId = 5264 -- Yellow Liquid
     elseif roll <= 997 then
        rewardId = 4330 -- Witch Risotto
    elseif roll <= 998 then
        rewardId = 1 -- 10,000 Gil Speical cased to ID 1
    elseif roll <= 999 then
        rewardId = 14470 -- Assault Breastplate
    elseif roll <= 1000 then
        rewardId = 4344 -- Witch Stew
    end

    player:setCharVar("UninvitedGuestsReward", rewardId)
    return rewardId
end

-----------------------------------
--
-- Zone: Walk_of_Echoes
--
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    -- WINGSCUSTOM: cait sith avatar quest available when currently-implemented WOTG missions are completed
    -- This needs to be changed as more missions are implemented
    local caitSithAvailable = player:hasCompletedMission(WOTG, tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK)

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-420, 10, 0, 69)
    end

    if prevZone == 89 and -- coming from Grauberg_S
        caitSithAvailable and
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_AVAILABLE then
            cs = 15
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 15 then
        player:addQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN)
    end
end

-----------------------------------
-- Area: Castle Zvahl Keep
--  NPC: Craggy Pillar
-- Mission: AMK 13 - A Challenge! You Could Be a Winner
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/treasure")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER and
        player:getCharVar("[AMK]12_puzzle") == 4 and
        player:getCharVar("[AMK]12_puzzle_4_cohortIdx") > 0 and
        player:hasKeyItem(tpz.ki.FESTIVAL_SOUVENIR_KUPON)
    then
        local cohorts = {
            [17441092] = { eventID = 101, cohortIdx = 1, location = 0 }, -- Craggy pillar ID for Kupignol - finish 1
            [17441093] = { eventID = 102, cohortIdx = 3, location = 1 }, -- Craggy pillar ID for Kupert - finish 9
            [17441094] = { eventID = 103, cohortIdx = 2, location = 2 }, -- Craggy pillar ID for Kupuckl - finish 17
            [17441095] = { eventID = 104, cohortIdx = 0, location = 3 }, -- Craggy pillar ID for Kupatete - finish 25
        }
        local cohortIdx = player:getCharVar("[AMK]12_puzzle_4_cohortIdx") - 1 -- int of range(0,3)
        local progress = 2 -- Not the right one
        local crag = cohorts[npc:getID()]

        if crag.cohortIdx == cohortIdx then
            progress = 1 -- This is the right one
        end

        player:startEvent(crag.eventID, progress, crag.cohortIdx, 1, crag.location, cohortIdx)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if option == 1 then
        player:setCharVar("[AMK]12_puzzle", 5)
        player:setCharVar("[AMK]12_puzzle_4_cohortIdx", 0)
        player:delKeyItem(tpz.ki.FESTIVAL_SOUVENIR_KUPON)
        npcUtil.giveKeyItem(player, tpz.ki.MEGA_BONANZA_KUPON)
    end
end

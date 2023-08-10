-----------------------------------
-- Area: Castle Zvahl Keep
--  NPC: Ominous Pillar
-- Mission: AMK 13 - A Challenge! You Could Be a Winner
--  !pos -7.000 -1.500 -23.600
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/treasure")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(AMK) == tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER
    then
        if
            player:getCharVar("[AMK]12_puzzle") == 4 and
            player:hasKeyItem(tpz.ki.FESTIVAL_SOUVENIR_KUPON)
        then
            -- player:setCharVar("[AMK]12_puzzle_4_cohortIdx", 0)
            local cohortIdx = player:getCharVar("[AMK]12_puzzle_4_cohortIdx")
            local event = 2
            if cohortIdx == 0 then
                cohortIdx = math.random(1, 4)
                event = 1
            end
            player:startEvent(100, event, cohortIdx - 1)
        else
            player:startEvent(100, 4)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local cohorts = { [1] = 1, [9] = 2, [17] = 3, [25] = 4 }
    if csid == 100 then
        if option ~= 0 then
            player:setCharVar("[AMK]12_puzzle_4_cohortIdx", cohorts[option])
        end
    end
end

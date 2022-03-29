-----------------------------------
-- Ensorcelled Door
-- Area: Ro'Maeve
-- A Shantatto Ascension
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.SHANTOTTO_IN_CHAINS then
        local completedFragment =
            (player:hasKeyItem(tpz.ki.LUMINOUS_PURPLE_FRAGMENT) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_YELLOW_FRAGMENT) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_BLUE_FRAGMENT)   and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_BEIGE_FRAGMENT)  and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_RED_FRAGMENT)    and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LUMINOUS_GREEN_FRAGMENT)  and 1 or 0)

        if completedFragment == 6 then
            -- Known issue with event 71 even on retail that black screens when using Windower/Ashita
            -- Placed all logic into trigger to ensure players move to next mission
            player:PrintToPlayer("NOTICE: Cutscene is not displayed due to a known issue from retail causing Ashita/Windower users to get locked in a black screen.",29)
            player:PrintToPlayer("You are now on the mission Fountain of Trouble.",29)

            player:completeMission(ASA, tpz.mission.id.asa.SHANTOTTO_IN_CHAINS)
            player:addMission(ASA, tpz.mission.id.asa.FOUNTAIN_OF_TROUBLE)

            player:delKeyItem(tpz.ki.LUMINOUS_PURPLE_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_YELLOW_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_BLUE_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_BEIGE_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_RED_FRAGMENT)
            player:delKeyItem(tpz.ki.LUMINOUS_GREEN_FRAGMENT)
        else
            player:messageSpecial(ID.text.DOOR_LOCKED)
            player:messageSpecial(ID.text.HEXAGONAL_DOOR)
        end
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
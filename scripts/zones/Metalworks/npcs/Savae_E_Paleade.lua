-----------------------------------
-- Area: Metalworks
--  NPC: Savae E Paleade
-- Involved In Mission: Journey Abroad
-- !pos 23.724 -17.39 -43.360 237
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    -- Players are consistently contacting GMs about not being able to trade in Mythril Sand
    -- Either there is a flaw in the variable logic that randomly impacts players or players miss one of the seemingly optional CSs
    -- This will either reduce the number of GM tickets or have no effect, signifying we need a deeper dive on root cause
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK and (player:getCharVar("MissionStatus") <= 5 and player:getCharVar("MissionStatus") >= 3)) then
        if (trade:hasItemQty(599, 1) and trade:getItemCount() == 1) then -- Trade Mythril Sand
            player:startEvent(205)
        end
    -- Additional variable check if above trade conditions fail.
    elseif (player:getCharVar("SavaeTalk") == 1) or (player:getCharVar("PiusTalk") == 1) or (player:getCharVar("GrohmTalk") == 1) then
        if (trade:hasItemQty(599, 1) and trade:getItemCount() == 1) then -- Trade Mythril Sand
            player:startEvent(205)
        end
    end
end

function onTrigger(player, npc)

    -- San d'Oria Mission 2-3 Part I - Bastok > Windurst
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_ABROAD and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(204)
    -- San d'Oria Mission 2-3 Part II - Windurst > Bastok
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_ABROAD and player:getCharVar("MissionStatus") == 7) then
        player:startEvent(206)
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2 and player:getCharVar("MissionStatus") == 11) then
        player:startEvent(207)
    -----------------
    elseif (player:getCurrentMission(SANDORIA) ~= tpz.mission.id.sandoria.NONE) then
        player:startEvent(208)
    else
        player:startEvent(200)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 204) then
        player:addMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_TO_BASTOK)
        player:setCharVar("MissionStatus", 3)
        player:setCharVar("SavaeTalk", 1) -- Added due to playervar MissionStatus getting reset and rendering mission uncompletable without assistance.
        player:delKeyItem(tpz.ki.LETTER_TO_THE_CONSULS_SANDORIA)
    elseif (csid == 205) then
        player:tradeComplete()
        player:setCharVar("MissionStatus", 6)
        player:setCharVar("SavaeTalk", 0)
        player:setCharVar("PiusTalk", 0)
        player:setCharVar("GrohmTalk", 0)
        player:addMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_ABROAD)
    elseif (csid == 206) then
        player:addMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2)
        player:setCharVar("MissionStatus", 8)
    elseif (csid == 207) then
        player:addMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_ABROAD)
        player:delKeyItem(tpz.ki.KINDRED_CREST)
        player:addKeyItem(tpz.ki.KINDRED_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.KINDRED_REPORT)
    end

end

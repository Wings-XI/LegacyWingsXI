-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: _iz2 (Ebon_Panel)
-- !pos 422.351 -5.180 -100.000 35 | Hume Tower
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Race = player:getRace()

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus") == 1) then
        player:startEvent(202)
    elseif (Race ~= tpz.race.HUME_M and Race ~= tpz.race.HUME_F) then -- Incorrect Tower
        player:messageSpecial(ID.text.WRONG_DEVICE)
    elseif ((player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus") == 2) or (not player:hasTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL))) then -- Click on correct race panel
        player:startEvent(120)
    else
        player:messageSpecial(ID.text.NO_NEED_INVESTIGATE) -- Already clicked
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 202) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (csid == 120 and option ~= 0) then -- Hume
        player:addTitle(tpz.title.WARRIOR_OF_THE_CRYSTAL)
        player:addKeyItem(tpz.ki.LIGHT_OF_VAHZL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIGHT_OF_VAHZL)
        if (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus") == 2) then
            player:setCharVar("PromathiaStatus", 3)
        end
    end
end

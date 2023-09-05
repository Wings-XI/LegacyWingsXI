-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Lonely Evergreen
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos -161.824 -80.075 177.869 111
-- ID: 17232295
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local puzzle = player:getCharVar("[AMK]12_puzzle")
    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER and
        not player:hasKeyItem(tpz.ki.MEGA_BONANZA_KUPON)
    then
        if puzzle == 2 then
            player:setCharVar("[AMK]12_puzzle", 2)
            if player:hasKeyItem(tpz.ki.POCKET_MOGBOMB) then
                player:startEvent(502, tpz.ki.POCKET_MOGBOMB, tpz.ki.TRIVIA_CHALLENGE_KUPON)
            elseif player:hasKeyItem(tpz.ki.TRIVIA_CHALLENGE_KUPON) then
                player:startEvent(501, tpz.ki.TRIVIA_CHALLENGE_KUPON)
            end
        elseif player:needToZone() == true then
            player:startEvent(503)
        else
            player:startEvent(504)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 502 then
        player:delKeyItem(tpz.ki.POCKET_MOGBOMB)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.POCKET_MOGBOMB)
        npcUtil.giveKeyItem(player, tpz.ki.TRIVIA_CHALLENGE_KUPON)
    elseif csid == 504 and option == 1 then
        player:needToZone(true)
        player:setCharVar("[AMK]12_puzzle", 1)
        player:setCharVar("[AMK]12_puzzle_1_pipSet", 0)
    end
end

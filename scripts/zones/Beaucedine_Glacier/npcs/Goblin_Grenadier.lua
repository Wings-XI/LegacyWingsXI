-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Goblin Grenadier
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos -26.283 -60.49 -76.640 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- debugging resets
    -- player:setCharVar("[AMK]12_puzzle", 1)
    -- player:setCharVar("[AMK]12_puzzle_1_started", 0)
    -- player:needToZone(true)
    -------------------
    local puzzle1Answer = player:getCharVar("[AMK]12_puzzle_1_pipSet") - 1
    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER and
        player:hasKeyItem(tpz.ki.MAP_OF_THE_NORTHLANDS_AREA) and
        player:getCharVar("[AMK]12_puzzle") == 1
    then
        if player:needToZone() then
            if puzzle1Answer < 0 then
                player:startEvent(508, tpz.ki.MAP_OF_THE_NORTHLANDS_AREA, 9)
                player:setCharVar("[AMK]12_puzzle_1_hintsUsed", 0)
            else
                local today = VanadielDayOfTheWeek()
                local tomorrow = (today == 7) and 0 or today + 1
                local hints = player:getCharVar("[AMK]12_puzzle_1_hintsUsed")

                player:messageSpecial(7398, today, tomorrow)
                player:startEvent(507, hints + 2, puzzle1Answer, tpz.ki.MAP_OF_THE_NORTHLANDS_AREA, tpz.ki.POCKET_MOGBOMB)
            end
        else
            player:setCharVar("[AMK]12_puzzle_1_pipSet", 0)
            player:startEvent(509)
        end
    elseif player:hasKeyItem(tpz.ki.POCKET_MOGBOMB) then
        player:messageSpecial(ID.text.TAKE_THIS_MOGBOMB, tpz.ki.POCKET_MOGBOMB)
    else
        player:startEvent(509)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, extras)
    if csid == 508 then
        player:setCharVar("[AMK]12_puzzle_1_pipSet", math.random(#amkHelpers.pipSets))
    elseif csid == 507 then
        if option == 1 then
            player:setCharVar("[AMK]12_puzzle_1_hintsUsed", player:getCharVar("[AMK]12_puzzle_1_hintsUsed") + 1)
        elseif option == 3 then
            player:setCharVar("[AMK]12_puzzle_1_pipSet", 0)
            player:setCharVar("[AMK]12_puzzle_1_hintsUsed", 0)
            player:needToZone(false)
        elseif option == 5 or option == 6 then
            player:setCharVar("[AMK]12_puzzle_1_pipSet", 0)
            player:setCharVar("[AMK]12_puzzle_1_hintsUsed", 0)
            player:setCharVar("[AMK]12_puzzle", 2)
            npcUtil.giveKeyItem(player, tpz.ki.POCKET_MOGBOMB)
            player:needToZone(false)

            local duration = 300 - ((option - 5) * 2 * 60)
            player:addStatusEffect(tpz.effect.FLEE, 100, 0, duration)
        end
    end
end

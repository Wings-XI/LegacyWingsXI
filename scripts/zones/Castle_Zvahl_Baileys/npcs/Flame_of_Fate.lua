-----------------------------------
-- Area: Castle Zvahl Baileys
--  NPC: Flame of Fate
-- Mission: AMK 13 - A Challenge! You Could Be a Winner
-- !pos -154.893 -23.999 16.908
-----------------------------------
require("scripts/globals/survival_guide")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER and
        player:getCharVar("[AMK]12_puzzle") == 3
    then
        player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
        local stoogeArg = player:getCharVar("[AMK]12_puzzle_3_stoogeArg")

        if player:needToZone() == false then
            -- Lose: zoned
            player:startEvent(101, 4)
            player:setCharVar("[AMK]12_puzzle_3_stoogeArg", 1)
        elseif os.time() > player:getCharVar("[AMK]12_puzzle_3_time_limit") then
            -- Lose: Outta time
            player:startEvent(101, 2)
            player:setCharVar("[AMK]12_puzzle_3_stoogeArg", 1)
        elseif stoogeArg == 3 then
            -- After winning
            player:startEvent(101, 3)
        else
            -- Won
            player:startEvent(101, 2)
            player:setCharVar("[AMK]12_puzzle_3_stoogeArg", 3)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 101 and option == 1 then
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        npcUtil.giveKeyItem(player, tpz.ki.FESTIVAL_SOUVENIR_KUPON)
        player:setCharVar("[AMK]12_puzzle", 4)
    end
end

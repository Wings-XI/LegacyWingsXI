-----------------------------------
-- Area: Castle Zvahl Baileys
--  NPC: Shadowy Pillar
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos 374.128 -12.098 -15.010 161
-- ID: 17437015
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Baileys/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(AMK) == tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER
    then
        local stoogeArg = player:getCharVar("[AMK]12_puzzle_3_stoogeArg")
        if player:needToZone() == false then stoogeArg = 1 end
        if
            player:getCharVar("[AMK]12_puzzle") ~= 3 or
            not player:hasKeyItem(tpz.ki.GAUNTLET_CHALLENGE_KUPON)
        then
            player:startEvent(100, 3)
        elseif
            player:getCharVar("[AMK]12_puzzle") == 3 and
            player:hasKeyItem(tpz.ki.GAUNTLET_CHALLENGE_KUPON)
        then
            player:startEvent(100, stoogeArg)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 100 then
        local duration = math.random(240, 300) + player:getMod(tpz.mod.INVISIBLE_DURATION)
        if option == 1 then
            -- "Buffs (including Quickening and Flee) will not wear when you are level restricted."
            local effects = player:getStatusEffects()
            local effectsToKepp = {}
            local i = 0
            for _,effect in ipairs(effects) do
                if bit.band(effect:getFlag(), tpz.effectFlag.LEVEL_RESTRICTION) == tpz.effectFlag.LEVEL_RESTRICTION or
                    bit.band(effect:getFlag(), tpz.effectFlag.ON_SYNC) == tpz.effectFlag.ON_SYNC
                then
                    effectsToKepp[i+1] = effect
                    i = i + 1
                end
            end
            -- game on  
            player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 1, 0, 0)
            for _,copyEffect in ipairs(effectsToKepp) do
                if not player:hasStatusEffect(copyEffect:getType()) then
                    -- code from empathy lua
                    player:addStatusEffect(copyEffect:getType(), copyEffect:getPower(), copyEffect:getTick(), math.ceil((copyEffect:getTimeRemaining())/1000))
                end
            end
            player:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
            player:addStatusEffect(tpz.effect.SNEAK, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
            player:addStatusEffect(tpz.effect.DEODORIZE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
            player:needToZone(true)
            player:setCharVar("[AMK]12_puzzle_3_stoogeArg", 2)
            player:setCharVar("[AMK]12_puzzle_3_start_time", os.time())
            player:setCharVar("[AMK]12_puzzle_3_time_limit", os.time() + (8 * 60))
        elseif
            option == 2
        then
            -- Player came back to refresh buffs
            player:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
            player:addStatusEffect(tpz.effect.SNEAK, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
            player:addStatusEffect(tpz.effect.DEODORIZE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
        end
    end
    
end


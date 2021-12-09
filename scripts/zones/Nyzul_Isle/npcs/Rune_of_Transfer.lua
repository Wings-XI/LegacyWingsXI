------------------------------------------------
-- Rune of Transfer in Nyzul Isle Investigation
-- This includes the starter Rune of Transfer and the alternating floor ones
------------------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Nyzul_Isle/IDs")
------------------------------------------------
local STARTING_RUNE_OF_TRANSFER_ID = 17093429
local SPLIT_PATH_CHANCE = 5 -- percent chance to have a split path (choose left or right)

local objectiveToStringMap = {ID.text.ELIMINATE_ALL_ENEMIES, ID.text.ELIMINATE_ENEMY_LEADER, ID.text.ELIMINATE_SPECIFIED_ENEMY, ID.text.ELIMINATE_SPECIFIED_ENEMIES,
                              ID.text.ACTIVATE_ALL_LAMPS, ID.text.ACTIVATE_ALL_LAMPS, ID.text.ACTIVATE_ALL_LAMPS}
local subObjectiveToStringMap = {ID.text.DO_NOT_DESTROY_GEARS, ID.text.AVOID_DISCOVERY_GEARS}
local floorWarpCosts = {0, 500, 550, 600, 650, 700, 750, 800, 850, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900}

function onTrigger(player, npc)
    -- Rune of Transfer in the starting room
    if (npc:getID() == STARTING_RUNE_OF_TRANSFER_ID) then
        if (player:hasKeyItem(tpz.ki.RUNIC_DISC)) then
            -- 0 if never set before, up to 100 for runic key
            local floorProgress = player:getCharVar("Nyzul_RunicDiscProgress")
            local floorBitMask = 2097151 -- 111111111111111111111 - hides all floors (and the None option)
            floorProgress = 95
            -- runs from 0 - 20 and uses xor against the full mask to un-mask the allowed floors
            for i=0,20 do
                if ((i-1) * 5 <= floorProgress) then
                    floorBitMask =  bit.bxor(floorBitMask, bit.lshift(1, i))
                end
            end

            -- Pick a floor dialog
            -- Param 1 = key item - hardcoded to RUNIC_DISC.  Need to confirm if a player with RUNIC_KEY shows RUNIC_KEY instead
            -- Param 2-7 = unused
            -- Param 8 is a bitmask to hide floors
            player:startEvent(94, tpz.ki.RUNIC_DISC, 0, 0, 0, 0, 0, 0, floorBitMask)
        else
            player:messageSpecial(ID.text.NEW_USER_CONFIRMED, tpz.ki.RUNIC_DISC)
            -- players without a RUNIC_DISC will recieve one upon touching the Rune of Transfer
            npcUtil.giveKeyItem(player, tpz.ki.RUNIC_DISC)
        end
    else
        -- Rune of Transfer on any floor but the entrance
        if (npc:AnimationSub() ~= 1) then
            -- not lit up - so repeat the objective
            showObjectives(player)
        else
            -- Rune is lit up - allow transfer (200 and 201 appear to be interchangeable
            -- Exit/Go Up dialog
            -- Param 1 = bitflag to show menu options.
                -- 1 = Not yet, 2 = Exit, 4 = Travel to next floor, 8 = Go Right, 16 = Go Left, 32 = Travel to floor <Param 2>., 64 = Travel to floor ???
            -- Param 2 = Floor number to be shown in Menu item "Travel to floor <number>"
            if (math.random(100) < SPLIT_PATH_CHANCE) then
                player:startEvent(200, 27)
            else
                player:startEvent(200, 7)
            end
        end
    end
end

function onEventFinish(player, csid, option, npc)
    printf("Rune_of_Transfer onEventFinish CSID %u OPTION %u", csid, option)
    local instance = player:getInstance()

    -- entrance rune of transfer
    if (csid == 94 and option > 0 and option <= 20) then
        local floorSelected = (option - 1) * 5 + 1
        local cost = floorWarpCosts[option]
        local tokens = player:getAssaultPoint(NYZUL_ISLE_ASSAULT_POINT)
        if (cost <= tokens) then
            player:delAssaultPoint(cost, NYZUL_ISLE_ASSAULT_POINT) -- Remove from NYZUL_ISLE_ASSAULT_POINT
            bubbleWarpThePlayers(player, instance, floorSelected)
        else
            player:messageSpecial(ID.text.INSUFFCIENT_TOKENS)
        end
    end

    if (csid == 200 and option > 0 and option <= 4) then
        -- 1 = Exit     2 = Go Up      3 = Travel to the right     4 = Travel to the Left
        for _,mob in pairs(instance:getMobs()) do
            mob:deaggroAll()
        end

        -- players choose to exit
        if (option == 1) then
            instance:complete()
        else
            bubbleWarpThePlayers(player, instance, instance:getStage() + 1)
        end
    end

    -- bubble warp
    if (csid == 95) then
        player:messageSpecial(ID.text.TRANSFER_COMPLETE, instance:getStage())
        showObjectives(player)
        
        if (instance:getLocalVar("Nyzul_TransferInitiated") == player:getID()) then
            instance:setLocalVar("Nyzul_TransferInitiated", 0)
        end
    end 
end

function bubbleWarpThePlayers(player, instance, stage)
    
    if (instance:getLocalVar("Nyzul_TransferInitiated") == 0) then    
        instance:setLocalVar("Nyzul_TransferInitiated", player:getID())
        instance:setStage(stage)
        player:startEvent(95)
        for _,char in pairs(instance:getChars()) do
            if char:getID() ~= player:getID() then
                char:release()
                char:startEvent(95)
            end
        end
    end
end

function showObjectives(player)
    local instance = player:getInstance()
    local objective = instance:getLocalVar("Nyzul_Objective")
    local subObjective = instance:getLocalVar("Nyzul_SubObjective")

    if (objective > 0) then
        player:messageSpecial(objectiveToStringMap[objective])
    end

    if (subObjective > 0) then
        player:messageSpecial(subObjectiveToStringMap[subObjective])
    end
end
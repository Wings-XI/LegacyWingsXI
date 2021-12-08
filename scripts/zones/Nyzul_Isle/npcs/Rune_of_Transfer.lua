------------------------------------------------
-- Rune of Transfer in Nyzul Isle Investigation
-- This includes the starter Rune of Transfer and the alternating floor ones
------------------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Nyzul_Isle/IDs")
------------------------------------------------
local STARTING_RUNE_OF_TRANSFER_ID = 17093429

local objectiveToStringMap = {ID.text.ELIMINATE_ALL_ENEMIES, ID.text.ELIMINATE_ENEMY_LEADER, ID.text.ELIMINATE_SPECIFIED_ENEMY, ID.text.ELIMINATE_SPECIFIED_ENEMIES,
                              ID.text.ACTIVATE_ALL_LAMPS, ID.text.ACTIVATE_ALL_LAMPS, ID.text.ACTIVATE_ALL_LAMPS}
local subObjectiveToStringMap = {ID.text.DO_NOT_DESTROY_GEARS, ID.text.AVOID_DISCOVERY_GEARS}

function onTrigger(player, npc)
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
        if (npc:AnimationSub() ~= 1) then
            showObjectives(player)
        else
            printf("On Floor - Rune_of_Transfer onTrigger")
        end
    end
end

function onEventFinish(player, csid, option, npc)
    printf("Rune_of_Transfer onEventFinish CSID %u OPTION %u", csid, option)

    -- entrance rune of transfer
    if (csid == 94 and option > 0 and option <= 20) then
        for _,mob in pairs(player:getInstance():getMobs()) do
            -- not used for inital floor transfer
            mob:deaggroAll()
        end
        player:getInstance():setStage((option - 1) * 5 + 1 )
        --player:getInstance():setStage(20)
        player:startEvent(95) -- ToDo do this for all players in the instance.  Note - this works to catch up players left behind by a Connection Lost
    end

    -- bubble warp
    if (csid == 95) then
        local instance = player:getInstance()
        player:messageSpecial(ID.text.TRANSFER_COMPLETE, instance:getStage())
        showObjectives(player)
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
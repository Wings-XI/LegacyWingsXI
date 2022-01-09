------------------------------------------------
-- Rune of Transfer in Nyzul Isle Investigation
-- This includes the starter Rune of Transfer and the alternating floor ones
------------------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/besieged")
require("scripts/globals/nyzul_isle")
local ID = require("scripts/zones/Nyzul_Isle/IDs")
------------------------------------------------
local STARTING_RUNE_OF_TRANSFER_ID = 17093429
local VENDING_BOX = 17093430
local SPLIT_PATH_CHANCE = 10 -- percent chance to have a split path (choose left or right)
local floorWarpCosts = {0, 500, 550, 600, 650, 700, 750, 800, 850, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900}

local function releaseOtherPlayers(player)
    local instance = player:getInstance()
    for _,char in pairs(instance:getChars()) do
        if char:getID() ~= player:getID() then
            char:release()
        end
    end
end

-- 1 locks, 0 unlocks
local function updateNpcLocks(instance, lockValue)
    local vendingBox = GetNPCByID(VENDING_BOX, instance)
    vendingBox:setLocalVar("Nyzul_VendingBoxLock", lockValue)
    local startingRuneOfTransfer = GetNPCByID(STARTING_RUNE_OF_TRANSFER_ID, instance)
    startingRuneOfTransfer:setLocalVar("Nyzul_RuneOfTransferLock", lockValue)
end

function onTrigger(player, npc)
    -- Force players out of menus when an active rune of transfer is touched
    if (npc:AnimationSub() > 0) then
        releaseOtherPlayers(player)
    end

    -- Rune of Transfer in the starting room
    if (npc:getID() == STARTING_RUNE_OF_TRANSFER_ID) then
        if (player:hasKeyItem(tpz.ki.RUNIC_DISC)) then
            if (npc:getLocalVar("Nyzul_RuneOfTransferLock") ~= player:getID()) then
                player:PrintToPlayer("Only one player may access this Rune Of Transfer at a time.", 0x1F)
                return
            end
            -- Lock the vending box
            updateNpcLocks(player:getInstance(), player:getID())
            -- Force players out of other menus
            releaseOtherPlayers(player)
            -- 0 if never set before, up to 100 for runic key
            local floorProgress = player:getCharVar("Nyzul_RunicDiscProgress")
            local floorBitMask = 2097151 -- 111111111111111111111 - hides all floors (and the None option)
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
            -- not lit up - so repeat the objective but dont show pathos
            showNyzulObjectivesAndPathos(player, false)
        else
            if(npc:getLocalVar("Nyzul_RuneOfTransferLock") ~= player:getID()) then
                player:PrintToPlayer("Only one player may access this Rune Of Transfer at a time.", 0x1F)
                return
            end

            -- Lock to single player only
            npc:setLocalVar("Nyzul_RuneOfTransferLock", player:getID())
            -- Rune is lit up - allow transfer (200 and 201 appear to be interchangeable
            -- Exit/Go Up dialog
            -- Param 1 = bitflag to show menu options.
                -- 1 = Not yet, 2 = Exit, 4 = Travel to next floor, 8 = Go Right, 16 = Go Left, 32 = Travel to floor <Param 2>., 64 = Travel to floor ???
            -- Param 2 = Floor number to be shown in Menu item "Travel to floor <number>"
            if (npc:getLocalVar("Nyzul_SplitPathChance") < SPLIT_PATH_CHANCE) then
                player:startEvent(200, 27)
            else
                player:startEvent(200, 7)
            end
        end
    end
end

function onEventFinish(player, csid, option, npc)
    local instance = player:getInstance()

    -- entrance rune of transfer
    if (csid == 94 and option > 0 and option <= 20) then
        local floorSelected = (option - 1) * 5 + 1
        local cost = floorWarpCosts[option]
        local tokens = player:getAssaultPoint(NYZUL_ISLE_ASSAULT_POINT)
        if (cost <= tokens) then
            player:delAssaultPoint(cost, NYZUL_ISLE_ASSAULT_POINT) -- Remove from NYZUL_ISLE_ASSAULT_POINT
            instance:setLocalVar("Nyzul_StartingFloor", floorSelected)
            instance:setLocalVar("Nyzul_DiscUserJob", player:getMainJob())
            bubbleWarpThePlayers(player, instance, floorSelected)
            local chars = instance:getChars()
            instance:setLocalVar("Nyzul_NumberOfPlayers", #chars)
        else
            -- Unlock the vending box
            updateNpcLocks(instance, 0)
            player:messageSpecial(ID.text.INSUFFCIENT_TOKENS)
        end
    elseif (csid == 94) then
        -- Unlock the vending box
        updateNpcLocks(instance, 0)
    end

    -- any non-entrance lamp
    if (csid == 200 and option > 0 and option <= 4) then
        -- 1 = Exit     2 = Go Up      3 = Travel to the right     4 = Travel to the Left
        for _,mob in pairs(instance:getMobs()) do
            clearHateIfRequired(mob)
        end

        -- players choose to exit
        if (option == 1) then
            instance:complete()
        else
            if (option >= 3 and option <= 4) then
                -- split path, flag the instance to determine a Pathos
                instance:setLocalVar("Nyzul_DeterminePathos", 1)
            else
                instance:setLocalVar("Nyzul_DeterminePathos", 0)
            end

            bubbleWarpThePlayers(player, instance, instance:getStage() + 1)
            npc:setLocalVar("Nyzul_RuneOfTransferLock", 0)
        end
    elseif (csid == 200) then
        npc:setLocalVar("Nyzul_RuneOfTransferLock", 0)
    end

    -- bubble warp
    if (csid == 95) then
        player:messageSpecial(ID.text.TRANSFER_COMPLETE, instance:getStage())
        showNyzulObjectivesAndPathos(player, true)
        
        if (instance:getLocalVar("Nyzul_TransferInitiated") == player:getID()) then
            instance:setLocalVar("Nyzul_TransferInitiated", 0)
        end
    end

    -- instance complete warp
    if csid == 1 then
        player:setPos(180, 0, 20, 90, 72)
    end
end

function bubbleWarpThePlayers(player, instance, stage)
    -- locking mechanism to prevent mutiple players from trying to go up a floor all at once
    if (instance:getLocalVar("Nyzul_TransferInitiated") == 0) then    
        instance:setLocalVar("Nyzul_TransferInitiated", player:getID())
        instance:setStage(stage)
        -- select the floor we are headed to
        selectNextFloor(stage, instance)
        player:startEvent(95)
        for _,char in pairs(instance:getChars()) do
            if char:getID() ~= player:getID() then
                char:release()
                char:disengage()
                char:startEvent(95)
            end
        end
    end
end
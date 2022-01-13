-------------------------------------------
-- Vending Box in Nyzul Isle Investigation
-------------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Nyzul_Isle/IDs")
-------------------------------------------
local LOW_GRADE_COST = 100
local MEDIUM_GRADE_COST = 200
local HIGH_GRADE_COST = 300
-------------------------------------------

local lowGradeItems = {         --  Item           
    [1] = {BitPosition = 1, ItemID = 5385},    --  Barb Drink     
    [2] = {BitPosition = 2, ItemID = 5386},    --  Fighter Drink  
    [3] = {BitPosition = 3, ItemID = 5387},    --  Oracle Drink   
    [4] = {BitPosition = 4, ItemID = 5388},    --  Assn Drink     
    [5] = {BitPosition = 5, ItemID = 5389},    --  Spy Drink      
    [6] = {BitPosition = 10, ItemID = 5394},   --  Gnostic Drink  
    [7] = {BitPosition = 12, ItemID = 5396},   --  Shep Drink     
    [8] = {BitPosition = 18, ItemID = 5436},   --  Reraise        
    [9] = {BitPosition = 19, ItemID = 5437},   --  Strange Milk   
    [10] = {BitPosition = 20, ItemID = 5438},  --  Strange Juice  
    [11] = {BitPosition = 21, ItemID = 5439},  --  Vicars Drink   
    [12] = {BitPosition = 26, ItemID = 5397},  --  Sprinter Drink 
}

local mediumGradeItems = {      --  Item           
    [1] = {BitPosition = 6, ItemID = 5390},    --  Braver Drink   
    [2] = {BitPosition = 7, ItemID = 5391},    --  Soldier Drink  
    [3] = {BitPosition = 8, ItemID = 5392},    --  Champ Drink    
    [4] = {BitPosition = 9, ItemID = 5393},    --  Monarch Drink  
    [5] = {BitPosition = 11, ItemID = 5395},   --  Cleric Drink   
    [6] = {BitPosition = 13, ItemID = 5431},   --  Dusty Potion   
    [7] = {BitPosition = 14, ItemID = 5432},   --  Dusty Ether    
    [8] = {BitPosition = 16, ItemID = 5434},   --  Fanatic Drink  
    [9] = {BitPosition = 17, ItemID = 5435},   --  Fools Drink    
    [10] = {BitPosition = 22, ItemID = 5440},  --  Dusty Wing     
    [11] = {BitPosition = 23, ItemID = 4147},  --  Body Boost     
    [12] = {BitPosition = 24, ItemID = 4200},  --  Mana Boost     
}

local highGradeItems = {        --  Item        
    [1] = {BitPosition = 15, ItemID = 5433},   --  Dusty Elixir
}

local function giveTempItemToPlayer(player, itemID, cost)
    if (player:addTempItem(itemID)) then
        player:delAssaultPoint(cost, NYZUL_ISLE_ASSAULT_POINT)
        player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, itemID)
    end
end

local function giveAllPreferredTempItemToPlayer(player, byPassPrefCheck)
    local vendingBoxPreferences = player:getCharVar("Nyzul_VendingBoxPref")
    
    for k,v in pairs(lowGradeItems) do
        if (bit.band(bit.lshift(1, v.BitPosition), vendingBoxPreferences) > 0) or byPassPrefCheck then
            if (not player:hasItem(v.ItemID, 3)) then
                giveTempItemToPlayer(player, v.ItemID, LOW_GRADE_COST)
            end
        end
    end

    for k,v in pairs(mediumGradeItems) do
        if (bit.band(bit.lshift(1, v.BitPosition), vendingBoxPreferences) > 0) or byPassPrefCheck then
            if (not player:hasItem(v.ItemID, 3)) then
                giveTempItemToPlayer(player, v.ItemID, MEDIUM_GRADE_COST)
            end
        end
    end

    for k,v in pairs(highGradeItems) do
        if (bit.band(bit.lshift(1, v.BitPosition), vendingBoxPreferences) > 0) or byPassPrefCheck then
            if (not player:hasItem(v.ItemID, 3)) then
                giveTempItemToPlayer(player, v.ItemID, HIGH_GRADE_COST)
            end
        end
    end
    
end

local function giveSinglePreferredTempItemToPlayer(player, bitPosition)

    for k,v in pairs(lowGradeItems) do
        if (v.BitPosition == bitPosition) then
            giveTempItemToPlayer(player, v.ItemID, LOW_GRADE_COST)
            return
        end
    end

    for k,v in pairs(mediumGradeItems) do
        if (v.BitPosition == bitPosition) then
            giveTempItemToPlayer(player, v.ItemID, MEDIUM_GRADE_COST)
            return
        end
    end

    for k,v in pairs(highGradeItems) do
        if (v.BitPosition == bitPosition) then
            giveTempItemToPlayer(player, v.ItemID, HIGH_GRADE_COST)
            return
        end
    end
end

local function getTempItemsHeldByPlayer(player)
    local returnTempItems = 0

    for k,v in pairs(lowGradeItems) do
        if player:hasItem(v.ItemID, 3) then
            returnTempItems = returnTempItems + bit.lshift(1, v.BitPosition)
        end
    end

    for k,v in pairs(mediumGradeItems) do
        if player:hasItem(v.ItemID, 3) then
            returnTempItems = returnTempItems + bit.lshift(1, v.BitPosition)
        end
    end

    for k,v in pairs(highGradeItems) do
        if player:hasItem(v.ItemID, 3) then
            returnTempItems = returnTempItems + bit.lshift(1, v.BitPosition)
        end
    end

    return returnTempItems
end

function onTrigger(player, npc)
    local locked = npc:getLocalVar("Nyzul_VendingBoxLock")
    if (locked > 0) then
        player:PrintToPlayer("The Vending Box is locked while players are using the Rune Of Transfer.", 0x1F)
        return
    end
    local tokens = player:getAssaultPoint(NYZUL_ISLE_ASSAULT_POINT)
    local vendingBoxPreferences = player:getCharVar("Nyzul_VendingBoxPref")
    local tempItemsHeld = getTempItemsHeldByPlayer(player)
     --[[cs 202
    - Param 1 - ???? - even after going through the assembly - still not sure what this does
	- param 2 - Current tokens
	- param 3 - Temp items currently held
	- param 4 - Preferred items
	- param 5 - Enables low items - represents cost per item
	- param 6 - Enables medium - represents cost per item
	- param 7 - Enables high - represents cost per item]]
    player:startEvent(202, 0, tokens, tempItemsHeld, vendingBoxPreferences, LOW_GRADE_COST, MEDIUM_GRADE_COST, HIGH_GRADE_COST)
end

function onEventUpdate(player, csid, option)
    local categorytype = bit.rshift(option, 8)
    
    if (categorytype == 0x11) then
        -- Preferred Items
        local item = bit.bxor(option, bit.lshift(0x11, 8))
        if (item == 1) then
            giveAllPreferredTempItemToPlayer(player)
        else
            -- bit positions are off due to 1 meaning "give all"
            giveSinglePreferredTempItemToPlayer(player, item - 1)
        end
    elseif (categorytype == 0x21) then
        -- Low Quality Items - options returned are 2-13
        local item = bit.bxor(option, bit.lshift(categorytype, 8))
        giveTempItemToPlayer(player, lowGradeItems[item-1].ItemID, LOW_GRADE_COST)
    elseif (categorytype == 0x31) then
        -- Medium Quality Items - options returned are 2-13
        local item = bit.bxor(option, bit.lshift(categorytype, 8))
        giveTempItemToPlayer(player, mediumGradeItems[item-1].ItemID, MEDIUM_GRADE_COST)
    elseif (categorytype == 0x41) then
        -- High Quality Items
        local item = bit.bxor(option, bit.lshift(categorytype, 8))
        giveTempItemToPlayer(player, highGradeItems[item].ItemID, HIGH_GRADE_COST)
    elseif (categorytype == 0x51) then
        -- Player has requested all items they do not own
        local byPassPrefCheck = true
        giveAllPreferredTempItemToPlayer(player, byPassPrefCheck)
        
    end

    local tokens = player:getAssaultPoint(NYZUL_ISLE_ASSAULT_POINT)
    local vendingBoxPreferences = player:getCharVar("Nyzul_VendingBoxPref")
    local tempItemsHeld = getTempItemsHeldByPlayer(player)
    -- send update
    player:updateEvent(0, tokens, tempItemsHeld, vendingBoxPreferences, LOW_GRADE_COST, MEDIUM_GRADE_COST, HIGH_GRADE_COST)
end

function onEventFinish(player, csid, option, npc)
    
end
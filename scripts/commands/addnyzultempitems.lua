---------------------------------------------------------------------------------------------------
-- func: addnyzultempitems
-- desc: Adds all temp items from nyzul to the players inventory.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "ii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addnyzultempitems")
end

function onTrigger(player)

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

    for k,v in pairs(lowGradeItems) do
        player:addTempItem(v.ItemID, 1, 0, 0, 0, 0, 0, 0, 0, 0)
    end

    for k,v in pairs(mediumGradeItems) do
        player:addTempItem(v.ItemID, 1, 0, 0, 0, 0, 0, 0, 0, 0)
    end

    for k,v in pairs(highGradeItems) do
        player:addTempItem(v.ItemID, 1, 0, 0, 0, 0, 0, 0, 0, 0)
    end

    player:PrintToPlayer("Added all temp items available in Nyzul Isle Investigation to temp inventory")

end

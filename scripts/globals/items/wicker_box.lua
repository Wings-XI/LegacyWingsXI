-----------------------------------------
-- ID: 43
-- Item: Wicker Box
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("HornQuiverObtained") == 0 then 
        player:setCharVar("WickerBoxPlaced", getConquestTally())
    end 
end

function onFurnitureRemoved(player)
    player:setCharVar("WickerBoxPlaced", 0)
end

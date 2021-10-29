-----------------------------------------
-- ID: 2
-- Item: Simple Bed
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("IronOreObtained") == 0 then 
        player:setCharVar("SimpleBedPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("SimpleBedPlaced", 0)
end

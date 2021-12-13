-----------------------------------------
-- ID: 3
-- Item: Oak Bed
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("EtherObtained") == 0 then 
        player:setCharVar("OakBedPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("OakBedPlaced", 0)
end

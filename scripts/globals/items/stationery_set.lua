-----------------------------------------
-- ID: 131
-- Item: Stationery Set
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("ScopsOperettaObtained") == 0 then 
        player:setCharVar("StationerySetPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("StationerySetPlaced", 0)
end

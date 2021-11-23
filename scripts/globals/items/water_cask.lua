-----------------------------------------
-- ID: 93
-- Item: Water Cask
-- Note: Furniture quest item (Repeatable)
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    player:setCharVar("WaterCaskPlaced", getConquestTally())
end

function onFurnitureRemoved(player)
    player:setCharVar("WaterCaskPlaced", 0)
end

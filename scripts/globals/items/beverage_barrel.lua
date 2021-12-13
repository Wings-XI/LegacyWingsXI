-----------------------------------------
-- ID: 96
-- Item: Beverage Barrel
-- Note: Furniture quest item (Repeatable)
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    player:setCharVar("BeverageBarrelPlaced", getConquestTally())
end

function onFurnitureRemoved(player)
    player:setCharVar("BeverageBarrelPlaced", 0)
end

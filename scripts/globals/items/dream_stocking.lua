-----------------------------------------
-- ID: 155
-- Item: Dream Stocking
-- Note: Furniture quest item during Starlight Festival (Repeatable)
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------

function onFurniturePlaced(player)
    player:setCharVar("DreamStockingPlaced", 1)
end

function onFurnitureRemoved(player)
    player:setCharVar("DreamStockingPlaced", 0)
end

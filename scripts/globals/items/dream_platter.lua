-----------------------------------------
-- ID: 140
-- Item: Dream Platter
-- Note: Furniture quest item during Starlight Festival (Repeatable)
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------

function onFurniturePlaced(player)
    player:setCharVar("DreamPlatterPlaced", 1)
end

function onFurnitureRemoved(player)
    player:setCharVar("DreamPlatterPlaced", 0)
end

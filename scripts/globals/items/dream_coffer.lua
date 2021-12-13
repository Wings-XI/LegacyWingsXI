-----------------------------------------
-- ID: 141
-- Item: Dream Coffer
-- Note: Furniture quest item during Starlight Festival (Repeatable)
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------

function onFurniturePlaced(player)
    player:setCharVar("DreamCofferPlaced", 1)
end

function onFurnitureRemoved(player)
    player:setCharVar("DreamCofferPlaced", 0)
end

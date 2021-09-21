-----------------------------------------
-- ID: 115
-- Item: bastokan_tree
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------

function onFurniturePlaced(player)
    player:setCharVar("BastokanTree", 1)
    player:setCharVar("HolidayTree", 1)
end

function onFurnitureRemoved(player)
    player:setCharVar("BastokanTree", 0)
    player:setCharVar("HolidayTree", 0)
end

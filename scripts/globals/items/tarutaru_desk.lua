-----------------------------------------
-- ID: 26
-- Item: Tarutaru Desk
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("HiPotionObtained") == 0 then 
        player:setCharVar("TarutaruDeskPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("TarutaruDeskPlaced", 0)
end

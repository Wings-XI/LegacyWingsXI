-----------------------------------------
-- ID: 61
-- Item: Armoire
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("ProtectIVObtained") == 0 then 
        player:setCharVar("ArmoirePlaced", getConquestTally())
    end     
end

function onFurnitureRemoved(player)
    player:setCharVar("ArmoirePlaced", 0)
end

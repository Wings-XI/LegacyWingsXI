-----------------------------------------
-- ID: 190
-- Item: Copy of Lines and Space
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("OnyxObtained") == 0 then 
        player:setCharVar("LinesAndSpacePlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("LinesAndSpacePlaced", 0)
end

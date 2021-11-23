-----------------------------------------
-- ID: 30
-- Item: Bureau
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("ProtectraIVObtained") == 0 then 
        player:setCharVar("BureauPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("BureauPlaced", 0)
end

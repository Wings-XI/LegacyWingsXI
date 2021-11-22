-----------------------------------------
-- ID: 110
-- Item: White Jar
-- Note: Furniture quest item
-----------------------------------------
require("scripts/globals/common")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getCharVar("ParalyzePotionObtained") == 0 then 
        player:setCharVar("WhiteJarPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("WhiteJarPlaced", 0)
end

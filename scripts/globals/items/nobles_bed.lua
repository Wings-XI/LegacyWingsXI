-----------------------------------------
-- ID: 6
-- Item: Noble's Bed
-- Note: Mog Safe expansion quest item 
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.MOOGLES_IN_THE_WILD) == QUEST_AVAILABLE then
        player:setCharVar("[MS3]BedPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("[MS3]BedPlaced", 0)
end

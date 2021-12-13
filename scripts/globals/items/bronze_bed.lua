-----------------------------------------
-- ID: 5
-- Item: Bronze Bed
-- Note: Mog Safe expansion quest item 
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK) == QUEST_AVAILABLE then
        player:setCharVar("[MS1]BedPlaced", getConquestTally())
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("[MS1]BedPlaced", 0)
end

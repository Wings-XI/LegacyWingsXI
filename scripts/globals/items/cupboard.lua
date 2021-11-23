-----------------------------------------
-- ID: 57
-- Item: Cupboard
-- Note: Unexpected Treasure quest item
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------------

function onFurniturePlaced(player)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE) == QUEST_AVAILABLE then
        player:setCharVar("CupboardPlaced", 1)
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("CupboardPlaced", 0)
end

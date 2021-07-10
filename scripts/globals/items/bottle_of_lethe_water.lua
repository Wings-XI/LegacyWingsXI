-----------------------------------------
-- ID: 4210
-- Item: Bottle of Lethe Water
-- Item Effect: This potion dispells up to three positive effects.  
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    -- TODO add messaging
    target:dispelStatusEffect()
    target:dispelStatusEffect()
    target:dispelStatusEffect()
end


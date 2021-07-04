-----------------------------------------
-- ID: 15817
-- Item: Ecphoria Ring
-- Item Effect: Cures Amnesia.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)

    if (target:hasStatusEffect(tpz.effect.AMNESIA) == true and target:getStatusEffect(tpz.effect.AMNESIA):getPower() == 1) then
        target:delStatusEffect(tpz.effect.AMNESIA)
    end
end


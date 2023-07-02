-----------------------------------------
-- ID: 5502
-- Allies' Die
-- Teaches the job ability Allies Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.ALLIES_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.ALLIES_ROLL)
end

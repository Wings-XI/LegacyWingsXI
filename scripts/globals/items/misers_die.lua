-----------------------------------------
-- ID: 5503
-- Miser's Die
-- Teaches the job ability Miser's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.MISERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.MISERS_ROLL)
end

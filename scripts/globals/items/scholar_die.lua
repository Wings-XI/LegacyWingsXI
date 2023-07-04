-----------------------------------------
-- ID: 5496
-- Scholar Die
-- Teaches the job ability Scholars Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.SCHOLARS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.SCHOLARS_ROLL)
end

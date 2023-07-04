-----------------------------------------
-- ID: 5484
-- Dark Knight Die
-- Teaches the job ability Chaos Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.CHAOS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.CHAOS_ROLL)
end

-----------------------------------------
-- ID: 5504
-- Companions Die
-- Teaches the job ability Companions Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.COMPANIONS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.COMPANIONS_ROLL)
end

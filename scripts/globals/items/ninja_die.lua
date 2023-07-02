-----------------------------------------
-- ID: 5489
-- Ninja Die
-- Teaches the job ability Ninja Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.NINJA_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.NINJA_ROLL)
end

-----------------------------------------
-- ID: 5488
-- Samurai Die
-- Teaches the job ability Samurai Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.SAMURAI_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.SAMURAI_ROLL)
end

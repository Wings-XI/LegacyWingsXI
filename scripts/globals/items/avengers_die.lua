-----------------------------------------
-- ID: 5505
-- Avenger's Die
-- Teaches the job ability Avengers Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.AVENGERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.AVENGERS_ROLL)
end

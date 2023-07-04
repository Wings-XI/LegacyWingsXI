-----------------------------------------
-- ID: 5191
-- Summoner Die
-- Teaches the job ability Evoker's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.EVOKERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.EVOKERS_ROLL)
end

-----------------------------------------
-- ID: 5479
-- White Mage Die
-- Teaches the job ability Healer's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.HEALERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.HEALERS_ROLL)
end

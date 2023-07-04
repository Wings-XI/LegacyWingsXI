-----------------------------------------
-- ID: 5492
-- Blue Mage Die
-- Teaches the job ability Magus's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.MAGUSS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.MAGUSS_ROLL)
end

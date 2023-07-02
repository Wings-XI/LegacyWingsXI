-----------------------------------------
-- ID: 5480
-- Black Mage Die
-- Teaches the job ability Wizard's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.WIZARDS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.WIZARDS_ROLL)
end

-----------------------------------------
-- ID: 5477
-- Warrior Die
-- Teaches the job ability Fighter's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.FIGHTERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.FIGHTERS_ROLL)
end

-----------------------------------------
-- ID: 6368
-- Geomancer Die
-- Teaches the job ability Naturalists Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.NATURALISTS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.NATURALISTS_ROLL)
end

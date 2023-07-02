-----------------------------------------
-- ID: 6369
-- Rune Fencer Die
-- Teaches the job ability Runeist's Roll
-----------------------------------------
require("scripts/globals/ability")

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.RUNEISTS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.RUNEISTS_ROLL)
end

-----------------------------------------
-- ID: 15552 and 15555
-- Item: albatross ring
-- Fishing Stamina Bonus
-----------------------------------------
-- Bonus: +30s to Fishing Stamina
-- Duration: 20:00 min
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.ALBATROSS_RING_EFFECT) == true) then
        result = 56
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ALBATROSS_RING_EFFECT, 1, 0, 1200)
end

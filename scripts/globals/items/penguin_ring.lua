-----------------------------------------
-- ID: 15553 and 15556
-- Item: penguin ring
-- Increases skill at tiring fish
-----------------------------------------
-- Bonus: The effect of the ring dramatically increases the rate of stamina drain of a fish while you try to reel it in.
-- Duration: 20:00 min
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.PENGUIN_RING_EFFECT) == true) then
        result = 56
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.PENGUIN_RING_EFFECT, 1, 0, 1200)
end
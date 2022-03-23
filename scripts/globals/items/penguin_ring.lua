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
    if (target:getMod(tpz.mod.PENGUIN_RING_EFFECT) ~= 0) then
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE_2
    end
    return result
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.NA, tpz.effect.ENCHANTMENT, 0, 3, 1200)
    target:addMod(tpz.mod.PENGUIN_RING_EFFECT, 1200)
end
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
    if (target:getMod(tpz.mod.ALBATROSS_RING_EFFECT) == true) then
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE_2
    end
    return result
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.ENCHANTMENT, tpz.effect.ENCHANTMENT, 0, 3, 1200)
    target:addMod(tpz.mod.ALBATROSS_RING_EFFECT, 1200)
end

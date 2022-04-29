-----------------------------------------
-- ID: 15462
-- Item: Sagacious Gold Obi
-- Effect: 3Min, INT +3
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15459 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 15459)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 3)
end
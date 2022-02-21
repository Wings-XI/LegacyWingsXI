-----------------------------------------
-- ID: 15462
-- Item: Sagacious Brocade Obi
-- Effect: 10Min, INT +10
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 600, 15462)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 10)
end
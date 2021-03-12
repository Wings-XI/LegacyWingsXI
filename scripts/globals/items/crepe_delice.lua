-----------------------------------------
-- ID: 5767
-- Item: Crepe Delice
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- HP +10% (cap 15)
-- Magic Accuracy +21% (cap 30)
-- Magic Defense +2
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5767)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 15)
    target:addMod(tpz.mod.MDEF, 2)
    target:addMod(tpz.mod.MACC, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 15)
    target:delMod(tpz.mod.MDEF, 2)
    target:delMod(tpz.mod.MACC, 3)
end

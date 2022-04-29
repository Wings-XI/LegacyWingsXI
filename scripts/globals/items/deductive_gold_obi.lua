-----------------------------------------
-- ID: 15460
-- Item: deductive_brocade_obi
-- Item Effect: MND+3
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15460 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 15460)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MND, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MND, 3)
end

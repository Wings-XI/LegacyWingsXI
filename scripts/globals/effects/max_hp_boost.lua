-----------------------------------
--
-- tpz.effect.MAX_HP_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if effect:getTier() > 0 then target:addMod(tpz.mod.HP, effect:getPower())
    else target:addMod(tpz.mod.HPP, effect:getPower()) end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if effect:getTier() > 0 then target:delMod(tpz.mod.HP, effect:getPower())
    else target:delMod(tpz.mod.HPP, effect:getPower()) end
end

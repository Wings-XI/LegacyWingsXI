-----------------------------------
--
-- tpz.effect.KILLER_INSTINCT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(effect:getPower(), 10) -- add killer effect at 10% rate
    target:addMod(effect:getPower()+1000, 15) -- add circle effect at 15% potency
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(effect:getPower(), 10)
    target:delMod(effect:getPower()+1000, 15)
end

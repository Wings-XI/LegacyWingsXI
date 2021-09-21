-----------------------------------
--
--     tpz.effect.MAX_TP_DOWN
--      
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MAX_TP, -effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MAX_TP, -effect:getPower())
end

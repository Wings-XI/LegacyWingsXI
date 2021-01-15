-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(dsp.mod.ENMITY_LOSS_REDUCTION, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(dsp.mod.ENMITY_LOSS_REDUCTION, effect:getPower())
end

-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(dsp.mod.SLEEPRES, effect:getPower())
    target:addMod(dsp.mod.LULLABYRES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(dsp.mod.SLEEPRES, effect:getPower())
    target:delMod(dsp.mod.LULLABYRES, effect:getPower())
end

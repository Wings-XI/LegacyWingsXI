-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SLEEPRES, effect:getPower())
    target:addMod(tpz.mod.LULLABYRES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SLEEPRES, effect:getPower())
    target:delMod(tpz.mod.LULLABYRES, effect:getPower())
end

-----------------------------------
--  Brainjack
--  Specifically, the 25/tick dot
-----------------------------------

function onEffectGain(target, effect)
    target:delMod(tpz.mod.REGEN, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:addMod(tpz.mod.REGEN, effect:getPower())
end

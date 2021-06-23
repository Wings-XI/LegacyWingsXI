-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
	target:addMod(tpz.mod.CURSERES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
	target:delMod(tpz.mod.CURSERES, effect:getPower())
end

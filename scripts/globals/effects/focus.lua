-----------------------------------
--
--     tpz.effect.FOCUS
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
   target:addMod(tpz.mod.ACC, effect:getPower())
   target:addMod(tpz.mod.COUNTER, 27)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.ACC, effect:getPower())
   target:delMod(tpz.mod.COUNTER, 27)
end

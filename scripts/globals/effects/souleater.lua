-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, 25)
    target:addMod(tpz.mod.ENMITY,-(effect:getPower()))
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, 25)
    target:delMod(tpz.mod.ENMITY,-(effect:getPower()))
end

-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addPetMod(tpz.mod.MACC, effect:getPower())
    target:addPetMod(tpx.mod.MATT, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delPetMod(tpz.mod.ACC, effect:getPower())
    target:delPetMod(tpx.mod.MATT, effect:getPower())
end
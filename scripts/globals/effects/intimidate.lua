-----------------------------------
--
-- tpz.effect.INT_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(tpz.mod.SUPER_INTIMIDATION,effect:getPower())
end

function onEffectTick(target,effect)
end

function onEffectLose(target,effect)
    target:delMod(tpz.mod.SUPER_INTIMIDATION,effect:getPower())
end

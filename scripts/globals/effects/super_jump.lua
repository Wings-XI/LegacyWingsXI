-----------------------------------
--
-- tpz.effect.super_jump
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(tpz.mod.SUPER_JUMP,effect:getPower())
end

function onEffectLose(target,effect)
    target:delMod(tpz.mod.SUPER_JUMP,boostAGI_effect_size)
end

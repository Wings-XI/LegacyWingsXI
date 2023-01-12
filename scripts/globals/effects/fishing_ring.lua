-----------------------------------
--
-- tpz.effect.FISHING_RING
-- Notes: SubPower = modID to enhance
--        MainPower = power of the mod
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
end

function onEffectLose(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end

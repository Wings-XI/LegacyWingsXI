-----------------------------------
--
-- tpz.effect.SENTINEL
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.UDMGPHYS, -effect:getPower())
    target:addMod(tpz.mod.ENMITY, 100)
    target:addMod(tpz.mod.ENMITY_LOSS_REDUCTION, effect:getSubPower())
end

function onEffectTick(target, effect)
   local power = effect:getPower()
   local decayby = 5
      effect:setPower(power-decayby)
      target:delMod(tpz.mod.UDMGPHYS, -decayby)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UDMGPHYS, -effect:getPower())
    target:delMod(tpz.mod.ENMITY, 100)
    target:delMod(tpz.mod.ENMITY_LOSS_REDUCTION, effect:getSubPower())
end

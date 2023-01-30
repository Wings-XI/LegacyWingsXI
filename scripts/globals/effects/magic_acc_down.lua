-----------------------------------
--
-- tpz.effect.MAGIC_ACC_DOWN
--
-----------------------------------

function onEffectGain(target, effect)
    if (effect:getPower()>100) then
        effect:setPower(50)
    end
    target:addMod(tpz.mod.MACC, -effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MACC, -effect:getPower())
end

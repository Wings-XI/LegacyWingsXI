-----------------------------------
--
-- tpz.effect.ATTACK_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if (effect:getPower()>100) then
        effect:setPower(50)
    end
    target:addMod(tpz.mod.ATTP, -effect:getPower())
    target:addMod(tpz.mod.RATTP,-effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATTP, -effect:getPower())
    target:delMod(tpz.mod.RATTP,-effect:getPower())
end

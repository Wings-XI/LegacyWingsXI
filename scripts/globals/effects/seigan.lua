-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    effect:setPower(target:getMod(tpz.mod.ZANSHIN)/4 + target:getMerit(tpz.merit.ZANSHIN_ATTACK_RATE)/4)
    target:addMod(tpz.mod.COUNTER,effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.COUNTER,effect:getPower())
end

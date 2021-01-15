-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.KICK_ATTACK_RATE, 15)
    --target:addMod(tpz.mod.KICK_DMG, effect:getPower())
    --target:addMod(tpz.mod.ATTP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.KICK_ATTACK_RATE, 15)
    --target:delMod(tpz.mod.KICK_DMG, effect:getPower())
    --target:delMod(tpz.mod.ATTP, effect:getPower())
end

-----------------------------------
--
--  tpz.mod.COVER_EFFECT
--
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setMod(tpz.mod.COVERED_MP_FLAG, 0)
    target:setLocalVar("COVER_ABILITY_TARGET", 0)
end

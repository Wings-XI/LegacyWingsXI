-----------------------------------
--
--     tpz.effect.HUNDRED_FISTS
--
-----------------------------------

function onEffectGain(target, effect)
    target:SetMobAbilityEnabled(false)
    target:SetMagicCastingEnabled(false)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:SetMobAbilityEnabled(true)
    target:SetMagicCastingEnabled(true)
end

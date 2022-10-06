-----------------------------------
-- Sleep
--
-- NOTE: If the effect is accompanied by subeffect EFFECT_BIO, it is nightmare sleep
-- This means bio is applied when the sleep is applied and the sleep behaves a little differently
-- more information can be found in nightmare.lua
-----------------------------------

function onEffectGain(target, effect)
    -- WINGSTODO Fix upstream
    if (effect:getSubType() == tpz.effect.BIO and effect:getSubPower() > 0) then
        -- bio with subeffect sleep, so we don't wake up targets from this dot damage
        -- confirmed that nightmare does have 2 separate effects (sleep and bio): https://youtu.be/LKpSQQPf0hE?t=338
        -- attp reduction = sleep power
        -- dot damage = sleep subpower
        target:delStatusEffectSilent(tpz.effect.BIO)
        target:addStatusEffect(tpz.effect.BIO, effect:getSubPower(), 3, 90, tpz.effect.SLEEP_I, effect:getPower(), 1)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
end

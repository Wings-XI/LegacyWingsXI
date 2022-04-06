-----------------------------------
-- Sleep
--
-- NOTE: If the effect is accompanied by EFFECT_BIO, it is a Nightmare effect. 
-----------------------------------

function onEffectGain(target, effect)
    if effect:getSubType() == tpz.effect.BIO then
        -- Nightmare
        target:addMod(tpz.mod.REGEN_DOWN, effect:getSubPower())
        print(string.format("Sub Power: %s", effect:getSubPower()))
    end
end

function onEffectTick(target, effect)
    
end

function onEffectLose(target, effect)
    if effect:getSubType() == tpz.effect.BIO then
        -- Nightmare
        target:delMod(tpz.mod.REGEN_DOWN, effect:getSubPower())
    end
end

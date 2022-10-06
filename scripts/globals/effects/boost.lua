-----------------------------------
--
-- tpz.effect.BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    -- WINGSTODO Fix upstream
    target:addMod(tpz.mod.ATTP, effect:getPower() / 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    -- WINGSTODO Fix upstream
    target:delMod(tpz.mod.ATTP, effect:getPower() / 100)
end

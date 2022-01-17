-----------------------------------
-- Charm
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setTP(0)
    target:uncharm()
    -- if there is a costume set - remove the costume
    if (target:costume() ~= 0) then
        target:costume(0)
    end

    -- remove brainjack if present
    if (target:hasStatusEffect(tpz.effect.BRAINJACK)) then
        target:delStatusEffect(tpz.effect.BRAINJACK)
    end
end

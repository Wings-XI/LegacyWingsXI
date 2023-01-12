-----------------------------------
--
-- tpz.effect.FISHING_RING
-- Notes: SubPower = modID to enhance
--        MainPower = power of the mod
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
    -- WINGSCUSTOM do not drop fishing ring buffs on zoning
    effect:unsetFlag(tpz.effectFlag.ON_ZONE)
end

function onEffectLose(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end

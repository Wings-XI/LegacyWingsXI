-----------------------------------
--
-- tpz.effect.DEFENSE_BOOST
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if effect:getPower() > 10000 then -- rampart
        target:addMod(tpz.mod.DEF, effect:getPower()-10000)
        target:addMod(tpz.mod.SPELLINTERRUPT, effect:getSubPower())
    else
        target:addMod(tpz.mod.DEFP, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if effect:getPower() > 10000 then -- rampart
        target:delMod(tpz.mod.DEF, effect:getPower()-10000)
        target:setMod(tpz.mod.RAMPART_STONESKIN, 0)
        target:delMod(tpz.mod.SPELLINTERRUPT, effect:getSubPower())
    else
        target:delMod(tpz.mod.DEFP, effect:getPower())
    end
end

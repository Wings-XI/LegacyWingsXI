-----------------------------------
--
-- tpz.effect.BOILING_BLOOD
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    local dpower = 100
    local hpower = 2500
    target:addMod(tpz.mod.ATTP, power)
    target:addMod(tpz.mod.RATTP, power)
    target:addMod(tpz.mod.DEFP, -dpower)
    target:addMod(tpz.mod.HASTE_ABILITY, hpower)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    local dpower = 100
    local hpower = 2500
    target:delMod(tpz.mod.ATTP, power)
    target:delMod(tpz.mod.RATTP, power)
    target:delMod(tpz.mod.DEFP, -dpower)
    target:delMod(tpz.mod.HASTE_ABILITY, hpower)
end
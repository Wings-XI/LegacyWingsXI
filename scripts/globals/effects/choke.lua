-----------------------------------
--
-- tpz.effect.CHOKE
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.REGEN_DOWN, effect:getPower())
    local statdown = effect:getSubPower()
    if statdown == 0 or statdown == nil then statdown = getElementalDebuffStatDownFromDOT(effect:getPower())
    target:addMod(tpz.mod.VIT, -statdown)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.REGEN_DOWN, effect:getPower())
    local statdown = effect:getSubPower()
    if statdown == 0 or statdown == nil then statdown = getElementalDebuffStatDownFromDOT(effect:getPower())
    target:delMod(tpz.mod.VIT, -statdown)
end

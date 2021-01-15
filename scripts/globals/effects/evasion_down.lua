-----------------------------------
--
-- tpz.effect.EVASION_DOWN
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = math.min(effect:getPower(), target:getStat(tpz.mod.EVA))
    effect:setPower(power)
    target:delMod(tpz.mod.EVA, power)
end

-- only Feint uses tick, which restores 10 evasion per tick
function onEffectTick(target, effect)
    local subpower = effect:getSubPower()
    local power = effect:getPower()
    
    if subpower > power then
        subpower = power
    end
    
    effect:setPower(power - subpower)
    target:addMod(tpz.mod.EVA, subpower)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    target:addMod(tpz.mod.EVA, power)
end

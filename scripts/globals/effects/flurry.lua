-----------------------------------
--
--  Flurry
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    if (effect:getPower() == 2500) then
        -- Nyzul Isle Flurry - increase attack speed, do not impact spells
        target:addMod(tpz.mod.HASTE_ABILITY, effect:getPower())
    else
        -- Keeping this to support non-wings servers
        target:addMod(tpz.mod.SNAP_SHOT, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (effect:getPower() == 2500) then
        target:delMod(tpz.mod.HASTE_ABILITY, effect:getPower())
    else
        -- Keeping this to support non-wings servers
        target:delMod(tpz.mod.SNAP_SHOT, effect:getPower())
    end
end

-----------------------------------
-- Physical Shield
-- Blocks all physical attacks
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    if (effect:getPower() < 2) then
        target:addMod(tpz.mod.UDMGPHYS, -100)
    elseif (effect:getPower() == 2) then
        target:addMod(tpz.mod.PHYS_ABSORB, 100)
    else
        -- WotG Quadavs and Wivre use the Physical_Shield effect to get directional physical immunity
    end
    
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (effect:getPower() < 2) then
        target:delMod(tpz.mod.UDMGPHYS, -100)
    elseif (effect:getPower() == 2) then
        target:delMod(tpz.mod.PHYS_ABSORB, 100)
    else
        -- WotG Quadavs and Wivre use the Physical_Shield effect to get directional physical immunity
    end
end

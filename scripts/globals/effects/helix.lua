-----------------------------------
--
--     tpz.effect.HELIX
--
-----------------------------------

require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")

function onEffectGain(target, effect)

end

function onEffectTick(target, effect)
    local dmg = utils.stoneskin(target, effect:getPower())
    local flags = {breakBind=false}
    if (dmg > 0) then
        -- we dont care about attacker, attack type, or dmg type
        target:takeDamage(dmg, nil, nil, nil, flags)
    end

    if (effect:getTick() == 3000) then
        effect:setTick(9000)
    end
end

function onEffectLose(target, effect)

end

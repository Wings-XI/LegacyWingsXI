-----------------------------------------
-- ID: 16153
-- Item: Reikyo hairpin
-- Item Effect: Slightly bad breath (bind, paralyze, silence)
-- Allows the wearer to use the ability "Slightly Bad Breath," which inflicts Bind, Paralyze, and Silence on an enemy.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target, param, player)
    local result = 0
    if (target:checkDistance(player) > 10) then
        result = tpz.msg.basic.TOO_FAR_AWAY
    end
    return result
end

function onItemUse(target, effect, player)
    local chance = 85
    local effects = {
        { effect = tpz.effect.BIND, power = 1, duration = 60, mask = 4 },
        { effect = tpz.effect.PARALYSIS, power = 20, duration = 120, mask = 32},
        { effect = tpz.effect.SILENCE, power = 1, duration = 60, mask = 16 },
    }

    for _, effect in pairs(effects) do
        if target:hasImmunity(effect.mask) or math.random(0, 100) >= chance then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(effect.effect)
            if (not target:hasStatusEffect(effect.effect)) then
                target:addStatusEffect(effect.effect, effect.power, 0, effect.duration)
            end
        end
    end
    target:updateClaim(player)
end
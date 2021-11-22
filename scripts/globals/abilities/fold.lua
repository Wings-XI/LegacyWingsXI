-----------------------------------
-- Ability: Fold
-- Erases one roll or bust tpz.effect. Targets self-cast effect with the longest remaining duration.
-- Obtained: Corsair Level 75
-- Recast Time: 00:05:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (target:hasCorsairEffect()) then
        return 0, 0
    else
        return tpz.msg.basic.CANNOT_PERFORM, 0
    end
end

function onUseAbility(player, target, ability, action)
    target:fold()

    return tpz.effect.FOLD
end
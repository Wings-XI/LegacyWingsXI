-----------------------------------
-- Ability: Footwork
-- Makes kicks your primary mode of attack.
-- Obtained: Monk Level 65
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local kickAttPercent = 15
    --local kickAttPercent = 10
    player:addStatusEffect(tpz.effect.FOOTWORK, kickAttPercent, 0, 60*5)
end

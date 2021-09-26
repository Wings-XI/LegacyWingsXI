-----------------------------------
-- Ability: Diabolic Eye
-- Reduces max. HP, increases accuracy.
-- Obtained: Dark Knight Level 75
-- Recast Time: 0:05:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    player:addStatusEffect(tpz.effect.DIABOLIC_EYE,1, 0, 180)
end
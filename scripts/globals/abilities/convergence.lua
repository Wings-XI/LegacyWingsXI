-----------------------------------
-- Ability: Convergence
-- BLU Merit Ability
-- Obtained: Blue Mage Level 75
-- Recast Time: 10:00
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.CONVERGENCE, player:getMerit(tpz.merit.CONVERGENCE), 0, 60)
end

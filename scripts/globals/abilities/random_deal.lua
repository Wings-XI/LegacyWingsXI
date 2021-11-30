-----------------------------------
-- Ability: Random Deal
-- Has the possibility of resetting the reuse time of a job ability for each party member within area of effect.
-- Obtained: Corsair Level 50
-- Recast Time: 0:20:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    --meritRecastReduction(player, tpz.merit.RANDOM_DEAL_RECAST, action)
    if not player:doRandomDeal(target) then
        ability:setMsg(tpz.msg.basic.EVADES)
    end
end
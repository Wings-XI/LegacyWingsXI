-----------------------------------
-- Ability: Chivalry
-- Converts TP to MP.
-- Obtained: Paladin Level 75 (Must be Purchased with Merit Points)
-- Recast Time: 0:20:00 down to 0:10:00 with merits
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player,target,ability)
    local tp = target:getTP()
    -- MP recovered = (TP * .5) + ((0.015 * TP) * MND) 
    local amount = (tp * 0.05 + 0.0015 * tp * target:getStat(tpz.mod.MND))
    target:setTP(0)
    return target:addMP(amount)
end

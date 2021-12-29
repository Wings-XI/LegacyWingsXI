-----------------------------------
-- Ability: Boost
-- Enhances user's next attack.
-- Obtained: Monk Level 5
-- Recast Time: 0:15
-- Duration: 3:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 12.5

    if player:getMod(tpz.mod.BOOST_EFFECT) > 0 then
        power = power + 6.25
    end

    if (player:hasStatusEffect(tpz.effect.BOOST) == true) then
        local effect = player:getStatusEffect(tpz.effect.BOOST)
        effect:setPower(effect:getPower() + power)
        player:addMod(tpz.mod.ATTP, power)
    else
        player:delStatusEffect(tpz.effect.WARCRY)
        player:addStatusEffect(tpz.effect.BOOST, power, 1, 180)
    end

    local BoostCounter = -1
    BoostCounter = target:getLocalVar("BoostCounter")
    target:setLocalVar("BoostCounter", BoostCounter + 1)
end

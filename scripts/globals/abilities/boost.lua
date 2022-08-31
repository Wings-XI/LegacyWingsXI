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
    -- power is 12.5% attack + boost_effect mods from gear, stored as hundreths of attp
    local power = 1250 + player:getMod(tpz.mod.BOOST_EFFECT)

    if (player:hasStatusEffect(tpz.effect.BOOST) == true) then
        local effect = player:getStatusEffect(tpz.effect.BOOST)
        local oldPower = effect:getPower()
        effect:setPower(oldPower + power)
        effect:setSubPower(effect:getSubPower() + 1)
        player:delMod(tpz.mod.ATTP, oldPower / 100)
        player:addMod(tpz.mod.ATTP, (oldPower + power) / 100)
    else
        player:delStatusEffect(tpz.effect.WARCRY)
        player:addStatusEffect(tpz.effect.BOOST, power, 1, 180)
        local effect = player:getStatusEffect(tpz.effect.BOOST)
        effect:setSubPower(1)
    end

end

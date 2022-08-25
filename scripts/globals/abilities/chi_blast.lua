-----------------------------------
-- Ability: Chi Blast
-- Releases Chi to attack an enemy.
-- Obtained: Monk Level 41
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    if target:getID() == (17449008) then
        return 0
    end
    
    local mnd = player:getStat(tpz.mod.MND)
    local boostPower = 0
    local boostNum = 0
    if (player:hasStatusEffect(tpz.effect.BOOST) == true) then
        local boostEffect = player:getStatusEffect(tpz.effect.BOOST)
        boostPowerPerc = boostEffect:getPower() / 1000 -- attp is in tenths of attack %
        boostNum = boostEffect:getSubPower()
    end
    local rand = .5 + math.random()/2

    -- https://ffxiclopedia.fandom.com/wiki/Chi_Blast
    -- DMG = floor( floor( MND × Rand ) × ( #Boost × BoostIncrease% + 1 ) )
    -- boost increase % implies that this should be #boost * (1 + boostincrease%)
    local dmg = math.floor(math.floor(mnd * rand) * (boostNum * (boostPowerPerc * 4 / 100) + 1))
    -- printf("dmg %u, mnd %u, rand %f, boostNum %u, boostPower %u", dmg, mnd, rand, boostNum, boostPowerPerc)
    
    local penance = player:getMerit(tpz.merit.PENANCE)
    
    if penance > 0 then
        target:delStatusEffect(tpz.effect.INHIBIT_TP)
        target:addStatusEffect(tpz.effect.INHIBIT_TP,25,3,penance)
    end

    dmg = utils.stoneskin(target, dmg)
    target:takeDamage(dmg, player, tpz.attackType.SPECIAL, tpz.damageType.ELEMENTAL)
    target:updateEnmityFromDamage(player, dmg)
    target:updateClaim(player)
    player:delStatusEffect(tpz.effect.BOOST)

    return dmg
end

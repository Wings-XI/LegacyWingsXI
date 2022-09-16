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
    local boostPowerPerc = 0
    local boostNum = 0
    if (player:hasStatusEffect(tpz.effect.BOOST) == true) then
        local boostEffect = player:getStatusEffect(tpz.effect.BOOST)
        boostNum = math.max(boostEffect:getSubPower(),1) -- shouldn't be possible to be less than 1, but just in case so we don't try dividing by zero
        -- the formula from the post below suggests boostPowerPerc should be 50%, 75%, or 100% (this last is OoE for us)
        -- I.E. if you boost everytime with AF gloves, this will make boostPowerPerc = 18.75 * 4 = 75,
        -- but if some or all of your boosts were without AF it will tend towards boostPowerPerc = 12.5 * 4 = 50
        boostPowerPerc = (4 * boostEffect:getPower() / 100) / boostNum
    end
    local rand = math.random(512,1024) / 1024

    -- https://ffxiclopedia.fandom.com/wiki/Chi_Blast
    -- https://www.bluegartr.com/threads/108197-Random-Facts-Thread-Abilities?p=5089420&viewfull=1#post5089420
    -- DMG = floor( floor( MND × Rand ) × ( #Boost × BoostIncrease% + 1 ) )
    local dmg = math.floor(math.floor(mnd * rand) * (boostNum * (boostPowerPerc / 100) + 1))
    -- printf("dmg %u, mnd %u, rand %f, boostNum %u, boostPowerPerc %u", dmg, mnd, rand, boostNum, boostPowerPerc)
    
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

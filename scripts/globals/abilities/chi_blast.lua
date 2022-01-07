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
    local Boosts = player:getLocalVar("BoostCounter")
    local Rand = (math.random(26,60)/100)

    if player:getMod(tpz.mod.BOOST_EFFECT) > 0 then
        Rand = (math.random(75,110)/100)
    end

    local dmg = mnd * (Boosts * Rand + 1)
    
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

-----------------------------------
-- Ability: Mijin Gakure
-- Sacrifices user's life to deal damage to an enemy.
-- Obtained: Ninja Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/monstertpmoves")
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

    local dmg = (player:getHP() * 0.8) + (player:getMainLvl() / 0.5)
    local resist = applyPlayerResistance(player, nil, target, player:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), 0, tpz.magic.ele.NONE)

    dmg = math.floor(dmg * resist)
    
    if (player:hasStatusEffect(tpz.effect.INNIN) and player:isBehind(target, 23)) then
        dmg = math.floor(dmg * 1.3)
    end

    if player:hasStatusEffect(tpz.effect.WEAKNESS) then
        player:delStatusEffect(tpz.effect.WEAKNESS)
    end

    dmg = utils.stoneskin(target, dmg)
    target:takeDamage(dmg, player, tpz.attackType.SPECIAL, tpz.damageType.ELEMENTAL)

    player:setLocalVar("MijinGakure", 1)
    player:setHP(0)
    return dmg
end

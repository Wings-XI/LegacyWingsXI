-----------------------------------
-- Ability: Mantra
-- Increases the max. HP of party members within area of effect.
-- Obtainable: Monk Level 75
-- Recast Time: 0:10:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:delStatusEffect(tpz.effect.MAX_HP_BOOST)

    local boost = (target:getBaseHP() + target:getMod(tpz.mod.HP)) * player:getMerit(tpz.merit.MANTRA)/100
    
    target:addStatusEffect(tpz.effect.MAX_HP_BOOST, math.floor(boost), 0, 180, 0, 0, 1)
end

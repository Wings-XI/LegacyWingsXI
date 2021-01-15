-----------------------------------
-- Ability: Stealth Shot
-- handled in charentity onRangedAttack
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    if player:hasStatusEffect(tpz.effect.FLASHY_SHOT) then
        player:delStatusEffect(tpz.effect.FLASHY_SHOT)
    end
    player:addStatusEffect(tpz.effect.STEALTH_SHOT,1,0,60)
end

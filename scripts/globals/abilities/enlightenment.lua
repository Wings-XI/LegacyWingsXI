-----------------------------------
-- Ability: Enlightenment
-- Your next spell cast may be any from your list regardless of addenda.
-- Obtained: Scholar Level 75
-- Recast Time: 0:05:00
-- Duration: 0:01:00 or 1 Spell, whichever occurs first
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if player:hasStatusEffect(tpz.effect.ENLIGHTENMENT) then
        return tpz.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.ENLIGHTENMENT, 0, 0, 60)
    -- OOE Secondary Merit Buff
    -- local merit = (player:getMerit(tpz.merit.ENLIGHTENMENT) / 15)
    -- if merit > 5 then
    --     player:addStatusEffect(tpz.effect.ENLIGHTENMENT, merit - 5, 0, 60)
    return tpz.effect.ENLIGHTENMENT
end

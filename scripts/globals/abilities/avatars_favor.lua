---------------------------------------------
-- Avatars Favor - Ability
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.AVATAR_S_FAVOR, 1, 10, 7200)
end
-----------------------------------
-- Ability: Retreat
-- Orders the avatar to hold back.
-- Obtained: Summoner Level 1
-- Recast Time: 10 sec
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local petid = player:getPetID()
    if petid ~= tpz.pet.id.ODIN and petid ~= tpz.pet.id.ALEXANDER and petid ~= tpz.pet.id.ATOMOS then
        player:petRetreat()
    end
end

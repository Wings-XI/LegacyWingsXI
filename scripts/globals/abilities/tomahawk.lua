-----------------------------------
-- Ability: Tomahawk
-- Recast Time: 0:03:00
-- Duration: 0:00:30 (+0:00:15 for each merit, cap is 0:01:30)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    if not player:isFacing(target) then
		return 5, target:getID()
	end

    local id = player:getEquipID(tpz.slot.AMMO)
    if (id == 18258) then
        return 0,0
    else
        return tpz.msg.basic.UNABLE_TO_USE_JA,0
    end
end

function onUseAbility(player,target,ability)
    -- special defense down 25%
    if target:getMod(tpz.mod.SPDEF_DOWN) == 0 then
        local duration = 15 + player:getMerit(tpz.merit.TOMAHAWK)
        target:queue(0, function(target)
            target:addMod(tpz.mod.SPDEF_DOWN,25)
        end)
        target:queue(duration*1000, function(target)
            target:setMod(tpz.mod.SPDEF_DOWN,0)
        end)
    end
    target:updateClaim(player)
    player:removeAmmo()
end

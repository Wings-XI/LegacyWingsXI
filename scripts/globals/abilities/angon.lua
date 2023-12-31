-----------------------------------
-- Ability: Angon
-- Expends an Angon to lower an enemy's defense.
-- Obtained: Dragoon Level 75
-- Recast Time: 0:03:00
-- Duration: 0:00:30 (+0:00:15 for each merit, cap is 0:01:30)
-- Effect: Physical defense of target approximately -20% (51/256).
-- Range: 10.0 yalms
-- Notes: Only fails if it can't apply the def down status.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if not player:isFacing(target) then
		return 5, target:getID()
	end

    local id = player:getEquipID(tpz.slot.AMMO)
    if (id == 18259) then
        return 0, 0
    else
        return tpz.msg.basic.UNABLE_TO_USE_JA, 0
    end
end

function onUseAbility(player, target, ability)
    local typeEffect = tpz.effect.DEFENSE_DOWN
    local duration = 15 + player:getMerit(tpz.merit.ANGON) -- This will return 30 sec at one investment because merit power is 15.

    if (target:addStatusEffect(typeEffect, 20, 0, duration) == false) then
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    end

    target:updateClaim(player)
    -- if dragoon's earring equipped, chance to not consume angon
    local preserveAmmoChance = (player:getEquipID(tpz.slot.EAR1) == 16000 or player:getEquipID(tpz.slot.EAR2) == 16000) and 25 or 0
    if math.random(100) >= preserveAmmoChance then
        player:removeAmmo()
    end
    return typeEffect
end

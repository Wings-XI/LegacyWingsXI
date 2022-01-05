-----------------------------------
-- Ability: Blade Bash
-- Deliver an attack that can stun the target and occasionally cause Plague.
-- Obtained: Samurai Level 75
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (not player:isWeaponTwoHanded()) then
        return tpz.msg.basic.NEEDS_2H_WEAPON, 0
    elseif not player:isEngaged() then
        return tpz.msg.basic.REQUIRES_COMBAT, 0
    elseif not player:isFacing(target) then
		return 5, target:getID()
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    -- Stun rate
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if (math.random() < 0.99) then
            target:addStatusEffect(tpz.effect.STUN,1,0,math.random(4,6))
        end
    end
    tryBuildResistance(tpz.mod.RESBUILD_STUN, target)

    --local damage = math.floor(((player:getMainLvl() + 11) / 4) + player:getMod(tpz.mod.WEAPON_BASH))
    --damage = damage * math.random(50,150) / 100

    -- Calculating and applying Blade Bash damage
    --damage = utils.stoneskin(target, damage)
    --target:takeDamage(damage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    --target:updateEnmityFromDamage(player, damage)

    -- Applying Plague based on merit level.
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.VIRUSRES) < 100 then
        if (math.random() < 0.65) then
            target:addStatusEffect(tpz.effect.PLAGUE, 5, 0, 30)
        end
    end

    --ability:setMsg(tpz.msg.basic.JA_DAMAGE)
    ability:setMsg(0)

    return 0
end

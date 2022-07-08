---------------------------------------------------
-- Tidal Wave
---------------------------------------------------
require("/scripts/globals/settings")
require("/scripts/globals/status")
require("/scripts/globals/monstertpmoves")
require("/scripts/globals/magic")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    local level = player:getMainLvl() * 2

    if(player:getMP()<level) then
        return 87, 0
    end

    return 0, 0
end

function onPetAbility(target, pet, skill, master)
    local ele = tpz.damageType.WATER

    local damage = AvatarMagicalMove(pet, target, skill, 0, ele, 0)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, ele, MOBPARAM_WIPE_SHADOWS)
    
    local skillchainTier, skillchainCount = FormMagicBurst(ele - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end

    master:setMP(0)
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, ele)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

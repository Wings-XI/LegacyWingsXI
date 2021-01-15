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
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local eco = target:getSystem()
    local ele = tpz.damageType.WATER
    local coe = getAvatarEcosystemCoefficient(eco, ele)
    local level = pet:getMainLvl()
    local damage = 48 + (level * 8)
    damage = (damage + (dINT * 1.5)) * coe
    damage = MobMagicalMove(pet, target, skill, damage, tpz.magic.ele.WATER, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.WATER)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, 1)
    
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.WATER - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end

    master:setMP(0)
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

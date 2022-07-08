---------------------------------------------------
-- Wind Blade
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 182
    local ele = tpz.damageType.WIND
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local tp = skill:getTP() / 10
    local master = pet:getMaster()
    local merits = 0
    if (master ~= nil and master:isPC()) then
        merits = master:getMerit(tpz.merit.WIND_BLADE)*40
    end

    tp = tp + (merits - 40)
    if (tp > 300) then
        tp = 300
    end

    --note: this formula is only accurate for level 75 - 76+ may have a different intercept and/or slope
    local damage = math.floor((512 + 1.72*(tp+1))*coe)
    damage = math.floor(damage + (dINT * 1.5))
    damage = MobMagicalMove(pet, target, skill, damage, tpz.magic.ele.WIND, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.WIND)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.WIND - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end

    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    target:updateEnmityFromDamage(pet, damage)
    
    pet:getMaster():addMP(-mpCost)
    return damage
end

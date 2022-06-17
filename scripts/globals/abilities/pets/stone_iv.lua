---------------------------------------------------
-- Stone 4
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 118
    local ele = tpz.damageType.EARTH
    local tp = skill:getTP()

    local damage = AvatarMagicalMove(pet, target, skill, tp, ele, 4)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, ele, 1)
    
    local skillchainTier, skillchainCount = FormMagicBurst(ele - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end

    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, ele)
    target:updateEnmityFromDamage(pet, damage)
    
    pet:getMaster():addMP(-mpCost)
    return damage
end

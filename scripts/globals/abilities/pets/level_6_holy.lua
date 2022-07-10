---------------------------------------------------
-- Holy Roll 1
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local mpCost = 235
    if target:getMainLvl() % 6 ~= 0 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    local dMND = math.floor(pet:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local ele = tpz.damageType.LIGHT
    local coe = getAvatarEcosystemCoefficient(target, ele)

    local damage = 1750 * coe * (math.random()*0.2+0.9)
    damage = damage + (dMND * 1.5)
    damage = MobMagicalMove(pet,target,skill,damage,tpz.magic.ele.LIGHT,1,TP_NO_EFFECT,10)
    damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.LIGHT)
    damage = AvatarFinalAdjustments(damage,pet,skill,target,tpz.attackType.MAGICAL,tpz.damageType.LIGHT,1)
    
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.LIGHT - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end
    
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    target:updateEnmityFromDamage(pet,damage)
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return damage
end

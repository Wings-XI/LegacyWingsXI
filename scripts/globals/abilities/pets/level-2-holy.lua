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
    if target:getMainLvl() % 2 ~= 0 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    local dMND = math.floor(pet:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local ele = tpz.damageType.LIGHT
    local coe = getAvatarEcosystemCoefficient(target, ele)

    local damage = 400
    damage = damage + (dMND * 1.5)
    local resist = 1
    local mab = (100 + pet:getMod(tpz.mod.MATT)) / (100 + target:getMod(tpz.mod.MDEF))
    if (mab > 1.3) then
        mab = 1.3
    end
    if (mab < 0.7) then
        mab = 0.7
    end
    local avatarAccBonus = 35
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        local master = pet:getMaster()
        avatarAccBonus = avatarAccBonus + utils.clamp(master:getSkillLevel(tpz.skill.SUMMONING_MAGIC) - master:getMaxSkillLevel(pet:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC), 0, 200) + master:getMerit(1284)
    end
    resist = applyPlayerResistance(pet,nil,target,pet:getStat(tpz.mod.MND)-target:getStat(tpz.mod.MND),avatarAccBonus,tpz.magic.ele.LIGHT)
    if resist < 1 and math.random() < 0.4 then
        resist = 1
    end
    local magicDefense = getElementalDamageReduction(target, tpz.magic.ele.LIGHT)
    damage = damage * resist * magicDefense
    damage = mobAddBonuses(pet, nil, target, damage, tpz.magic.ele.LIGHT)
    damage = AvatarFinalAdjustments(damage,pet,skill,target,tpz.attackType.MAGICAL,tpz.damageType.LIGHT,1)
    
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.LIGHT - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end
    
    damage = damage*1.9 * coe * (math.random()*0.2+0.9)
    
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    target:updateEnmityFromDamage(pet,damage)

    return damage
end

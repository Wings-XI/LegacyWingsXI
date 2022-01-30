---------------------------------------------------
-- Thunderspark M=whatever
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local ele = tpz.damageType.LIGHTNING
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local tp = skill:getTP() / 10
    local master = pet:getMaster()
    local merits = 0
    if (master ~= nil and master:isPC()) then
        merits = master:getMerit(tpz.merit.THUNDERSTORM)
    end

    tp = tp + (merits - 40)
    if (tp > 300) then
        tp = 300
    end

    local damage = math.floor(39 * (1 + 0.211*tp/3000) * coe)
    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(pet,target,skill,damage,tpz.magic.ele.LIGHTNING,1,TP_NO_EFFECT,0)
    damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.LIGHTNING)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, 1)
    
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.LIGHTNING - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end
    
    local dDEX = pet:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.DEX)
    local bonus = dDEX
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet) + 1
    end
    local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHTNING,tpz.skill.ENFEEBLING_MAGIC,bonus)
    local duration = math.ceil(90 * resist * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.PARALYZERES) < 100 then
        if resist >= 0.25 then
            target:delStatusEffect(tpz.effect.PARALYSIS)
            target:addStatusEffect(tpz.effect.PARALYSIS, 25, 0, duration)
        end
    end

    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet,damage)

    return damage
end

---------------------------------------------------
-- Thunderspark M=whatever
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 38
    local ele = tpz.damageType.LIGHTNING
    local tp = skill:getTP()

    local damage = AvatarMagicalMove(pet, target, skill, tp, ele, 2)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, ele, 1)

    if damage > 0 then
        local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHTNING,tpz.skill.ENFEEBLING_MAGIC)
        local duration = math.ceil((90 + 90 * skill:getTP()/3000) * resist * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target))
        if (target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.PARALYZERES) < 100) then
            if (resist >= 0.25 and target:hasStatusEffect(tpz.effect.PARALYSIS) == false) then
                target:addStatusEffect(tpz.effect.PARALYSIS, 25, 0, duration)
            end
        end
    end

    local skillchainTier, skillchainCount = FormMagicBurst(ele - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end

    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet,damage)
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return damage
end

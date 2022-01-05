---------------------------------------------------
-- Crescent Fang
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local ele = tpz.damageType.DARK
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5 * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, numhits)

    if totaldamage > 0 then
        local resist = applyResistanceAbility(pet,target,tpz.magic.element.DARK,tpz.skill.ENFEEBLING_MAGIC,bonus)
        local duration = math.ceil(90 * resist * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target))
        if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.PARALYZERES) < 100 then
            if resist >= 0.5 then
                target:delStatusEffect(tpz.effect.PARALYSIS)
                target:addStatusEffect(tpz.effect.PARALYSIS, 30, 0, duration)
            end
        end
    end

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

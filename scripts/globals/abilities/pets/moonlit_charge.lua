---------------------------------------------------
-- Moonlit Charge M=4
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
    local ele = tpz.damageType.DARK
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = 3 + math.floor(10*skill:getTP()/3000)
    local dmgmod = 4 * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    
    local resist = applyResistanceAbility(pet, target, tpz.magic.element.DARK, tpz.skill.ENFEEBLING_MAGIC, bonus)
    local duration = math.ceil(60 * resist * tryBuildResistance(tpz.mod.RESBUILD_BLIND, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.BLINDRES) < 100 then
        if resist >= 0.5 then
            target:addStatusEffect(tpz.effect.BLINDNESS, 20, 0, duration)
        end
    end
    
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

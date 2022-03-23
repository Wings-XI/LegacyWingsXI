---------------------------------------------------
-- Shock Strike M=3.5
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local ele = tpz.damageType.LIGHTNING
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5 * coe
    local critmod = 1 + math.floor(7*skill:getTP()/3000)
    
    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3, critmod)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    
    local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHTNING,tpz.skill.ENFEEBLING_MAGIC,bonus)
    local duration = math.ceil(5 * resist * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if resist >= 0.25 and totaldamage > 0 then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
        end
    end
    
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

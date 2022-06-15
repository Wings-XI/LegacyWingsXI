---------------------------------------------------
-- Megalith Throw M=5.5 (guesstimated) SLOW
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/magic")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 62
    local ele = tpz.damageType.EARTH
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = -4 + math.floor(20*skill:getTP()/3000)
    local dmgmod = 5.5 * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    
    local dVIT = pet:getStat(tpz.mod.VIT) - target:getStat(tpz.mod.VIT)
    local bonus = dVIT
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet) + 1
    end
    local resist = applyResistanceAbility(pet,target,tpz.magic.element.EARTH,tpz.skill.ENFEEBLING_MAGIC,bonus)
    local duration = math.ceil(120 * resist * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target))
    if resist >= 0.25 and totaldamage > 0 then
        target:addStatusEffect(tpz.effect.SLOW, 1800, 0, duration)
    end
    
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)

    pet:getMaster():addMP(-mpCost)
    return totaldamage
end

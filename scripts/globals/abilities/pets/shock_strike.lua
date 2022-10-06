---------------------------------------------------
-- Shock Strike M=3.5
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
    local mpCost = 6
    local ele = tpz.damageType.LIGHTNING
    local params = {}
    params.str_wsc = 0.15 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.15 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5
    local critmod = 1 + math.floor(7*skill:getTP()/3000)
    local totaldamage = 0

    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3, critmod, params)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    
    if totaldamage > 0 then
        local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHTNING,tpz.skill.ENFEEBLING_MAGIC)
        local duration = math.ceil(5 * resist * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
        if (target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100) then
            if (resist >= 0.25 and target:hasStatusEffect(tpz.effect.STUN) == false) then
                target:addStatusEffect(tpz.effect.STUN, 1200, 0, duration)
            end
        end
    end
    
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)
    
    pet:getMaster():addMP(-mpCost)
    return totaldamage
end

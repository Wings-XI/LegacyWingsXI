---------------------------------------------------
-- Meteorite
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 108
    local ele = tpz.damageType.LIGHT
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local dint = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local dmg = (500 + dint*1.5 + skill:getTP()/20)*coe
    
    local res = applyResistanceAbility(pet, target, tpz.magic.element.LIGHT, 0, -25)
    dmg = dmg * res
    
    local burst = 1.0
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.LIGHT - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)

        if (skillchainCount == 1) then -- two weaponskills
            burst = 1.35
        elseif (skillchainCount == 2) then -- three weaponskills
            burst = 1.45
        elseif (skillchainCount == 3) then -- four weaponskills
            burst = 1.55
        elseif (skillchainCount == 4) then -- five weaponskills
            burst = 1.65
        elseif (skillchainCount == 5) then -- six weaponskills
            burst = 1.75
        elseif (skillchainCount == 6) then -- seven weaponskills
            burst = 1.85
        else
            -- Something strange is going on if this occurs.
            burst = 1.0
        end
    end
    if burst > 1.0 then
        dmg = dmg * (burst + 0.05)
    end
    
    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)

    pet:getMaster():addMP(-mpCost)
    return dmg
end

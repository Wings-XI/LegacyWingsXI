-----------------------------------
-- Ability: Weapon Bash
-- Delivers an attack that can stun the target. Requires Two-handed weapon.
-- Obtained: Dark Knight Level 20
-- Cast Time: Instant
-- Recast Time: 5:00 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return tpz.msg.basic.NEEDS_2H_WEAPON, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)

    if target:getID() == (17449008) then
        return 0
    end
    
    local chance = 110
    
    -- Weapon Bash deals damage dependant of Dark Knight level
    local darkKnightLvl = 1
    if player:getMainJob() == tpz.job.DRK then
        darkKnightLvl = player:getMainLvl()    -- Use Mainjob Lvl
    elseif player:getSubJob() == tpz.job.DRK then
        darkKnightLvl = player:getSubLvl()    -- Use Subjob Lvl
        chance = 80
    end
    
    chance = chance + player:getMainLvl()*2 - target:getMainLvl()*2
    if chance < 33 then
        chance = 33
    elseif chance > 99 then
        chance = 99
    end
    
    tryBuildResistance(tpz.mod.RESBUILD_STUN, target)
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if (math.random()*100 < chance) then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, math.random(4,6))
        end
    end

    -- Calculating and applying Weapon Bash damage
    local damage = math.floor(((darkKnightLvl + 11) / 4) + player:getMod(tpz.mod.WEAPON_BASH))
    
    -- Randomize damage
    local ratio = player:getStat(tpz.mod.ATT)/target:getStat(tpz.mod.DEF)

    if ratio > 2.25 then
        ratio = 2.25
    end

    if ratio < 0.2 then
        ratio = 0.2
    end

    local pdif = math.random(ratio * 0.8 * 1000, ratio * 1.25 * 1000)
    
    damage = damage * (pdif / 1000)
    
    target:takeDamage(damage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)
	
	ability:setMsg(tpz.msg.basic.JA_DAMAGE)

    return damage
end

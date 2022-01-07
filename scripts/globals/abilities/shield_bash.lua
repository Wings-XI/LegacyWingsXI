-----------------------------------
-- Ability: Shield Bash
-- Delivers an attack that can stun the target. Shield required.
-- Obtained: Paladin Level 15, Valoredge automaton frame Level 1
-- Recast Time: 5:00 minute (3:00 for Valoredge version)
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if player:getShieldSize() == 0 then
        return tpz.msg.basic.REQUIRES_SHIELD, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)

    -- Mob IDs That Are Immune to JA Damage
    if target:getID() == (17449008) then
        return 0
    end

    local shieldSize = player:getShieldSize()
    local damage = 0
    local chance = 112
    damage = player:getMod(tpz.mod.SHIELD_BASH)

    if shieldSize == 1 or shieldSize == 5 then
        damage = 25 + damage
    elseif shieldSize == 2 then
        damage = 38 + damage
    elseif shieldSize == 3 then
        damage = 65 + damage
    elseif shieldSize == 4 then
        damage = 90 + damage
    end

    -- Main job factors
    if player:getMainJob() == tpz.job.PLD then
        damage = math.floor(damage)
    else
        damage = math.floor(damage / 2.2)
        chance = 80
    end

    -- Calculate stun proc chance
    if player:getMainJob() == tpz.job.PLD then
        chance = chance + player:getMainLvl()*2 - target:getMainLvl()*2
        if chance < 33 then
            chance = 33
        elseif chance > 99 then
            chance = 99
        end
    else
        chance = chance + player: getSubLvl()*2 - target:getMainLvl()*2
        if chance < 33 then
            chance = 33
        elseif chance > 99 then
            chance = 99
        end
    end

    --print(string.format("chance = %u",chance))
    --print(string.format("player:getMainJob() = %u",player:getMainJob()))
    tryBuildResistance(tpz.mod.RESBUILD_STUN, target)
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if math.random()*100 < chance then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, math.random(4,6))
        end
    end

    -- Randomize damage
    local ratio = player:getStat(tpz.mod.ATT)/target:getStat(tpz.mod.DEF)

    if ratio > 1.9 then
        ratio = 1.9
    end

    if ratio < 0.2 then
        ratio = 0.2
    end

    local pdif = math.random(ratio * 0.8 * 1000, ratio * 1.25 * 1000)

    -- printf("damge %d, ratio: %f, pdif: %d\n", damage, ratio, pdif)

    damage = damage * (pdif / 1000)
    damage = utils.stoneskin(target, damage)
    target:takeDamage(damage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)
    ability:setMsg(tpz.msg.basic.JA_DAMAGE)

    return damage
end
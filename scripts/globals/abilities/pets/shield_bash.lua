---------------------------------------------
--  Shield Bash
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")
require("scripts/globals/magic")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    return 0
end

function onPetAbility(target, automaton, skill, master, action)
    local chance = 0.92
    local damage = (automaton:getSkillLevel(tpz.skill.AUTOMATON_MELEE)/2) + automaton:getMod(tpz.mod.SHIELD_BASH)

    damage = math.floor(damage)

    chance = chance + (automaton:getMainLvl() - target:getMainLvl()) * 0.02
    if chance < 0.4 then
        chance = 0.4
    end
    
    local stunduration = math.random(3,6)
    stunduration = math.ceil(stunduration * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if math.random() < chance then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, stunduration)
        end
    end

    local slowPower = automaton:getMod(tpz.mod.AUTO_SHIELD_BASH_SLOW)
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.SLOWRES) < 100 then
        if slowPower > 0 and math.random() < 0.7 then
            local resist = applyResistanceAbility(automaton, target, tpz.magic.element.EARTH, 0, bonus)
            local duration = 20
            if slowPower == 12 then
                duration = math.random(20, 35)
            elseif slowPower == 19 then
                duration = math.random(51, 57)
            elseif slowPower == 25 then
                duration = math.random(70, 75)
            end
            duration = math.ceil(duration * resist * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target))
            if resist > 0.25 then
                target:addStatusEffect(tpz.effect.SLOW, slowPower * 100, 0, duration)
            end
        end
    end

    -- randomize damage
    local ratio = automaton:getStat(tpz.mod.ATT)/target:getStat(tpz.mod.DEF)
    if ratio > 1.8 then
        ratio = 1.8
    end
    if ratio < 0.2 then
        ratio = 0.2
    end

    local pdif = math.random(ratio*0.8*1000, ratio*1.2*1000)

    damage = damage * (pdif / 1000)

    damage = utils.stoneskin(target, damage)
    target:takeDamage(damage, automaton, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(automaton, damage)
    target:addEnmity(automaton, 450, 900)

    return damage
end

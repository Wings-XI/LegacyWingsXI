---------------------------------------------
-- Cannibal Blade
---------------------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
---------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(tpz.effect.DARK_MANEUVER)
end

function onPetAbility(target, automaton, skill, master, action)
    

    local damage = 60 + automaton:getSkillLevel(tpz.skill.AUTOMATON_MELEE)
    
    damage = target:physicalDmgTaken(automaton, damage, tpz.damageType.SLASHING)
    damage = damage * target:getMod(tpz.mod.SLASHRES) / 1000
    
    if automaton:checkDistance(target) > 7 then
        damage = damage/4
    end
    
    damage = damage - target:getMod(tpz.mod.PHALANX)
    
    damage = utils.stoneskin(target, damage)

    if not target:isUndead() then
        automaton:addHP(damage)
        skill:setMsg(tpz.msg.basic.SKILL_DRAIN_HP)
    end
    
    target:takeDamage(damage, automaton, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    if damage > 0 then
        master:trySkillUp(target, tpz.skill.AUTOMATON_MELEE, 1)
        target:tryInterruptSpell(automaton, 1)
    end
    return damage
end

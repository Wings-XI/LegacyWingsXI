---------------------------------------------
-- Cannibal Blade
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
require("scripts/globals/utils")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local damage = math.random(60,120) + mob:getMainLvl() * 3
    
    damage = target:physicalDmgTaken(damage, tpz.damageType.SLASHING)
    damage = damage * target:getMod(tpz.mod.SLASHRES) / 1000
    
    if mob:checkDistance(target) > 7 then
        damage = damage/4
    end
    
    damage = damage - target:getMod(tpz.mod.PHALANX)
    
    damage = utils.stoneskin(target, damage)

    if not target:isUndead() then
        mob:addHP(damage)
        skill:setMsg(tpz.msg.basic.SKILL_DRAIN_HP)
    end
    
    target:takeDamage(damage, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    if damage > 0 then
        target:tryInterruptSpell(mob, 1)
    end
    return damage
end

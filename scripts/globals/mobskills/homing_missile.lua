---------------------------------------------------
-- Homing Missile
--  Targetted AoE attack.
--  This will deal massive damage (90% of max) to one target, and 200-300 to surrounding targets.
--  You cannot be killed by Homing Missile itself.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
     -- only used if target is in front of the mob
    if (target:isInfront(mob)) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local targetMaxHP = target:getMaxHP()
    local targetCurrentHP = target:getHP()
    local damage = 0
    
    if (mob:getLocalVar("homingMainTarget") == target:getID()) then
        damage = targetMaxHP*0.90
    else
        damage = targetMaxHP*0.25
    end

    -- apparently this move cant kill you
    if (damage > targetCurrentHP) then
        damage = targetCurrentHP - 1
    end
    
    target:takeDamage(damage, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)

    if (mob:getLocalVar("homingMainTarget") == target:getID()) then
        mob:resetEnmity(target)
    end

    return damage
end

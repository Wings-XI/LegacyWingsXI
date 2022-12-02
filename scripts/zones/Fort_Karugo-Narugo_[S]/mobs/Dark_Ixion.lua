-----------------------------------
--  Mob: Dark Ixion
-----------------------------------
require("scripts/globals/events/dark_ixion")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    darkixion.onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    darkixion.onMobDespawn(mob)
end

function onMobInitialize(mob)
    darkixion.onMobInitialize(mob)
end

function onMobSpawn(mob)
    darkixion.onMobSpawn(mob)
end

function onAdditionalEffect(mob, target, damage)
    darkixion.onAdditionalEffect(mob, target, damage)
end

function onMobWeaponSkillPrepare(mob, target)
    darkixion.onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    darkixion.onMobWeaponSkill(target, mob, skill)
end

function onMobRoamAction(mob)
    darkixion.onMobRoamAction(mob)
end

function onMobRoam(mob)
    darkixion.onMobRoam(mob)
end

function onMobEngaged(mob, target)
    darkixion.onMobEngaged(mob, target)
end

function onMobDisengage(mob)
    darkixion.onMobDisengage(mob)
end

function onMobFight(mob, target)
    darkixion.onMobFight(mob, target)
end

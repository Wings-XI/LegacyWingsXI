-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Morbol
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
    mob:speed(140)
end

function onMobDeath(mob, player, isKiller)
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
end

-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Morbol
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
    mob:setMod(tpz.mod.MOVE, 100)
end

function onMobDeath(mob, player, isKiller)
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
end

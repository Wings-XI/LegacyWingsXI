-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Earth Elemental
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 41

function onMobSpawn(mob)
    dynamis.setMobStats(mob)
end

function onMobDeath(mob, player, isKiller)
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
end

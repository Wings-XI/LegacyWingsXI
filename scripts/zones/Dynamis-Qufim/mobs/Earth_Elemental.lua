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
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
end

-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Roc
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 41

function onMobSpawn(mob)
    dynamis.setMobStats(mob)
    mob:setMod(tpz.mod.SLEEPRES, 40)
    mob:setMod(tpz.mod.LULLABYRES, 40)
end

function onMobDeath(mob, player, isKiller)
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
end

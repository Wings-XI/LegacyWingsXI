-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Mauled Murdock
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.PIERCERES, 200)
    mob:setMod(tpz.mod.SLASHRES, 200)
    mob:setMod(tpz.mod.H2HRES, 1500)
    mob:setMod(tpz.mod.IMPACTRES, 1500)
end

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId - 2)
    DespawnMob(mobId - 1)
    DespawnMob(mobId + 1)
end

function onMobDeath(mob, player, isKiller)
end

-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Punctured Percy
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.PIERCERES, 1500)
    mob:setMod(tpz.mod.SLASHRES, 200)
    mob:setMod(tpz.mod.H2HRES, 200)
    mob:setMod(tpz.mod.IMPACTRES, 200)
end

function onMobEngaged(mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId - 3)
    DespawnMob(mobId - 2)
    DespawnMob(mobId - 1)
end

function onMobDeath(mob, player, isKiller)
end

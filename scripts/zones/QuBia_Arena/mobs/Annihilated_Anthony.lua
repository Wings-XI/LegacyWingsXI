-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Annihilated Anthony
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.PIERCERES, 200)
    mob:setMod(tpz.mod.SLASHRES, 200)
    mob:setMod(tpz.mod.H2HRES, 200)
    mob:setMod(tpz.mod.IMPACTRES, 200)
    mob:addMod(tpz.mod.UDMGMAGIC, 20)
end

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
    DespawnMob(mobId + 3)
end

function onMobDeath(mob, player, isKiller)
end

-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Hell Fly
-- BCNM: Infernal Swarm
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobDeath(mob, killer)
end
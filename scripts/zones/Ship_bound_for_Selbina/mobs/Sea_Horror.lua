-----------------------------------
-- Area: Ship bound for Selbina
--  Mob: Sea Horror
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRES, 100)
end

function onMobDeath(mob, player)

end

function onMobDespawn(mob, player)
    mob:setLocalVar("respawnTime", os.time() + 60)
end
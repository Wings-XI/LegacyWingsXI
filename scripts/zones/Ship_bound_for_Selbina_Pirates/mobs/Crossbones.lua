-----------------------------------
-- Area: Ship bound for Selbina (Pirates)
--  Mob: Crossbones
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ROAM_COOL, 8)
end

function onMobDeath(mob, player)

end

function onMobDespawn(mob, player)
    mob:setLocalVar("respawnTime", os.time() + 60)
end
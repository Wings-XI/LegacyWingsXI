-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Coquecigrue
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 532)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(7200, 7800)
    mob:setRespawnTime(respawn) -- 2h to 2h10m 
    SetServerVariable("Coquecigrue_Respawn", (os.time() + respawn))
end

-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Mysticmaker Profblix
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 771, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 772, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 774, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = (7200 + ((math.random(0, 6)) * 300) -- 2:00 to 2:30 hours with 5 minute windows
    mob:setRespawnTime(respawn)
    SetServerVariable("MysticmakerRespawn",(os.time() + respawn))
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9500)
end
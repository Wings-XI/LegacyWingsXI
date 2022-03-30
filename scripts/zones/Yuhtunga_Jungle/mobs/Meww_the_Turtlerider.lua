-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Meww the Turtlerider
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 127, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    local respawn = 75600 + math.random(1, 6) * 600
    mob:setRespawnTime(respawn) -- 21 hrs then 10 min windows
    SetServerVariable("Meww_Turtlerider_Respawn", (os.time() + respawn))
end
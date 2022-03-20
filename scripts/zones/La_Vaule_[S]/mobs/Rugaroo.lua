-----------------------------------
-- Area: La Vaule [S]
--   NM: Rugaroo
-----------------------------------
mixins = {require("scripts/mixins/families/gnole")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 14400
    mob:setRespawnTime(respawn) -- 4 hours
    SetServerVariable("Rugaroo_Respawn", (os.time() + respawn))
end

-----------------------------------
-- Area: Beadeaux [S]
--  Mob: Observant Zekka
-- !pos 128 0.4 161
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 18000
    mob:setRespawnTime(respawn) -- 5 hours
    SetServerVariable("Observant_Zekka_Respawn", (os.time() + respawn))
end
-----------------------------------
-- Area: Riverne-Site_A01
-- Notes: Assists Ouryu in Ouryu Cometh
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 500)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 10)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(120) -- Respawns every 2 minutes, based on in-era video
end
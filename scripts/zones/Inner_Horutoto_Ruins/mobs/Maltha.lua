-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Maltha
-----------------------------------
require("scripts/globals/hunts")

function onMobSpawn(mob)
    -- Has a very strong innate Haste effect, similar to Hundred Fists.
    mob:setMod(tpz.mod.DELAY, 500)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 288)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

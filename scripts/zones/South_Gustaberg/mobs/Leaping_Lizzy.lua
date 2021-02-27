------------------------------
-- Area: South Gustaberg
--   NM: Leaping Lizzy
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMobMod(72, 1)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 200)
end

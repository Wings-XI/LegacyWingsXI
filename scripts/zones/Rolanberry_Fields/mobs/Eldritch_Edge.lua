------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMobMod(72, 1)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 218)
end

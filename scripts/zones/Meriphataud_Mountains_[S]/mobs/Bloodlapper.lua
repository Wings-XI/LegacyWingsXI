------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Bloodlapper
------------------------------
require("scripts/globals/hunts")
------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.LULLABYRES, 100)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 526)
end

------------------------------
-- Area: Tahrongi Canyon
--   NM: Herbage Hunter
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 45)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 259)
end

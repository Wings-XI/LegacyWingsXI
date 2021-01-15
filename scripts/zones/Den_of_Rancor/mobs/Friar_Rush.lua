-----------------------------------
-- Area: Den of Rancor
--   NM: Friar Rush
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/hunts")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 9000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 15000)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 394)
end

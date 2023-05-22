-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Crimson-toothed Pawberry
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 392)
end


function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 18000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 28000)
    -- ensure astral flow pet is not spawned stuck somewhere
    DespawnMob(mob:getID() + 2)
end
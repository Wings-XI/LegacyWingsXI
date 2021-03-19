-----------------------------------
-- Area: Phanauet Channel (1)
--   NM: Vodyanoi
-- !pos -2.0 -3.0 9.6 1
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(43200, 54000)) -- 12 - 15 hours
end

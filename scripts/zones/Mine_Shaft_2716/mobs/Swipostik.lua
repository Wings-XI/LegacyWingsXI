-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: Swipostik
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.ATTP, -75)
end

function onMobDeath(mob, player, isKiller)
end
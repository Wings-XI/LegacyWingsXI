-----------------------------------
-- Area: Apollyon CS
--  Mob: Wootz Quadav
-----------------------------------
mixins = {require("scripts/mixins/job_special")}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobDeath(mob, player, isKiller)
end

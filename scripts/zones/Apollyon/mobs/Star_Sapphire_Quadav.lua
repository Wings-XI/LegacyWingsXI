-----------------------------------
-- Area: Apollyon CS
--  Mob: Star Sapphire Quadav
-----------------------------------
mixins = {require("scripts/mixins/job_special")}

function onMobDeath(mob, player, isKiller)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end
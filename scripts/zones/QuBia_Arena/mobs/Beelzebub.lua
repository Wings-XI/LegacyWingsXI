-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Beelzebub
-- BCNM: Infernal Swarm
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = tpz.jsa.BENEDICTION, hpp = math.random(25, 50) },
        },
    })
end

function onMobDeath(mob, killer)
end